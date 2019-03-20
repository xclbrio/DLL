pragma solidity >=0.4.25;

import "./SafeMath.sol";
import "./ExcaliburDLL.sol";


// Ex SC for Decentralized Liquidity Layer (DLL)
// prototype from 01.27.19 (without tradeBalances)
contract ExcaliburEx {

    address public admin;
    address public dllContract;
    bool public tradeState;
    
    mapping (address => mapping (address => uint)) public tokens; // mapping of token addresses to mapping of account balances (token=0 means Ether)
    
    constructor() public {
        admin = msg.sender;
    }
    
    modifier onlyAdmin {
        require(msg.sender == admin);
        _;
    }
    
    modifier tradeIsOpen {
        require(tradeState);
        _;
    }
    
    ////
    // Admin functions
    ////
    
    function transferOwnership(address newAdmin) public onlyAdmin {
        admin = newAdmin;
    }

    function changeTradeState(bool state_) public onlyAdmin {
        tradeState = state_;
    }
    
    function setDllContract(address _dllContract) public onlyAdmin {
        dllContract = _dllContract;
    }
    
    ////
    // Token functions
    ////
    
    function deposit() payable public tradeIsOpen {
        // tokens[0][msg.sender] = safeAdd(tokens[0][msg.sender], msg.value);
        // Deposit(0, msg.sender, msg.value, tokens[0][msg.sender]);
    }

    function withdraw(uint amount) public {
        // if (tokens[0][msg.sender] < amount) throw;
        // tokens[0][msg.sender] = safeSub(tokens[0][msg.sender], amount);
        // if (!msg.sender.call.value(amount)()) throw;
        // Withdraw(0x0000000000000000000000000000000000000000, msg.sender, amount, tokens[0][msg.sender]);
    }

    function depositToken(address token, uint amount) public tradeIsOpen {
        // if (token==0) throw;
        // if (!Token(token).transferFrom(msg.sender, this, amount)) throw;
        // tokens[token][msg.sender] = safeAdd(tokens[token][msg.sender], amount);
    }

    function withdrawToken(address token, uint amount) public {
        // if (token==0) throw;
        // if (tokens[token][msg.sender] < amount) throw;
        // tokens[token][msg.sender] = safeSub(tokens[token][msg.sender], amount);
        // if (!Token(token).transfer(msg.sender, amount)) throw;
        // Withdraw(token, msg.sender, amount, tokens[token][msg.sender]);
    }
    
    function balanceOf(address token, address user) public returns (uint) {
        return tokens[token][user];
    }
    
    ////
    // Trade functions
    ////
    
    function callOrder(address tokenGet, uint amountGet, address tokenGive, uint amountGive) public {
        ExcaliburDLL dll = ExcaliburDLL(dllContract);
        require(dll.order(tokenGet, amountGet, tokenGive, amountGive, admin));
    }

    function callTrade(address tokenGet, uint amountGet, address tokenGive, uint amountGive, uint amount) public {
        ExcaliburDLL dll = ExcaliburDLL(dllContract);
        require(dll.trade(tokenGet, amountGet, tokenGive, amountGive, admin, msg.sender, amount));
    }
    
    function callCancelOrder(address tokenGet, uint amountGet, address tokenGive, uint amountGive) public {
        ExcaliburDLL dll = ExcaliburDLL(dllContract);
        require(dll.cancelOrder(tokenGet, amountGet, tokenGive, amountGive, admin));
  }
}
