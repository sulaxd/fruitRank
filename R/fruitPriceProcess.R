#' @import magrittr
getAllFruitPrice <- function(){
    dat <- getFruitTransData()
    lapply(split(dat, dat$market), function(args){
        getOneFruitPrice(args)
    }) %>%
        do.call("rbind", .) %>%
        set_rownames(NULL)
}

getOneFruitPrice <- function(.data){
    result <- data.frame()
    for (f in fruitSelected) {
        pattern <- paste0("^", f)
        tmp <- .data[grepl(pattern, .data$fruit), ]
        if (nrow(tmp) >= 2) {
            tmp <- tmp[order(tmp$price)[1], ]
            tmp$fruit <- f
            result <- rbind(result, tmp)
        } else if (nrow(tmp) == 1) {
            tmp$fruit <- f
            result <- rbind(result, tmp)
        }
    }
    return(result)
}
