// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.8.0;

contract Auction {

    string public item_name; // Name of the object/auctioned item
    string public description; // Description of the item

    address public item_owner_address; // Default will be set to seller, but will be set to highest bidder at end of auction.
    address payable public seller_address; // Owner of item
    uint256 public start_time; // start of the auction 
    uint256 public end_time; // end of auction(may be affected by bids)
    uint256 public original_end_time; // original end of auction
    uint256 public reserve_price; // Minimum amount that a seller will accept as the winning bid

    // Current state of the auction.
    address payable public current_highest_bidder;
    uint256 public current_highest_bid;

    bool ended; // Auction status. Default is false. Set to true at end of auction and disallows any further changes.
    struct bid_record {
        address bidder_address;
        uint256 bid_amount;
        uint256 time_placed;
    }

    bid_record[] public bid_history;

    constructor(
        uint256 auction_duration,
        address payable _seller_address,
        uint256 starting_price,
        string memory _item_name,
        string memory _description
    ) {
        item_owner_address = _seller_address;
        seller_address = _seller_address;
        start_time = block.timestamp;
        end_time = block.timestamp + auction_duration;
        original_end_time = end_time;
        reserve_price = starting_price;
        current_highest_bid = starting_price;
        ended = false;
        item_name = _item_name;
        description = _description;
    }


    /*
        Condition(s): Auction cannot be over. Auction has not ended.
        Function: Returns time remaining in the auction.
    */
    function getTimeRemaining() public view returns (uint256) {

        require(block.timestamp <= end_time, "Auction has already ended.");
        require(!ended, "Auction has already ended.");

        uint256 time_remaining;
        if (end_time >= block.timestamp)
        {
            time_remaining = end_time - block.timestamp;
        }
        else
        {
            time_remaining = 0;
        }
        
        return time_remaining;
    }

    /*
        return the record count of bid history
    */
    function getBidHistoryCount() public view returns (uint256) {
        return bid_history.length;
    }

    /*
        return a bid record by index
        index the index of bid history array
    */
    function getBidHistoryByIndex(uint256 index)
    public
    view
    returns (
        address,
        uint256,
        uint256
    )
    {
        // ;
        require(index < bid_history.length, "Index out of range.");
        return (
        bid_history[index].bidder_address,
        bid_history[index].bid_amount,
        bid_history[index].time_placed
        );
    }

   /* 
        transfer ownership 
        set and transfer the item_owner_address to the buyer address 
    */
    function transferOwnership(address buyer) private {
        item_owner_address = buyer;
    }

    /*
    test function to check if the bidder has enough money to bid
    enough money to bid = highest_bid + 3% of highest bid + transaction cost
    */
    function canBid(address payable buyer) public payable returns (bool) {
        if (current_highest_bid + (current_highest_bid / 100) * 3 + tx.gasprice < buyer.balance)
        {
            return true;
        }
        else {
            return false;
        }
    }

    /*
        Place a bid on the item. The bid is added to the history of bids list. Incoming bid must be higher than the highest bid otherwise reject the bid. If incoming bid
        is higher than highest bid, then the highest bidder's funds should be released back to he/she and update highest bid.
    */
    function bid() c payable {
        require(
            ended == false,
            "Auction is over.");

        require(
            block.timestamp <= end_time,
            "Auction is over."
        );

        require(
            msg.value > (current_highest_bid + (current_highest_bid/100) * 3),
            "You must place a higher bid."
        );

        require(
            canBid(msg.sender) == true,
            "You do not have sufficient balance."
        );

        /*
            msg.sender (address payable): sender of the message (current call)
            msg.value (uint): number of wei sent with the message
        */
        bid_record storage new_bid;
        new_bid.bidder_address = msg.sender;
        new_bid.time_placed = block.timestamp;
        new_bid.bid_amount = msg.value;

        bid_history.push(new_bid);

        /*
            Prevent someone from stealing the auction by quickly bidding before the end of the auction.
            Increases the time left(1 minute) for the auction if someone place bid during the last 2 minutes
        */
        if (end_time - block.timestamp <= 120) {
            end_time = end_time + 60;
        }
        if (current_highest_bid == 0) {
            current_highest_bid = msg.value;
            current_highest_bidder = msg.sender;
        } else {
            current_highest_bidder.transfer(address(this).balance);
            current_highest_bidder = msg.sender;
            current_highest_bid = msg.value;
        }
    }

    /*
        End the auction and transfer highest bid. 
        This looks at the time and indicates if auction has ended.
    */
    function endAuction() public {
        require(block.timestamp >= end_time, "Auction not yet ended.");
        require(!ended, "Auction has already ended.");

        if (bid_history.length == 0) {
            closeAuction();
        } else {
            seller_address.transfer(current_highest_bid);
            transferOwnership(current_highest_bidder);
            closeAuction();
        }
    }

    /*
        Info: If no one placed a bid for the item, the function allows the owner to cancel the auction, ending the contract.
        Condition(s): No bids have happened yet. Auction has not ended yet.
    */
    function withdrawAuction() public {
        require(bid_history.length == 0, "A bid has been placed. No Cancelling.");
        require(!ended, "Auction has already ended.");

        end_time = block.timestamp;
        closeAuction();
    }


    /*
        Info: This function closes the auction by setting the status of ended to true.
        Condition(s): Auction has not ended yet.
    */
    function closeAuction() private {
        require(!ended, "Auction has already ended.");

        ended = true;
    }

    /*
        View your own balance.
    */
    function returnBalance() public view returns (uint) {
        return msg.sender.balance;
    }

    /*
        Function exclusively for testing. Allows us to test endAuction by making end_time = the current time to not hit the error case caused by time remaining.
    */
    function testEnd() public{
        end_time = block.timestamp;
    }
}


    // /*
    //     Returns information about the item which includes name and description.
    //     Has helper functions.
    // */
    // function viewItem() public view returns (string memory, string memory) {
    //     string memory name = this.getName();
    //     // string memory conjunction = ": "
    //     string memory desc = this.getDescription();

    //     return (name, desc);
    // }

    /*
        Function: Returns the address of the item's owner.
    */
    // function getItemOwnerAddress() public view returns (address) {
    //     return item_owner_address;
    // }

    /*
        Function: Returns the name of the item.
    */
    // function getName() public view returns (string memory) {
    //     return item_name;
    // }

    /*
        Function: Returns description of the item.
    */
    // function getDescription() public view returns (string memory) {
    //     return description;
    // }

    /* 
        transfer funds (withdraw the amount) from the buyer address
        transfer it to the seller address 
    */

    // function transferFunds(
    // // address payable buyer,
    //     address payable seller,
    //     uint256 cost
    // ) public {
    //     seller.transfer(cost);
    //     // buyer(this).balance -= cost;

    //     // seller(this).balance += cost;

    //     // just an error check
    //     // if (!buyer.send(cost)) {
    //     //     return false;
    //     // }

    //     // return true;
    // }
    