#' Capital budgeting
#'
#' Computes payback period, net present value, internal rate of return
#' equivalent annual annuity, profitability and break even period.
#' 
#' @param cash_flow Cash flow over the project life.
#' @param capital_cost Cost of capital.
#'
#' @examples
#' ivt_payback_period(c(-1000, 500, 400, 300, 200, 100))
#' ivt_npv(c(-1000, 500, 400, 300, 200, 100), 10)
#' ivt_eaa(c(-1000, 500, 400, 300, 200, 100), 10)
#' ivt_profit_index(c(-1000, 500, 400, 300, 200, 100), 10)
#' ivt_break_even(c(-1000, 500, 400, 300, 200, 100))
#'
#' @importFrom purrr detect_index accumulate
#'
#' @export
#'
ivt_payback_period <- function(cash_flow) {

    is_positive <- function(x) x > 0

    year  <- detect_index(accumulate(cash_flow, sum), is_positive)
    lyncf <- year - 2
    ncf   <- accumulate(cash_flow, sum)[year]
    tcf   <- cash_flow[year + 1]

    lyncf + (ncf / tcf)

}

#' @rdname ivt_payback_period
#'
#' @importFrom magrittr extract
#' @importFrom purrr pmap map_dbl
#'
#' @export
#'
ivt_npv <- function(cash_flow, capital_cost) {

    if (capital_cost > 1) {
        capital_cost <-  capital_cost / 100
    }

    pos_flow <- as.list(cash_flow[-1])
    t <- seq_len(length(pos_flow))
    r <- as.list(rep(capital_cost, length(t)))

    f <- function(p, i, t) {
        p / ((1 + i) ^ t)
    }

    pmap(list(pos_flow, r, t), f) %>%
        map_dbl(., 1) %>%
        sum() %>%
        magrittr::add(cash_flow[1])

}


#' @rdname ivt_payback_period
#' @export
#'
ivt_eaa <- function(cash_flow, capital_cost) {

    if (capital_cost > 1) {
        capital_cost <- capital_cost / 100
    }

    n   <- length(cash_flow[-1])
    npv <- ivt_npv(cash_flow, capital_cost)
    num <- capital_cost * npv
    den <- 1 - ((1 + capital_cost) ^ -n)
    num / den


}

#' @rdname ivt_payback_period
#' @export
#'
ivt_profit_index <- function(cash_flow, capital_cost) {

    if (capital_cost > 1) {
        capital_cost <- capital_cost / 100
    }

    outflow <- -cash_flow[1]
    npv <- ivt_npv(cash_flow, capital_cost)
    (npv + outflow) / outflow

}

#' @rdname ivt_payback_period
#' @export
#'
ivt_break_even <- function(cash_flow) {

    out_flow <- -cash_flow[1]
    br_even  <- function(x) x >= out_flow
    flow     <- cumsum(cash_flow[-1])
    detect_index(accumulate(cash_flow[-1], sum), br_even)

}
