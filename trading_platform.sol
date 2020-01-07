pragma solidity >=0.4.22 <0.6.0;

contract Test{
    address owner;
    address payable[] sellerAddr;
    address payable[] buyerAddr;
    address payable[] logisticsAddr;
    address zeroAddr;

    uint NumOfTransactions;
    bool [] commodityPaid;
    bool [] logisticsPaid; 
    uint [] deliveryFee;
    bool [] deliveringState;
    bool [] deliveredState;
    uint [] commodityPrice;
    
    constructor() public payable{
        owner=msg.sender;
        zeroAddr=0x0000000000000000000000000000000000000000;

    }
    
    modifier contractProviderOnly(){
        require(msg.sender==owner,"contract provider only");
        _;
    }
    
    modifier sellerOnly(){
        bool judge=false;
        for(uint i;i<NumOfTransactions;i++)
        {
            if(msg.sender==sellerAddr[i])
            {
                judge=true;
                break;
            }
        }
        require(judge,"seller only");
        _;
    }
    
    modifier buyerOnly(){
        bool judge=false;
        for(uint i;i<NumOfTransactions;i++)
        {
            if(msg.sender==buyerAddr[i])
            {
                judge=true;
                break;
            }
        }
        require(judge,"buyer only");
        _;
    }
    
    modifier logisticsOnly(){
        bool judge=false;
        for(uint i;i<NumOfTransactions;i++)
        {
            if(msg.sender==logisticsAddr[i])
            {
                judge=true;
                break;
            }
        }
        require(judge,"logistics only");
        _;
    }
    
    function createTransaction(address payable[]memory _accountAddress) public contractProviderOnly{
        buyerAddr.push(_accountAddress[0]);
        sellerAddr.push(_accountAddress[1]);
        logisticsAddr.push(_accountAddress[2]);
        deliveredState.push(false);
        deliveringState.push(false);
        commodityPrice.push(0);
        deliveryFee.push(0);
        commodityPaid.push(false);
        logisticsPaid.push(false);
        NumOfTransactions+=1;
    }
    
    /*
    function _showarray() public contractProviderOnly view returns(address){
            return;
    }*/
    
    
    function setDeliveryFee(uint fee) public  logisticsOnly{
        uint index;
        for(uint i;i<NumOfTransactions;i++)
        {
            if(msg.sender==logisticsAddr[i])
            {
                index=i;
                break;
            }
        }
        deliveryFee[index]=fee;
    }
    
    
   function showDeliveryFee() public   buyerOnly view returns(uint){
        uint index;
        for(uint i;i<NumOfTransactions;i++)
        {
            if(msg.sender==buyerAddr[i])
            {
                index=i;
                break;
            }
        }
        return deliveryFee[index];
    }
    
    function setCommodityPrice(uint price) public sellerOnly {
        uint index;
        for(uint i;i<NumOfTransactions;i++)
        {
            if(msg.sender==sellerAddr[i])
            {
                index=i;
                break;
            }
        }
       commodityPrice[index]=price;
    }
    
    function showCommodityPrice() public   buyerOnly view returns(uint){
        uint index;
        for(uint i;i<NumOfTransactions;i++)
        {
            if(msg.sender==buyerAddr[i])
            {
                index=i;
                break;
            }
        }
        return commodityPrice[index];
    }
    
    function PayCommodity() public buyerOnly payable{
        
        uint index;
        for(uint i;i<NumOfTransactions;i++)
        {
            if(msg.sender==buyerAddr[i])
            {
                index=i;
                break;
            }
        }
        //require(msg.value==deliveryFee[index]);
        commodityPaid[index]=true;
    }
    
    function PayLogistics() public buyerOnly payable{
        
        uint index;
        for(uint i;i<NumOfTransactions;i++)
        {
            if(msg.sender==buyerAddr[i])
            {
                index=i;
                break;
            }
        }
        //require(msg.value==commodityPrice[index]);
        logisticsPaid[index]=true;
    }
    
    function showBalance() public contractProviderOnly view returns(uint){
        return address(this).balance;
    }
    
    function receivingConfirm() public buyerOnly{
        uint index;
        for(uint i;i<NumOfTransactions;i++)
        {
            if(msg.sender==buyerAddr[i])
            {
                index=i;
                break;
            }
        }
        
        sellerAddr[index].transfer(commodityPrice[index]);
    }
    
    function delivering() public sellerOnly payable{
        uint index;
        for(uint i;i<NumOfTransactions;i++)
        {
            if(msg.sender==sellerAddr[i])
            {
                index=i;
                break;
            }
        }
        deliveringState[index]=true;
        logisticsAddr[index].transfer(deliveryFee[index]);
    }
    
    function delivered() public logisticsOnly{
        uint index;
        for(uint i;i<NumOfTransactions;i++)
        {
            if(msg.sender==logisticsAddr[i])
            {
                index=i;
                break;
            }
        }
        deliveredState[index]=true;
    }
    
    function showDeliveryState() public view returns(string memory){
        uint index;
        for(uint i;i<NumOfTransactions;i++)
        {
            if(msg.sender==buyerAddr[i])
            {
                index=i;
                break;
            }
            else if(msg.sender==sellerAddr[i])
            {
                index=i;
                break;
            }
            else if(msg.sender==logisticsAddr[i])
            {
                index=i;
                break;
            }
            else if(msg.sender==owner)
            {
                return "you are owner";
                
            }
        }
        if(deliveringState[index]){
            return "delivering";
        }
        else if(deliveredState[index]){
            return "delivered";
        }
        else{
            return "unsent";
        }
    }
    
    function showYourIdentity() public view returns(string memory){
        for(uint i;i<NumOfTransactions;i++)
        {
            if(msg.sender==zeroAddr){
                return "zero address, you must connect to your wallet";
            }
            else if(msg.sender==buyerAddr[i]){
                return "you are the buyer";
            }
            else if(msg.sender==sellerAddr[i]){
                return "you are the seller";
            }
            else if(msg.sender==owner){
                return "you are the contract provider";
            }
            else if(msg.sender==logisticsAddr[i]){
                return "you are the logistics";
            }
        }
        return "No Identity";
    }
    
    function reFund() public buyerOnly
    {
        uint index;
        for(uint i;i<NumOfTransactions;i++)
        {
            if(msg.sender==buyerAddr[i])
            {
                index=i;
                break;
            }
        }
        buyerAddr[index].transfer(commodityPrice[index]+deliveryFee[index]);
    }
}
