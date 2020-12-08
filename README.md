
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

    - string item_name – name of the object/auctioned item
    - string description – description of the item
    - address public item_owner_address - default will be set to seller, but will be set to highest bidder at end of auction
    - address payable public seller_address - current owner
    - uint256 public start_time - time of start
    - uint256 public end_time - time the contract is supposed to end
    - uint256 public original_end_time - original time the contract is supposed to end
    - uint256 public reserve_price - minimum amount that a seller will accept as the winning bid
    - address payable public current_highest_bidder - the highest bidder at the time
    - uint256 public current_highest_bid - the highest bid at the time
    - bid_record[] public bid_history - bids that have been placed with addresses and bid amount
    - bool ended - Auction status. Default is false. Set to true at end of auction and disallows any further changes.
    - struct bid_record:
        - address bidder_address - address of the person bidding
        - uint256 bid_amount - amount of currency that is being bid
        - uint256 time_placed - time that the bid was placed

 **Functions**

/** 
    Returns information about the item which includes name and description.
    Has helper functions.
*/

```
function viewItem()
function getItemOwnerAddress()
function getName()
function getDescription ()
function getTimeRemaining()
function getBidHistroyCount() //return the record count of bid history
```


/**
    return a bid record by index
    index the index of bid history array
*/
```
function getBidHistoryByIndex(uint256 index)
```

/**
    transfer funds (withdraw the amount) from the buyer address
    transfer it to the seller address 
*/
```
function transferFunds(address payable seller,uint256 cost)
```

/**
    transfer ownership 
    set and transfer the item_owner_address to the buyer address 
*/ 
```
function transferOwnserhip(address buyer)
```

/**
    test function to check if the bidder has enough money to bid
    enough money to bid = highest_bid + 3% of highest bid + transaction cost
*/
```
  function canBid(address payable buyer)
```

/**
    Place a bid on the item. The bid is added to the history of bids list. Incoming bid must be higher than the highest bid otherwise reject the bid. If incoming bid
    is higher than highest bid, then the highest bidder's funds should be released back to he/she and update highest bid.
*/
```
function bid()
```
    
/**
    End the auction and transfer highest bid. 
    This looks at the time and indicates if auction has ended.
*/
```
function endAuction()
```

/**
    Info: If no one placed a bid for the item, the function allows the owner to cancel the auction, ending the contract.
    Condition(s): No bids have happened yet. Auction has not ended yet.
*/
```
function withdrawAuction()
```
  
/**
    Info: This function closes the auction by setting the status of ended to true.
    Condition(s): Auction has not ended yet.
*/
```
function closeAuction()
``` 

