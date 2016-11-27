#' @import shiny
#' @export
runApp <- function() {
    appDir <- system.file("shiny", "myapp", package = "fruitRank")
    if (appDir == "") {
        stop("Could not find app directory. Try re-installing `fruiRank`.", call. = FALSE)
    }

    shiny::runApp(appDir, display.mode = "normal")
}
