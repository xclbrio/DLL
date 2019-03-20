pragma solidity >=0.4.25;

import "./SafeMath.sol";


contract AbstractExcaliburDLL {
    function order(address tokenGet, uint amountGet, address tokenGive, uint amountGive, address exchange) public returns(bool) {
    }
    function trade(address tokenGet, uint amountGet, address tokenGive, uint amountGive, address exchange, address user, uint amount) public returns(bool) {
    }
    function cancelOrder(address tokenGet, uint amountGet, address tokenGive, uint amountGive, address exchange) public returns(bool) {
    }
}

// Decentralized Liquidity Layer (DLL)
// prototype from 02.10.19
contract ExcaliburDLL is AbstractExcaliburDLL {
    address public admin;
    bool public tradeState;
    struct exchangeInfo {
        bool connectStatus;
        bool tradeStatus;
        string shortName;
        string fullName;    
        string webLink;  
    }
    
    mapping (address => exchangeInfo) public exchanges_list; // list of exchanges connected to DLL
    mapping (address => mapping (address => mapping (bytes32 => bool))) public orders; // orders[exchange_adress][user_adress][hash]
    mapping (address => mapping (address => mapping (bytes32 => uint))) public orderFills; // orderFills[exchange_adress][user_adress][count_of_currency]
    
    event Order(address tokenGet, uint amountGet, address tokenGive, uint amountGive, address exchange, address maker, bytes32 hash);
    event Cancel(address tokenGet, uint amountGet, address tokenGive, uint amountGive, uint expires, uint nonce, address exchange, address user, uint8 v, bytes32 r, bytes32 s, bytes32 hash, string pair);
    event Trade(address tokenGet, uint amountGet, address tokenGive, uint amountGive, address exchange, address get, address give, bytes32 hash, string pair);

    modifier onlyAdmin {
        require(msg.sender == admin);
        _;
    }
    
    modifier tradeIsOpen {
        require(tradeState);
        _;
    }
    
    modifier exIsConnected {
        require(exchanges_list[msg.sender].connectStatus);
        _;
    }
    
    constructor() public{
        admin = msg.sender;
    }
    
    ////
    // Admin functions
    ////
    function transferOwnership(address newAdmin) public onlyAdmin {
        admin = newAdmin;
    }

    function changeTradeState(bool newTradeState) public onlyAdmin {
        tradeState = newTradeState;
    }
    
    function currentTradeState() public returns(bool) {
        return tradeState;
    }
    
    // only alpha
    function kill() public onlyAdmin {
       // selfdestruct(admin);
    }
    
    ////
    // Ex functions
    ////

    function exAddNew(address exchange, string memory changeShortName, string memory changeFullname, string memory changeWeblink) public onlyAdmin {
        exchanges_list[exchange].shortName = changeShortName;
        exchanges_list[exchange].fullName = changeFullname;
        exchanges_list[exchange].webLink = changeWeblink;
    }
    
    
    function exChangeConnectStatus(address exchange, bool changeConnectStatus) public onlyAdmin {
        exchanges_list[exchange].connectStatus = changeConnectStatus;
    }
    
    function exChangeTradeStatus(address exchange, bool changeTradeStatus) public onlyAdmin {
        exchanges_list[exchange].tradeStatus = changeTradeStatus;
    }
    
    function exChangeDesc(address exchange, string memory changeShortName, string memory changeFullname, string memory changeWeblink) public onlyAdmin {
        exchanges_list[exchange].shortName = changeShortName;
        exchanges_list[exchange].fullName = changeFullname;
        exchanges_list[exchange].webLink = changeWeblink;
    }
    
    ////
    // Trade functions
    ////
    
    //@note trading methods have been temporarily facilitated to simplify the development
    
    function order(address tokenGet, uint amountGet, address tokenGive, uint amountGive, address exchange) public exIsConnected returns(bool) {
        bytes32 hash = keccak256(abi.encodePacked(this, tokenGet, amountGet, tokenGive, amountGive, exchange));
        orders[exchange][msg.sender][hash] = true;
        // Order(tokenGet, amountGet, tokenGive, amountGive, exchange, msg.sender, hash);
        return true;
    }

    function trade(address tokenGet, uint amountGet, address tokenGive, uint amountGive, address exchange, address user, uint amount) public exIsConnected returns(bool) {
        bytes32 hash = keccak256(abi.encodePacked(this, tokenGet, amountGet, tokenGive, amountGive, exchange));
        orderFills[exchange][user][hash] = SafeMath.add(orderFills[exchange][user][hash], amount);
        uint calcAmountGive = amountGive * amount / amountGet;
    
        // Trade(tokenGet, amountGet, tokenGive, calcAmountGive, exchange, get, msg.sender, bytes32 hash, string pair);
        return true;
    }

    function cancelOrder(address tokenGet, uint amountGet, address tokenGive, uint amountGive, address exchange) public exIsConnected returns(bool) {
        // bytes32 hash = keccak256(abi.encodePacked(this, tokenGet, amountGet, tokenGive, amountGive, expires, nonce, exchange));
        //if (!(orders[exchange][msg.sender][hash] || ecrecover(sha3("\x19Ethereum Signed Message:\n32", hash),v,r,s) == msg.sender)) throw;
        //orderFills[exchange][msg.sender][hash] = amountGet;
        //Cancel(tokenGet, amountGet, tokenGive, amountGive, expires, nonce, exchange, msg.sender, v, r, s, hash, pair);
        return true;
    }
}

