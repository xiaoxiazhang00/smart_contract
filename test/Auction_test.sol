pragma solidity >=0.4.22 <0.8.0;
import "remix_tests.sol"; // this import is automatically injected by Remix.
import "remix_accounts.sol";
import "../github/xiaoxiazhang00/smart_contract/contracts/Auction.sol";

// File name has to end with '_test.sol', this file can contain more than one testSuite contracts
contract testSuite {
    uint256 auction_duration;
    address payable _seller_address;
    uint256 starting_price;
    string  _item_name;
    string  _descripton;
    
    /// 'beforeAll' runs before all other tests
    /// More special functions are: 'beforeEach', 'beforeAll', 'afterEach' & 'afterAll'
    function beforeAll() public {
        // Here should instantiate tested contract
        auction_duration = 10;
        _seller_address = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
        starting_price = 10;
        _item_name = "Car";
        _descripton = "Vintage car";
        
        Auction auctionOne = new Auction(auction_duration, _seller_address, starting_price, _item_name,
        _descripton);

    }

    function checkSuccess() public {
        // Use 'Assert' to test the contract, 
        // See documentation: https://remix-ide.readthedocs.io/en/latest/assert_library.html
         Assert.equal(uint(2), uint(2), "2 should be equal to 2");
        // Assert.notEqual(uint(2), uint(3), "2 should not be equal to 3");
        // log0(auctionOne.item_name());
               uint256 _id = 0x420042;
        log3(
            bytes32(_id),
            bytes32(_id),
            bytes32(_id),
            bytes32(_id)
        ); 
    }

    // function checkSuccess2() public pure returns (bool) {
    //     // Use the return value (true or false) to test the contract
    //     return true;
    // }
    
    // function checkFailure() public {
    //     Assert.equal(uint(1), uint(2), "1 is not equal to 2");
    // }

    // /// Custom Transaction Context
    // /// See more: https://remix-ide.readthedocs.io/en/latest/unittesting.html#customization
    // /// #sender: account-1
    // /// #value: 100
    // function checkSenderAndValue() public payable {
    //     // account index varies 0-9, value is in wei
    //     Assert.equal(msg.sender, TestsAccounts.getAccount(1), "Invalid sender");
    //     Assert.equal(msg.value, 100, "Invalid value");
    // }
}
