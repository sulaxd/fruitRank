library(RSelenium)
library(magrittr)
library(XML)
library(rvest)

startServer()
remDr<- remoteDriver$new()
while(TRUE){
  test.open <- try(remDr$open(), silent=TRUE)
  if(!is(test.open, 'try-error')) break
}

remDr$navigate('http://amis.afa.gov.tw/fruit/FruitProdDayTransInfo.aspx')
show.more$clickElement()
show.more$sendKeysToElement(list("lynn1027"))

remDr$executeScript('document.getElementById("ctl00_contentPlaceHolder_txtMarket").value = "全部市場";document.getElementById("ctl00_contentPlaceHolder_txtProduct").value = "全部產品";document.getElementById("ctl00_contentPlaceHolder_hfldMarketNo").value = "ALL";document.getElementById("ctl00_contentPlaceHolder_hfldProductNo").value = "ALL";')
show.more <- remDr$findElement(using = 'id', "ctl00_contentPlaceHolder_btnQuery")
show.more$clickElement()
content <- remDr$getPageSource()
content <- read_html(content[[1]])
content <- content %>% html_nodes("table") %>% `[[`(9) %>% html_table(header = T)
content <- content[-1,]
saveRDS(content, file = "fruitPrice.rds")
