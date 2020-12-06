// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

contract Auction {
    // (Sort of. See getTimeRemaining function) - Var time_remaining - countdown
    //     - List [] bid_history - bids that have been placed with addresses and bid amount
    //    - Time&Date Start_time - time of start.
    // (Return type is different) - Time&Date end_time - time the contract is supposed to end
    // (same as owner_address right?) - Ethereum address - Auction’s owner’s address
    // (is basically current_highest_bidder after the auction is over right?) - Ethereum address - Item’s owner address
    //     - MinimumBidIncrement - minimum amount to bid (set to 1% of the item's current price)

    string item_name;    // Name of the object/auctioned item
    string description; // Description of the item

    address public item_owner_address; // Default will be set to seller, but will be set to highest bidder at end of auction.
    address payable public seller_address; // Owner of item
    uint public start_time; 
    uint public end_time;
    uint public original_end_time;
    unit public reserve_price; // Minimum amount that a seller will accept as the winning bid

    // Current state of the auction.
    address public current_highest_bidder;
    uint public current_highest_bid;

    bool ended; // Auction status. Default is false. Set to true at end of auction and disallows any further changes.

    struct bid {
        address public bidder_address;
        uint public bid_amount;
        uint public time_placed;
    }
  
  
    constructor(
        uint auction_duration,
        address payable _seller_address
        uint starting_price
    ) public {
        item_owner_address = _seller_address;
        seller_address = _seller_address;
        start_time = block.timestamp;
        end_time = block.timestamp + auction_duration;
        original_end_time = end_time
        reserve_price = starting_price;
        ended = false;
    }




    function viewItem() public {
        // Leads to a page of the item which includes information like name, description, time remaining, bidding history.
        // Has helper functions.
    }


    function getName() public {
        // Function: Returns the name of the item.

        return item_name;
    }


    function getDescription() public {
        // Function: Returns description of the item.

        return description;
    }


    function getTimeRemaining() public {
        // Condition(s): Auction cannot be over. Auction has not ended.
        // Function: Returns time remaining in the auction.

        require(block.timestamp <= end_time,"Auction has already ended.");
        require(!ended, "Auction has already ended.");

        uint time_remaining = end_time - block.timestamp;
        return time_remaining;
    }


    function getBiddingHistory() public {
        //Displays bidding history which is a list of outbidded prices with corresponding addresses.
        
    }


    function transferOwnership(address x, address y) public {

    }


    function sendFunds(address x, address y, fixed128x10 cost) public {

    }

    /*
        Place a bid on the item. The bid is added to the history of bids list. Incoming bid must be higher than the highest bid otherwise reject the bid. If incoming bid 
        is higher than highest bid, then the highest bidder's funds should be released back to he/she and update highest bid. 
    */
    function bid public payable (address bidder, fixed128x10 memory bid_amount) public {

    }


    function endAuction() public {
        require(block.timestamp >=  end_time; "Auction not yet ended.");
        require(!ended, "Auction has already ended.");

 
        ended = true;
        seller_address.transfer(current_highest_bid);
    }


    function addTime() public {
        // Info: The purpose of this function is to prevent someone from stealing the auction by quickly bidding before the end of the auction.
        // Condition(s): The auction has <= 2 minutes remaining. Auction has not ended.
        // Function: Increases the time left for the auction.
        
        require(end_time - block.timestamp <= 120,"Not within 2 minutes remaining.");
        require(!ended, "Auction has already ended.");

        // Adds an additional minute every time a bid is made when there is less than or equal to 2 minutes remaining.
        uint extra_time = 60;
        end_time = end_time + extra_time;
    }


    function cancelAuction() public {
        // Info: If no one placed a bid for the item, the auction should end by itself. 
        // Condition(s): Time has past the end time. 
        // Function: Delete contract.

    }


    function closeAuction() public {
        // Info: If the auction extends past the original end time but the seller is satisfied or needs the funds at a specific time, this function allows them to end the auction.
        // Condition(s): An auction continues after the end time. Auction has not ended.
        // Function: Item will be transferred to highest bidder. 

        require(block.timestamp >= original_end_time,"Auction has not passed original end time.");
        require(!ended, "Auction has already ended.");

        ended = true;
        
        //To do: transfer ownership of the item to the highest bidder.
    }

}