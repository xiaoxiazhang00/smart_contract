// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.8.0;

contract Auction {
    // (Sort of. See getTimeRemaining function) - Var time_remaining - countdown
    //     - List [] bid_history - bids that have been placed with addresses and bid amount
    //    - Time&Date Start_time - time of start.
    // (Return type is different) - Time&Date end_time - time the contract is supposed to end
    // (same as owner_address right?) - Ethereum address - Auction’s owner’s address
    // (is basically current_highest_bidder after the auction is over right?) - Ethereum address - Item’s owner address
    //     - MinimumBidIncrement - minimum amount to bid (set to 1% of the item's current price)

    string item_name; // Name of the object/auctioned item
    string description; // Description of the item

    address public item_owner_address; // Default will be set to seller, but will be set to highest bidder at end of auction.
    address payable public seller_address; // Owner of item
    uint256 public start_time;
    uint256 public end_time;
    uint256 public original_end_time;
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
        uint256 starting_price
    ) public {
        item_owner_address = _seller_address;
        seller_address = _seller_address;
        start_time = block.timestamp;
        end_time = block.timestamp + auction_duration;
        original_end_time = end_time;
        reserve_price = starting_price;
        ended = false;
        current_highest_bid = 0;
    }

    function viewItem() public view returns (string memory, string memory) {
        // Leads to a page of the item which includes information like name, description, time remaining, bidding history.
        // Has helper functions.
        string memory name = this.getName();
        // string memory conjunction = ": "
        string memory desc = this.getDescription();

        return (name, desc);
    }

    function getItemOwnerAddress() public view returns (address) {
        return item_owner_address;
    }

    function getName() public view returns (string memory) {
        // Function: Returns the name of the item.
        return item_name;
    }

    function getDescription() public view returns (string memory) {
        // Function: Returns description of the item.
        return description;
    }

    function getTimeRemaining() public view returns (uint256) {
        // Condition(s): Auction cannot be over. Auction has not ended.
        // Function: Returns time remaining in the auction.

        require(block.timestamp <= end_time, "Auction has already ended.");
        require(!ended, "Auction has already ended.");

        uint256 time_remaining = end_time - block.timestamp;
        return time_remaining;
    }

    function getBidHistroyCount() public view returns (uint256) {
        return bid_history.length;
    }

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
        return (
            bid_history[index].bidder_address,
            bid_history[index].bid_amount,
            bid_history[index].time_placed
        );
    }

    /* 
        transfer funds (withdraw the amount) from the buyer address
        transfer it to the seller address 
    */

    function transferFunds(
        // address payable buyer,
        address payable seller,
        uint256 cost
    ) public {
        seller.transfer(cost);
        // buyer(this).balance -= cost;

        // seller(this).balance += cost;

        // just an error check
        // if (!buyer.send(cost)) {
        //     return false;
        // }

        // return true;
    }

    function transferOwnserhip(address buyer) public {
        item_owner_address = buyer;
    }

    /*
    test function to check if the bidder has enough money to bid
    */
    function can_bid(address payable buyer) public payable returns (bool) {
        if (msg.value + tx.gasprice > buyer.balance) return true;
        else {
            return false;
        }
    }

    /*
        Place a bid on the item. The bid is added to the history of bids list. Incoming bid must be higher than the highest bid otherwise reject the bid. If incoming bid
        is higher than highest bid, then the highest bidder's funds should be released back to he/she and update highest bid.
    */
    function bid() public payable {
        require(block.timestamp <= end_time, "Auction is over.");

        require(
            msg.value > current_highest_bid,
            // "The current highest bid is: ", current_highest_bid, ". You must place a higher bid"
            "You must place a higher bid."
        );
        require(
            can_bid(msg.sender) == true,
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
        End the auction and transfer highest bid. This looks at the time and 
        indicates if auction has ended
    */
    function endAuction() public {
        require(block.timestamp >= end_time, "Auction not yet ended.");
        require(!ended, "Auction has already ended.");

        if (bid_history.length == 0) {
            closeAuction();
        } else {
            seller_address.transfer(current_highest_bid);
            this.transferOwnserhip(current_highest_bidder);
            closeAuction();
        }
    }

    function addTime() public {
        // Info: The purpose of this function is to prevent someone from stealing the auction by quickly bidding before the end of the auction.
        // Condition(s): The auction has <= 2 minutes remaining. Auction has not ended.
        // Function: Increases the time left for the auction.

        require(
            end_time - block.timestamp <= 120,
            "Not within 2 minutes remaining."
        );
        require(!ended, "Auction has already ended.");

        // Adds an additional minute every time a bid is made when there is less than or equal to 2 minutes remaining.
        uint256 extra_time = 60;
        end_time = end_time + extra_time;
    }

    function cancelAuction() public {
        // Info: If no one placed a bid for the item, the auction should end by itself.
        // Condition(s): Time has past the end time.
        // Function: Delete contract.
        ended = true;
    }

    function closeAuction() public {
        // Info: If the auction extends past the original end time but the seller is satisfied or needs the funds at a specific time, this function allows them to end the auction.
        // Condition(s): An auction continues after the end time. Auction has not ended.
        // Function: Item will be transferred to highest bidder.
        require(
            block.timestamp >= original_end_time,
            "Auction has not passed original end time."
        );
        require(!ended, "Auction has already ended.");

        ended = true;

        //To do: transfer ownership of the item to the highest bidder.
    }

    /*
        Converts uint to string. 
        
        Code taken from: https://github.com/provable-things/ethereum-api/blob/master/oraclizeAPI_0.5.sol#L1045
    */

    function uint2str(uint256 _i)
        internal
        pure
        returns (string memory _uintAsString)
    {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint256 k = len - 1;
        while (_i != 0) {
            bstr[k--] = bytes1(uint8(48 + (_i % 10)));
            _i /= 10;
        }
        return string(bstr);
    }
}
