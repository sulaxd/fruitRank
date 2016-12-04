#' @import RJSONIO magrittr tibble RCurl
getFruitTransData <- function(){
    d<-fromJSON(getURL("http://m.coa.gov.tw/OpenData/FarmTransData.aspx")) %>%
        as.data.frame() %>% t() %>% as_data_frame() %>%
        .[!grepl('[A-Za-z]{2}', .$`作物代號`), ] %>%
        .[, c(1, 3, 5, 9)]
    d$`平均價` <- as.numeric(d$`平均價`)
    return(d)
}

#' @import rvest magrittr
nutritDataUpdate <- function(){
    nutritDataUrl <- read_html("https://consumer.fda.gov.tw/Food/TFND.aspx?nodeID=178#")
    nutritDataUrl <- nutritDataUrl %>% html_nodes("table.margintop.zoomBlock a") %>%
        .[length(.)] %>% html_attr("href") %>% gsub("\\.\\.\\/","",.) %>%
        paste0("https://consumer.fda.gov.tw/", .)
    download.file(url = nutritDataUrl, destfile = "nutrition.xls", mode="wb")
}
