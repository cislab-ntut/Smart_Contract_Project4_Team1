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



![img](https://github.com/cislab-yzu/Project1-4_Smart_contract/blob/master/SmartContractDemo/1.png)<br/>
首先查看VM中可用賬號（在這裡我們選用前兩個賬號進行測試，用第一個賬號部署合約作為contractProvider)<br/>
![img](https://github.com/cislab-yzu/Project1-4_Smart_contract/blob/master/SmartContractDemo/2.png)<br/>
所有Functions展示↑</br>
![img](https://github.com/cislab-yzu/Project1-4_Smart_contract/blob/master/SmartContractDemo/3.png))<br/>
1.由contractProvider（這裡是賬號1）決定誰是買家，誰是賣家和誰是物流公司(createTransaction([buyerAddress,sellerAddress,logisticsAddress])),提交後將生成一筆新的transaction。在這裡由於方便測試的需要，因為function有存取權限問題，我們在輸入時將同一筆transaction中買家買家與物流公司都設為同一個address<br/><br/>
2.賣家與物流公司分別有權限設定商品價格與物流費用(setCommodityPrice(uint),setDeliveryFee(uint))<br/><br/>
![img](https://github.com/cislab-yzu/Project1-4_Smart_contract/blob/master/SmartContractDemo/4.png)<br/>
賣家與物流公司設置商品價格及物流費用<br/><br/>
3.買家可以查看物流費用(showDeliveryFee()),和商品費用(showCommodityPrice())<br/><br/>
![img](https://github.com/cislab-yzu/Project1-4_Smart_contract/blob/master/SmartContractDemo/5.png)<br/>
買家查看物流費用和商品費用<br/><br/>
4.買家需要依據查詢到的金額分別支付物流費用（payLogistics(uint))和支付商品費用(payCommidity(uint))，這些錢先暫時存在合約中<br/><br/>
![img](https://github.com/cislab-yzu/Project1-4_Smart_contract/blob/master/SmartContractDemo/7.png)<br/>
 買家未把錢放進合約中showBalance()輸出為0<br/><br/>
![img](https://github.com/cislab-yzu/Project1-4_Smart_contract/blob/master/SmartContractDemo/8.png)<br/>
其中一筆交易買家把錢放進合約中（5+2=7）<br/><br/>
![img](https://github.com/cislab-yzu/Project1-4_Smart_contract/blob/master/SmartContractDemo/9.png)<br/>
 另一筆交易中買家也進行支付後（假設商品3，物流1，3+1=4），後合約內總共存有11（7+4=11）<br/><br/>
5.未發貨時查詢物流狀態顯示unsent，當接到貨時可以按下(delivering())確認發貨，物流公司可以確認貨物已送達(delivered())，並從合約中領取到物流費用<br/><br/>
![img](https://github.com/cislab-yzu/Project1-4_Smart_contract/blob/master/SmartContractDemo/0.png)<br/>
 showDeliveryState為unset<br/><br/>
![img](https://github.com/cislab-yzu/Project1-4_Smart_contract/blob/master/SmartContractDemo/10.png)<br/>
showDeliveryState為delivering<br/><br/>
![img](https://github.com/cislab-yzu/Project1-4_Smart_contract/blob/master/SmartContractDemo/11.png)<br/>
第一筆交易中物流公司確認貨物已送達（delivered()），將可以收取到此transaction的物流費用(2)，合約中剩餘總balance為(11-2=9)<br/><br/>
6.買家確認商品沒問題後，選擇(receivingComfirm())確認收貨，合約將依據設定的商品價格將貨款(5)轉賬給賣家<br/><br/>
![img](https://github.com/cislab-yzu/Project1-4_Smart_contract/blob/master/SmartContractDemo/12.png)<br/>
第一筆交易確認收貨後(balance=9-5=4)<br/><br/>
![img](https://github.com/cislab-yzu/Project1-4_Smart_contract/blob/master/SmartContractDemo/13.png)<br/>
第二筆交易的買家選擇退款(reFund())，所支付的商品金額以及物流費用都將如數退還到買家賬戶(balance=0)<br/><br/>

