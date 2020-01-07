# Project1-4_Smart_contract #
### Version 1.0 ###
  A smart contract which can be used in a transaction between a single buyer and a single seller.<br/>
There are 4 roles: contract provider, buyer, seller and logistics.<br/>
Every role has its own function access authorizations. <br/>
### Version 2.0 : Concurrent Multi-transaction ###
  Now the trading platform which is constructed with a smart contract has supported multi-transaction.<br/><br/>
When a contractProvider set a array which includes 3 addresses as parameters of function createTransaction(address[]), a new transaction will be created and the 3 parameters will be regarded as buyer address, seller address and logistics company address respectively (according to the sequence you give).<br/><br/>
If the function createTransaction(address[]) is called by a conctractProvider successfully, a new transaction will be created and it will not affect other transactions which already exist. Likewise, operations in a transaction have no effect on other transactions.

<br>
<br>

# 系統流程 #

![img](https://github.com/cislab-yzu/Project1-4_Smart_contract/blob/master/SmartContractDemo/1-4-1.png)

1.由Contract Provider決定誰是買家，誰是賣家和誰是物流公司([]sellerAddr(address),[]buyerAddr(address),[]logisticsAddr(address))<br/><br/>
![img](https://github.com/cislab-yzu/Project1-4_Smart_contract/blob/master/SmartContractDemo/1.png)<br/><br/>
![img](https://github.com/cislab-yzu/Project1-4_Smart_contract/blob/master/SmartContractDemo/2.png)<br/><br/><br/><br/>
![img](https://github.com/cislab-yzu/Project1-4_Smart_contract/blob/master/SmartContractDemo/3.png))<br/><br/>
2.賣家與物流分別有權限設定商品價格與物流費用(setCommodityPrice(uint),setDeliveryFee(uint))<br/><br/>
![img](https://github.com/cislab-yzu/Project1-4_Smart_contract/blob/master/SmartContractDemo/4.png)<br/><br/>
3.買家可以查看物流費用(showDeliveryFee()),和商品費用(showCommodityPrice())<br/><br/>
![img](https://github.com/cislab-yzu/Project1-4_Smart_contract/blob/master/SmartContractDemo/5.png)<br/><br/>
4.買家需要依據查詢到的金額分別支付物流費用（payLogistics(uint))和支付商品費用(payCommidity(uint))，這些錢先暫時存在合約中<br/><br/>
![img](https://github.com/cislab-yzu/Project1-4_Smart_contract/blob/master/SmartContractDemo/7.png)<br/><br/>
![img](https://github.com/cislab-yzu/Project1-4_Smart_contract/blob/master/SmartContractDemo/8.png)<br/><br/>
![img](https://github.com/cislab-yzu/Project1-4_Smart_contract/blob/master/SmartContractDemo/9.png)<br/><br/>
                                         另一筆交易的物流費用和支付商品費用加起來總共11<br/><br/>
5.賣家期使狀態為unset，當接到貨時可以按下(delivering())確認發貨，物流公司可以確認貨物已送達(delivered())，並從合約中領取到物流費用<br/><br/>
![img](https://github.com/cislab-yzu/Project1-4_Smart_contract/blob/master/SmartContractDemo/0.png)<br/><br/>
![img](https://github.com/cislab-yzu/Project1-4_Smart_contract/blob/master/SmartContractDemo/10.png)<br/><br/>
![img](https://github.com/cislab-yzu/Project1-4_Smart_contract/blob/master/SmartContractDemo/11.png)<br/><br/>
6.買家確認商品沒問題後，選擇(receivingComfirm())確認收貨，合約中剩餘的貨款將轉賬到賣家賬戶<br/><br/>
![img](https://github.com/cislab-yzu/Project1-4_Smart_contract/blob/master/SmartContractDemo/12.png)<br/><br/>
![img](https://github.com/cislab-yzu/Project1-4_Smart_contract/blob/master/SmartContractDemo/13.png)<br/><br/>
7.交易完成

