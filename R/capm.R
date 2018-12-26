#' Capital asset pricing model
#'
#' Computes beta, risk free rate, expected return on
#' stock and market.
#'
#' @param beta Beta for stock.
#' @param risk_free Risk free rate.
#' @param return_stock Expected return on the stock.
#' @param return_market Expected return on the market.
#'
#' @examples
#' ivt_capm_beta(1.8, 13.64, 9.2)
#' ivt_capm_stock_return(7.8, 10.7, 1.2)
#' ivt_capm_market_return(5.2, 6.5, 2.4)
#' ivt_capm_risk_free(7, 12.3, 2)
#'
#' @export
#'
ivt_capm_beta <- function(risk_free, return_stock, return_market) {

    if (risk_free > 1) {
        risk_free <- risk_free / 100
    }

    if (return_stock> 1) {
        return_stock <-  return_stock / 100
    }

    if (return_market> 1) {
        return_market <- return_market / 100
    }

    (return_stock - risk_free) / (return_market - risk_free)
}



#' @rdname ivt_capm_beta
#' @export
#'
ivt_capm_stock_return <- function(risk_free, return_market, beta) {

    if (risk_free > 1) {
      risk_free <- risk_free / 100
    }

    if (return_market>  1) {
      return_market <- return_market / 100
    }

    risk_free + ((return_market - risk_free) * beta)

}

#' @rdname ivt_capm_beta
#' @export
#'
ivt_capm_market_return <- function(risk_free, return_stock, beta) {

    if (risk_free > 1) {
        risk_free <- risk_free / 100
    }

    if (return_stock> 1) {
        return_stock <-  return_stock / 100
    }

    (return_stock + ((beta - 1) * risk_free)) / beta

}

#' @rdname ivt_capm_beta
#' @export
#'
ivt_capm_risk_free <- function(return_market, return_stock, beta) {

    if (return_stock> 1) {
        return_stock <-  return_stock / 100
    }

    if (return_market> 1) {
        return_market <- return_market / 100
    }

    (return_stock - (beta * return_market)) / (1 - beta)

}

    