# Project1-4_Smart_contract #
A smart contract which can be used in a transaction between a single buyer and a single seller.<br/>
There are 4 roles: contract provider, buyer, seller and logistics.<br/>
Every role has its own function access authorizations. 
<br>
<br>

# 系統流程 #

![img](https://github.com/cislab-yzu/Project1-4_Smart_contract/blob/master/smart%20concract%20step/1-4-1.png)


# 各步驟技術細節 #

1.合約擁有者透過setBuyer, setSeller, setLogistics分別設置需要交易的買家, 賣家以及物流公司

2.賣家利用setCommodityPrice設置貨物所需金額，而物流公司利用setDeliveryFee設置所需運費

3.買家藉由showCommodityPrice查看賣家所設定的價錢並且PayCommodity payable完成下單

4.當賣家接到訂單時把貨物交給物流公司且買價利用
