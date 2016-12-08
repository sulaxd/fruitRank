#' Rank fruits from various dimensions.
#' @importFrom shiny runApp
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
            dailyFruitPrice <<- getFruitTransData()
            runApp(appDir, display.mode = "normal")
        },
        error = function(cond){
            print(cond)
        },
        finally = rm(list = ls(pos = ".GlobalEnv"), pos = ".GlobalEnv")
    )
}
