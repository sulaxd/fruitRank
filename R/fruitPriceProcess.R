#' @import magrittr
getAllFruitPrice <- function(){
    dat <- getFruitTransData()
    lapply(split(dat, dat$`市場名稱`), function(args){
        getOneFruitPrice(args)
    }) %>%
        do.call("rbind", .) %>% set_rownames(NULL)
}

#' @import tibble
getOneFruitPrice <- function(.data){
    result <- data_frame()
    fruitSelected <- c('椰子','釋迦','草莓','藍莓','百香果','小番茄','火龍果',
                       '櫻桃','石榴','香蕉','鳳梨','椪柑','甜橙','酪梨','奇異果',
                       '波羅蜜','柚子','葡萄柚','西施柚','木瓜','龍眼','楊桃','梨',
                       '西洋梨','番石榴','蓮霧','芒果','葡萄','西瓜','甜瓜','洋香瓜',
                       '蘋果','柿子','棗子','甘蔗','紅毛丹','榴槤')
    for (f in fruitSelected) {
        pattern <- paste0("^", f)
        tmp <- .data[grepl(pattern, .data$`作物名稱`), ]
        if (nrow(tmp) >= 2) {
            tmp <- tmp[order(tmp$`平均價`)[1], ]
            tmp$`作物名稱` <- f
            result <- rbind(result, tmp)
        } else if (nrow(tmp) == 1) {
            tmp$`作物名稱` <- f
            result <- rbind(result, tmp)
        }
    }
    return(result)
}
