<<<<<<< Updated upstream
# smart_contract
=======
# Smart Contract: Auction

## Table of Contents
* [Group Members](#group-members)
* [Purpose of Contract](#purpose-of-contract)
* [Interface of Contract with function and event headers](#interface-of-contract-with-function-and-event-headers)

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

    - string Name – name of the object/auctioned item
    - string Description – description of the item
    - Var time_remaining - countdown
    - Address owner_address - current owner
    - Float price - minimum_price/marked_by_seller
    - Float current_highest_bid - the highest bid at the time
    - Address current_highest_bidder - the highest bidder at the time
    - List [] bid_history - bids that have been placed with addresses and bid amount
    - Time&Date Start time - time of start
    - Time&Date End time - time the contract is supposed to end
    - Ethereum address - Auction’s owner’s address
    - Ethereum address - Item’s owner address
    - MinimumBidIncrement - minimum amount to bid (set to 1% of the item's current price)

 **Functions**

/** View Item Function leads to a page of the item which includes information like name, description, time remaining, bidding history. 
Has helper functions
*/

```
View Item (item x)
function getName (item x)
function getDescription (item x)
function getTimeRemaining (item x)
Function getBiddingHistory (item x) //Displays bidding history which is a list of outbidded prices with timestamps. 
```
/**
	Transfer ownership of the item from the auction owner to the new owner. The new owner’s Ethereum address will be listed as the owner.
*/ 
```
function transferOwnership (address x, address y, item x)
```
    
/**
	Send funds for the item to the auction owner
*/
```
function sendFunds (address x, address y, long double cost)
```

/**
	Place a bid on the item. The bid is added to the history of bids list. 
*/
```
function Bid (item x, address bidder, long double bid_amount)
```
    
/**
    Ends the auction only accessible by the selling party *immediately ends the auction. 
*/
```
function end_auction()
```

/**
    (in the last TBD minutes of an auction) called everytime a bid is placed if the auction is about to end and increases the time left for the auction
*/
``` 
function add_time() 
``` 

/**
    If no one placed a bid for the item, the auction should end by itself. Time has past the end time. Delete contract.
*/
```
function cancelAuction()
```
  
/**
    Only happens if an auction continues after the end time and owner wants to end the auction. Item will be transferred to highest bidder. 
*/
```
function closeAuction()
``` 
>>>>>>> Stashed changes
