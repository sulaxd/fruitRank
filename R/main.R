#' Rank fruits from various dimensions.
#' @import shiny
#' @export
#' @examples
#' library(fruitBank)
#' run_fruitRank()
run_fruitRank <- function() {
    appDir <- system.file("shiny", "myapp", package = "fruitRank")
    if (appDir == "") {
        stop("Could not find app directory. Try re-installing `fruiRank`.", call. = FALSE)
    }
    tryCatch(
        {
            fruit <<- getFruitTransData()
            runApp(appDir, display.mode = "normal")
        },
        error = function(cond){
            stop("Error")
        },
        finally = rm(list = ls(pos = ".GlobalEnv"), pos = ".GlobalEnv")
    )
}
