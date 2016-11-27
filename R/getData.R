#' @import RJSONIO magrittr
getFruitTransData <- function(){
    fromJSON('http://m.coa.gov.tw/OpenData/FarmTransData.aspx') %>%
        as.data.frame() %>% t() %>% as.data.frame() %>% set_rownames(NULL)
}

#' @import rvest magrittr
nutritDataUpdate <- function(){
    nutritDataUrl <- read_html("https://consumer.fda.gov.tw/Food/TFND.aspx?nodeID=178#")
    nutritDataUrl <- nutritDataUrl %>% html_nodes("table.margintop.zoomBlock a") %>%
        .[length(.)] %>% html_attr("href") %>% gsub("\\.\\.\\/","",.) %>%
        paste0("https://consumer.fda.gov.tw/", .)
    download.file(url = nutritDataUrl, destfile = "nutrition.xls", mode="wb")
}
