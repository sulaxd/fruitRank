#' @import shiny
#' @export
run_fruitRank <- function() {
    appDir <- system.file("shiny", "myapp", package = "fruitRank")
    if (appDir == "") {
        stop("Could not find app directory. Try re-installing `fruiRank`.", call. = FALSE)
    }

    runApp(appDir, display.mode = "normal")
}
