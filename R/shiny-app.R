#' @importFrom shiny runApp
#' @title Launch shiny app
#' @description Launches shiny app.
#' @examples
#' \dontrun{
#' ivt_launch_app()
#' }
#' @export
#'
ivt_launch_app <- function() {
  shiny::runApp(appDir = system.file("application", package = "investorr"))
}
