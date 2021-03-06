
=======
# Smart Contract: Auction

## Table of Contents
* [Group Members](#group-members)
* [Purpose of Contract](#purpose-of-contract)
* [Interface of Contract with function and event headers](#interface-of-contract-with-function-and-event-headers)
* [Member Contributions](#member-contributions) 

## Group Members
- Muskan Kapoor(Muskan.kapoor75@myhunter.cuny.edu) 
- Rinchen Lama(rinchenlama0075@gmail.com)
- Xiaoxia Zhang(xiaoxiazhang00@gmail.com)
- Jeremy Chen(jeremy.chen69@myhunter.cuny.edu)
- Leman Yan(Leman.Yan80@Myhunter.cuny.edu)

## Purpose of Contract
### Summary
A host of an item will execute the smart contract (auction) everytime they want to auction off an item. 
The auction will have a time limit. The contract has a description of the item and the address of the current owner. 
Anyone can bid for the item, and the highest bidder will get the item. The ownership will move to the new owner via Eth address.
We are doing one contract per item. 
 
## Interface of Contract with function and event headers

**Item Attributes/Variables**

    - string public item_name – name of the object/auctioned item
    - string public description – description of the item
    - address public item_owner_address - default will be set to seller, but will be set to highest bidder at end of auction
    - address payable public seller_address - current owner
    - uint256 public start_time - time of start
    - uint256 public end_time - time the contract is supposed to end
    - uint256 public original_end_time - original time the contract is supposed to end
    - uint256 public reserve_price - minimum amount that a seller will accept as the winning bid
    - address payable public current_highest_bidder - the highest bidder at the time
    - uint256 public current_highest_bid - the highest bid at the time
    - bool ended - Auction status. Default is false. Set to true at end of auction and disallows any further changes.
    - bid_record[] public bid_history - bids that have been placed with addresses and bid amount
    - struct bid_record:
        - address bidder_address - address of the person bidding
        - uint256 bid_amount - amount of currency that is being bid
        - uint256 time_placed - time that the bid was placed

 **Functions**

/** 
    Condition(s): Auction cannot be over. Auction has not ended.
    Function: Returns time remaining in the auction.
*/
```
function getTimeRemaining() public
```

/**
    return the record count of bid history
*/
```
function getBidHistoryCount() public
```

/**
    return a bid record by index
    index the index of bid history array
*/
```
function getBidHistoryByIndex(uint256 index) public
```

/**
    transfer ownership 
    set and transfer the item_owner_address to the buyer address 
*/ 
```
function transferOwnserhip(address buyer) private
```

/**
    test function to check if the bidder has enough money to bid
    enough money to bid = highest_bid + 3% of highest bid + transaction cost
*/
```
function canBid(address payable buyer) public
```

/**
    Place a bid on the item. The bid is added to the history of bids list. Incoming bid must be higher than the highest bid otherwise reject the bid. If incoming bid
    is higher than highest bid, then the highest bidder's funds should be released back to he/she and update highest bid.
*/
```
function bid() public
```
    
/**
    End the auction and transfer highest bid. 
    This looks at the time and indicates if auction has ended.
*/
```
function endAuction() public 
```

/**
    Info: If no one placed a bid for the item, the function allows the owner to cancel the auction, ending the contract.
    Condition(s): No bids have happened yet. Auction has not ended yet.
*/
```
function withdrawAuction() public 
```
  
/**
    Info: This function closes the auction by setting the status of ended to true.
    Condition(s): Auction has not ended yet.
*/
```
function closeAuction() private
``` 

/**
    View your own balance.
*/
```
function returnBalance() public 
```
## Member Contributions
### Leman
1. Worked on member variables, constructor, returnBalance and bid function
2. Deployed contract in Remix to test the contract works and fixed code issues: getTimeRemaining, canBid, endAuction
### Rinchen
1. Worked on transferOwnership, canBid function and some other helper functions
2. debugged code and discussed code issues with all team members to make sure all functions were doing what they needed to do
3. unsucessfully tried to deploy on remix
### Xiaoxia
1. Setup and manage the git project, help on code review, fix compiler error, make sure everything compiles before checked in
2. Worked on maintaining bid_history, and auto-extend bid time features in bid function
### Muskan
1. Involved with all team members throughout the process to make sure all steps (planning, coding, code reviews) is successful
2. Implemeted endAuction, transferOwnership, sendFunds (this function was part of the original plan)
3. worked on updating some member varaibles, added some function descriptions and readme updates
### Jeremy
1. Implemented the original planned member variables(later adjusted) and first version of the constructor(later expanded upon).
2. Implemented the bid_record structure, getTimeRemaining(), withdrawAuction(), closeAuction().
3. Debugged sections of code written by other group members.
4. Updated the ReadME file to display all current functions and declared variables.

