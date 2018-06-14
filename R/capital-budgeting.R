#' Capital budgeting
#'
#' Computes payback period, net present value, internal rate of return
#' equivalent annual annuity, profitability and break even period.
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
        capital_cost %<>% divide_by(100)
    }

    pos_flow <-
        cash_flow %>%
        extract(-1) %>%
        as.list()

    t <-
        pos_flow %>%
        length() %>%
        seq_len(.)

    r <-
        capital_cost %>%
        rep(length(t)) %>%
        as.list()

    f <- function(p, i, t) {
        p / ((1 + i) ^ t)
    }

    pmap(list(pos_flow, r, t), f) %>%
        map_dbl(., 1) %>%
        sum() %>%
        add(cash_flow[1])

}


#' @rdname ivt_payback_period
#' @export
#'
ivt_eaa <- function(cash_flow, capital_cost) {

    if (capital_cost > 1) {
        capital_cost %<>% divide_by(100)
    }

    n <-
        cash_flow %>%
        extract(-1) %>%
        length()

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
        capital_cost %<>% divide_by(100)
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
