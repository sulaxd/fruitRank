#' @import shiny
#' @export
runApp <- function() {
    appDir <- system.file("shiny", "myapp", package = "fruitRank")
    if (appDir == "") {
        stop("Could not find app directory. Try re-installing `fruiRank`.", call. = FALSE)
    }

    shiny::runApp(appDir, display.mode = "normal")
}

#' @export
nutritDataUpdate <- function(){
    require(rvest)
    require(magrittr)
    nutritDataUrl <- read_html("https://consumer.fda.gov.tw/Food/TFND.aspx?nodeID=178#")
    nutritDataUrl <- nutritDataUrl %>% html_nodes("table.margintop.zoomBlock a") %>%
        .[length(.)] %>% html_attr("href") %>% gsub("\\.\\.\\/","",.) %>%
        paste0("https://consumer.fda.gov.tw/", .)
    download.file(url = nutritDataUrl, destfile = "data/nutrition.xls", mode="wb")
}

#' @export
getFruitTransData <- function(){
    RJSONIO::fromJSON('http://m.coa.gov.tw/OpenData/FarmTransData.aspx') %>% as.data.frame() %>% t()
}
