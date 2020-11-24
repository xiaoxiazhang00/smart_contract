// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

contract Auction {
  constructor() public {

  }


   struct item {
     uint id;
     string name;
   }


  function viewItem(item memory x) public {

  }


  function getName(item x) public {

  }


  function getDescription(item x) public {

  }


  function getTimeRemaining(item x) public {

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

  }


  function cancelAuction() public {

  }


  function closeAuction() public {

  }

}

