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
    
}
