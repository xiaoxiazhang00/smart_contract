// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

contract Auction {
    // (X) - string Name – name of the object/auctioned item
    // (X) - string Description – description of the item
    // (Sort of. See getTimeRemaining function) - Var time_remaining - countdown
    // (X) - Address owner_address - current owner
    // (X) - Float price - minimum_price/marked_by_seller
    // (Return type is different) - Float current_highest_bid - the highest bid at the time
    // (X) - Address current_highest_bidder - the highest bidder at the time
    //     - List [] bid_history - bids that have been placed with addresses and bid amount
    //    - Time&Date Start_time - time of start.
    // (Return type is different) - Time&Date End_time - time the contract is supposed to end
    // (same as owner_address right?) - Ethereum address - Auction’s owner’s address
    // (is basically current_highest_bidder after the auction is over right?) - Ethereum address - Item’s owner address
    //     - MinimumBidIncrement - minimum amount to bid (set to 1% of the item's current price)




    address payable public seller_address;
    uint public End_time;
    unit public price;

    // Current state of the auction.
    address public current_highest_bidder;
    uint public current_highest_bid;

    // Set to true at the end, disallows any change.
    // By default initialized to `false`.
    bool ended;

    constructor() public {
        
    }

    constructor(
        uint auction_Duration,
        address payable _seller_address
        uint starting_price
    ) public {
        seller_address = _seller_address;
        End_time = now + auction_Duration;
        price = starting_price;
    }


    struct item {
        uint id;
        string name;
        string description;
    }

    struct bid {
        address public bidder_address;
        uint public bid_amount;
        uint public Time_placed;
    }


    function viewItem(item memory x) public {
        // Leads to a page of the item which includes information like name, description, time remaining, bidding history.
        // Has helper functions.
    }


    function getName(item x) public {
        // Function: Returns the name of the item.

        return x.name;
    }


    function getDescription(item x) public {
        // Function: Returns description of the item.

        return x.description;
    }


    function getTimeRemaining(item x) public {
        // Condition(s): Auction cannot be over.
        // Function: Returns time remaining in the auction.

        require(
            now <= auctionEndTime,
            "Auction already ended."
        );
        uint time_remaining = End_time - now;
        return time_remaining;
    }


    function getBiddingHistory(item x) public {
        //Displays bidding history which is a list of outbidded prices with timestamps.
    }


    function transferOwnership(address x, address y, item x) public {

    }


    function sendFunds(address x, address y, fixed128x10 cost) public {

    }


    function Bid(item x, address bidder, fixed128x10 memory bid_amount) public {

    }


    function endAuction() public {

    }


    function addTime() public {
        // Info: The purpose of this function is to prevent someone from stealing the auction by quickly bidding before the end of the auction.
        // Condition(s): Only called in the last TBD minutes of an auction
        // Function: Increases the time left for the auction.
        
        uint extra_time = 2; // (D) Putting TBD would not work in testing so 2 is a placeholder rn.
        End_time = End_time + extra_time;
    }


    function cancelAuction() public {
        // Info: If no one placed a bid for the item, the auction should end by itself. 
        // Condition(s): Time has past the end time. 
        // Function: Delete contract.

    }


    function closeAuction() public {
        // Info: 
        // Condition(s): Only happens if an auction continues after the end time and owner wants to end the auction. 
        // Function: Item will be transferred to highest bidder. 

    }

}

