# 簡介

多吃水果有益身體健康，不過該怎麼挑選選水果才是既健康又經濟呢？

這是一個以R語言建立的應用，使用者只要安裝此套件並執行run_fruitRank函數即可透過以Shiny建立的互動介面，輕鬆地查詢**當日**的水果CP值排行榜。

由於水果價格每日浮動，透過此CP值排行即可快速的協助使用者進行購買決策。

# 安裝
```
library(devtools)

install_github("sulaxd/fruitRank")
```

# 執行
```
library(fruitRank)

run_fruitRank()
```

# 資料來源

1. [農產品行情](http://m.coa.gov.tw/OpenData/FarmTransData.aspx)

1. [食品營養成分](https://consumer.fda.gov.tw/Food/TFND.aspx?nodeID=178#)
