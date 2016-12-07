#' @import RCurl RJSONIO magrittr
getFruitTransData <- function(){
    urlContent <- getURL("http://m.coa.gov.tw/OpenData/FarmTransData.aspx")
    if (Sys.info()[1] == "Windows") {
        urlContent <- iconv(urlContent, "UTF-8", "big5")
    }
    d <- fromJSON(urlContent) %>%
        as.data.frame() %>%
        t() %>%
        as.data.frame(row.names, stringsAsFactors = FALSE) %>%
        .[!grepl('[A-Za-z]{2}',
                  unlist(.[, 2], use.names = FALSE)), ] %>%
        .[, c(1, 3, 5, 9)]
    colnames(d) <- c("date", "fruit", "market", "price")
    d$price <- as.numeric(d$price)
    return(d)
}
