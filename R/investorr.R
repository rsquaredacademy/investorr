#' \code{investorr} package
#'
#' Tools for portfolio optimization.
#'
#' See the README on
#' \href{https://github.com/rsquaredacademy/investorr}{GitHub}
#'
#' @docType package
#' @name investorr
#' @importFrom dplyr %>%
NULL

## quiets concerns of R CMD check re: the .'s that appear in pipelines
if (getRversion() >= "2.15.1") {
  utils::globalVariables(c("."))
}