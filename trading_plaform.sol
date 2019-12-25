pragma solidity >=0.4.22 <0.6.0;

contract Test{
    address owner;
    address payable sellerAddr;
    address payable buyerAddr;
    address payable logisticsAddr;
    uint deliveryFee;
    bool deliveringState;
    bool deliveredState;
    
    constructor() public payable{
        owner=msg.sender;
        deliveringState=false;
        deliveredState=false;
    }
    
    modifier contractProviderOnly(){
        require(msg.sender==owner,"contract provider only");
        _;
    }
    
    modifier sellerOnly(){
        require(msg.sender==sellerAddr,"seller only");
        _;
    }
    
    modifier buyerOnly(){
        require(msg.sender==buyerAddr,"buyer only");
        _;
    }
    
    modifier logisticsOnly(){
        require(msg.sender==logisticsAddr,"logistics only");
        _;
    }
    
    function setBuyer(address payable buyer) public contractProviderOnly{
        buyerAddr=buyer;
    }
    
    function setSeller(address payable seller) public contractProviderOnly{
        sellerAddr=seller;
    }
    
    function setLogistics(address payable logistics) public contractProviderOnly{
        logisticsAddr=logistics;
    }
    
    function setDeliveryFee(uint fee) public logisticsOnly{
        deliveryFee=fee;
    }
    
    function placeAnOrder() public buyerOnly payable{
    }
    
    function showBalance() public contractProviderOnly view returns(uint){
        return address(this).balance;
    }
    
    function receivingConfirm() public buyerOnly{
        sellerAddr.transfer(address(this).balance);
    }
    
    function delivering() public sellerOnly payable{
        deliveringState=true;
        logisticsAddr.transfer(deliveryFee);
    }
    
    function delivered() public logisticsOnly{
        deliveredState=true;
    }
    
    function showDeliveryState() public view returns(string memory){
        if(deliveringState){
            return "delivering";
        }
        else if(deliveredState){
            return "delivered";
        }
        else{
            return "unsent";
        }
    }
}