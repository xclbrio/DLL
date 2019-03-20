pragma solidity >=0.4.25;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/ExcaliburEx.sol";

contract TestExcaliburEx {

    ExcaliburEx tempEx;
    ////
    // Check initialize
    ////
    
    function testInitialBalanceDeployedContract() public {
        uint expected = 0;
        Assert.balanceEqual(DeployedAddresses.ExcaliburEx(), expected, "сontract should have 0 balance initially");
    }
  
    ////
    // Check Admin functions
    ////
    
    function testInitialAdminDeployedContract() public {
        ExcaliburEx ex = ExcaliburEx(DeployedAddresses.ExcaliburEx());
        Assert.equal(ex.admin(), tx.origin, "сontract should have true administrator");
    }

    function testChangingTradeState() public {
        ExcaliburEx newEx = new ExcaliburEx();
        Assert.equal(newEx.tradeState(), false, "first trade status off");
        newEx.changeTradeState(true);
        Assert.equal(newEx.tradeState(), true, "then trade status on ");
    }

    function testSetDllContract() public {
        ExcaliburEx newEx = new ExcaliburEx();
        newEx.setDllContract(0x0000000000000000000000000000000000000001);
        Assert.equal(newEx.dllContract(), 0x0000000000000000000000000000000000000001, "setDllContract function should return true dll contract");
    }
    
    function testTransferOwnership() public {
        ExcaliburEx newEx = new ExcaliburEx();
        address expected = 0x0000000000000000000000000000000000000000;
        newEx.transferOwnership(expected);
        Assert.equal(newEx.admin(), expected, "has the admin changed");
    }

    ////
    // Check Ex functions
    ////
    
    // function testExAddingNew() public {
    //     tempEx = new ExcaliburEx();
    //     address newExAdr = 0x1000000000000000000000000000000000000000;
    //     bool connectStatus;
    //     bool tradeStatus;
    //     string memory shortName;
    //     string memory fullName;
    //     string memory weblink;
    //     tempDLL.exAddNew(newExAdr, "test_shrt_name", "test_fill_name", "test_weblink.com");
    //     (connectStatus, tradeStatus, shortName, fullName, weblink) = tempDLL.exchanges_list(newExAdr);
    //     Assert.equal(connectStatus, false, "at first new Ex have connectStatus - false");
    //     Assert.equal(tradeStatus, false, "at first new Ex have tradeStatus - false");
    //     Assert.equal(shortName, "test_shrt_name", "new Ex have true shortName");
    //     Assert.equal(fullName, "test_fill_name", "new Ex have true fullName");
    //     Assert.equal(weblink, "test_weblink.com", "new Ex have true weblink");
    // }
    
}
