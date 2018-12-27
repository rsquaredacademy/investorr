#' Stock valuation
#'
#' Computes the stock price, dividend, growth rate and required
#' rate of return.
#'
#' @param dividend Current/next dividend.
#' @param growth_rate Growth rate of dividend.
#' @param return_rate Required return on stock.
#' @param stock_price Price of stock.
#' @param current Logical; Current dividend or next dividend.
#' @param current_dividend Current dividend on stock.
#'
#' @examples
#' # stock price
#' ivt_stock_price(5.34, 1.88, 7.31)
#' ivt_stock_price(5.34, 1.88, 7.31, TRUE)
#'
#' # stock dividend
#' ivt_stock_dividend(103.92, 8.6, 13.71)
#' ivt_stock_dividend(103.92, 8.6, 13.71, TRUE)
#'
#' # stock return
#' ivt_stock_return(46.8, 2.41, 6.74)
#' ivt_stock_return(46.8, 2.41, 6.74, TRUE)
#'
#' # stock growth
#' ivt_stock_growth(77.15, 4.44, 14.85)
#' ivt_stock_growth(77.15, 4.44, 14.85, TRUE)
#'
#' # non constant growth
#' ivt_stock_ncg_price(1.22, 6.2, c(13, 7, 7, 1))
#'
#'
#' @export
#'
ivt_stock_price <- function(dividend, growth_rate, return_rate, current = FALSE) {

    if (growth_rate > 1) {
        growth_rate <- growth_rate / 100
    }

    if (return_rate > 1) {
        return_rate <- return_rate / 100
    }

    gr <- return_rate - growth_rate

    if (gr < 0) {
        stop('Growth rate must be lesser than the required return rate on the
             stock.')
    }

    if (current) {
        (dividend * (1 + growth_rate)) / gr
    } else {
        dividend / gr
    }

}


#' @rdname ivt_stock_price
#' @export
#'
ivt_stock_dividend <- function(stock_price, growth_rate, return_rate, current = FALSE) {

    if (growth_rate > 1) {
        growth_rate <- growth_rate / 100
    }

    if (return_rate > 1) {
        return_rate <- return_rate / 100
    }

    gr <- return_rate - growth_rate

    if (gr < 0) {
        stop('Growth rate must be lesser than the required return rate on the
             stock.')
    }

    if (current) {
       (stock_price * gr) / (1 + growth_rate)
    } else {
       (stock_price * gr)
    }

}

#' @rdname ivt_stock_price
#' @export
#'
ivt_stock_return <- function(stock_price, dividend, growth_rate, current = FALSE) {

    if (growth_rate > 1) {
        growth_rate <- growth_rate / 100
    }

    if (current) {
      ((dividend + growth_rate * (dividend + stock_price)) / stock_price) * 100
    } else {
       ((dividend + (stock_price * growth_rate)) / stock_price) * 100
    }

}


#' @rdname ivt_stock_price
#' @export
#'
ivt_stock_growth <- function(stock_price, dividend, return_rate, current = FALSE) {

    if (return_rate > 1) {
        return_rate <- return_rate / 100
    }

    if (current) {
     (((stock_price * return_rate) - dividend) / (stock_price + dividend)) * 100
    } else {
       (((stock_price * return_rate) - dividend) / stock_price) * 100
    }

}

#' @rdname ivt_stock_price
#' @export
#'
ivt_stock_ncg_price <- function(current_dividend, return_rate, growth_rate) {

    if (return_rate > 1) {
       return_rate <- return_rate / 100
    }

    if (any(growth_rate > 1)) {
      growth_rate <- growth_rate / 100
    }


    n <- length(growth_rate) - 1
    growth <- growth_rate + 1
    growth_factor <- cumprod(growth) * current_dividend
    l <- length(growth_rate)
    lgf <- length(growth_factor)
    dividends <- growth_factor[-l]
    final_dividend <- growth_factor[lgf]
    last_growth    <- growth_rate[l]
    required_list <- as.list(rep(return_rate, n))
    dividends_list <- as.list(dividends)
    t_list <- as.list(seq_len(n))
    
    f <- function(p, i, t) {
        p / ((1 + i) ^ t)
    }

    first <- sum(map_dbl(pmap(list(dividends_list, required_list, t_list), f), 1))
    second <- (final_dividend / (return_rate - last_growth)) *
        ((1 + return_rate) ^ -n)

    first + second

}

