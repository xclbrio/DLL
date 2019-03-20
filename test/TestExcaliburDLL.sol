pragma solidity >=0.4.25;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/ExcaliburDLL.sol";

contract TestExcaliburDLL{

    ExcaliburDLL tempDLL;
    ////
    // Check initialize
    ////
    
    function testInitialBalanceDeployedContract() public {
        uint expected = 0;
        Assert.balanceEqual(DeployedAddresses.ExcaliburDLL(), expected, "сontract should have 0 balance initially");
    }
  
    ////
    // Check Admin functions
    ////
    
    function testInitialAdminDeployedContract() public {
        ExcaliburDLL dll = ExcaliburDLL(DeployedAddresses.ExcaliburDLL());
        Assert.equal(dll.admin(), tx.origin, "сontract should have true administrator");
    }

    function testChangingTradeState() public {
        ExcaliburDLL dll = ExcaliburDLL(DeployedAddresses.ExcaliburDLL());
        Assert.equal(dll.currentTradeState(), false, "first trade status off on deployed contract");

        ExcaliburDLL newDll = new ExcaliburDLL();
        Assert.equal(newDll.tradeState(), false, "first trade status off");
        Assert.equal(newDll.currentTradeState(), false, "currentTradeState function should return false");
        newDll.changeTradeState(true);
        Assert.equal(newDll.tradeState(), true, "then trade status on ");
        Assert.equal(newDll.currentTradeState(), true, "currentTradeState function should return true");
    }

    function testTransferOwnership() public {
        ExcaliburDLL newDll = new ExcaliburDLL();
        address expected = 0x0000000000000000000000000000000000000000;
        newDll.transferOwnership(expected);
        Assert.equal(newDll.admin(), expected, "has the admin changed");
    }

    ////
    // Check Ex functions
    ////
    
    function testExAddingNew() public {
        tempDLL = new ExcaliburDLL();
        address newExAdr = 0x1000000000000000000000000000000000000000;
        bool connectStatus;
        bool tradeStatus;
        string memory shortName;
        string memory fullName;
        string memory weblink;
        tempDLL.exAddNew(newExAdr, "test_shrt_name", "test_fill_name", "test_weblink.com");
        (connectStatus, tradeStatus, shortName, fullName, weblink) = tempDLL.exchanges_list(newExAdr);
        Assert.equal(connectStatus, false, "at first new Ex have connectStatus - false");
        Assert.equal(tradeStatus, false, "at first new Ex have tradeStatus - false");
        Assert.equal(shortName, "test_shrt_name", "new Ex have true shortName");
        Assert.equal(fullName, "test_fill_name", "new Ex have true fullName");
        Assert.equal(weblink, "test_weblink.com", "new Ex have true weblink");
    }
    
    function testExChangeConnectStatus() public {
        address newExAdr = 0x1000000000000000000000000000000000000000;
        tempDLL.exChangeConnectStatus(newExAdr, true);
        
        bool connectStatus;
        bool tradeStatus;
        string memory shortName;
        string memory fullName;
        string memory weblink;
        (connectStatus, tradeStatus, shortName, fullName, weblink) = tempDLL.exchanges_list(newExAdr);
        Assert.equal(connectStatus, true, "changing Ex connect status to true");
    }
    
    function testExChangeTradeStatus() public {
        address newExAdr = 0x1000000000000000000000000000000000000000;
        tempDLL.exChangeTradeStatus(newExAdr, true);
        
        bool connectStatus;
        bool tradeStatus;
        string memory shortName;
        string memory fullName;
        string memory weblink;
        (connectStatus, tradeStatus, shortName, fullName, weblink) = tempDLL.exchanges_list(newExAdr);
        Assert.equal(tradeStatus, true, "changing Ex trade status to true");
    }
    
    function testExChangeDesc() public {
        address newExAdr = 0x1000000000000000000000000000000000000000;
        tempDLL.exChangeDesc(newExAdr, "new_test_shrt_name", "new_test_fill_name", "new_test_weblink.com");
        
        bool connectStatus;
        bool tradeStatus;
        string memory shortName;
        string memory fullName;
        string memory weblink;
        (connectStatus, tradeStatus, shortName, fullName, weblink) = tempDLL.exchanges_list(newExAdr);
        Assert.equal(shortName, "new_test_shrt_name", "changing Ex shortName be correct");
        Assert.equal(fullName, "new_test_fill_name", "changing Ex trade status must be correct");
        Assert.equal(weblink, "new_test_weblink.com", "changing Ex trade status must be correct");
    }



// contract TestHooks {
//   uint someValue;

//   function beforeEach() {
//     someValue = 5;
//   }

//   function beforeEachAgain() {
//     someValue += 1;
//   }

//   function testSomeValueIsSix() {
//     uint expected = 6;

//     Assert.equal(someValue, expected, "someValue should have been 6");
//   }
// }

// contract TestContract {
//   // Truffle will send the TestContract one Ether after deploying the contract.
//   uint public initialBalance = 1 ether;

//   function testInitialBalanceUsingDeployedContract() {
//     MyContract myContract = MyContract(DeployedAddresses.MyContract());

//     // perform an action which sends value to myContract, then assert.
//     myContract.send(...);
//   }

//   function () {
//     // This will NOT be executed when Ether is sent. \o/
//   }

}
