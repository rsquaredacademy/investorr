#' Cash flow
#'
#' Compute present and future value of a single cash flow and cash flow stream.
#'
#' @param cash_flow Cash flow.
#' @param interest_rate Interest rate.
#' @param discount_rate Discount rate.
#' @param years Number of years.
#' @param cf_stream Cash flow stream.
#'
#' @examples
#' # future value
#' ivt_cf_fv(100, 10, 4)
#' ivt_cf_fv(191, 10.17, 25)
#'
#' # present value
#' ivt_cf_pv(39, 11.56, 7)
#' ivt_cf_pv(373, 6.67, 13)
#'
#' # cash flow stream future value
#' ivt_cf_stream_fv(c(100, 200, 200, 300), 10)
#'
#' # cash flow stream present value
#' ivt_cf_stream_pv(c(100, 200, 200, 300), 10)
#'
#' @export
#'
ivt_cf_fv <- function(cash_flow, interest_rate, years) {

    if (interest_rate > 1) {
        interest_rate %<>% divide_by(100)
    }

    1 %>%
      add(interest_rate) %>%
      raise_to_power(years) %>%
      multiply_by(cash_flow)

    # cash_flow * ((1 + interest_rate) ^ years)

}

#' @rdname ivt_cf_fv
#' @export
#'
ivt_cf_pv <- function(cash_flow, discount_rate, years) {

    if(discount_rate > 1) {
        discount_rate %<>%  divide_by(100)
    }

    den <-
      1 %>%
      add(discount_rate) %>%
      raise_to_power(years)

    cash_flow / den
}

#' @importFrom purrr pmap map_dbl
#' @importFrom magrittr %>% subtract
#' @rdname ivt_cf_fv
#' @export
#'
ivt_cf_stream_fv <- function(cf_stream, interest_rate) {

    cf <- as.list(cf_stream)
    n  <- length(cf)

    if (interest_rate > 1) {
        r <- interest_rate / 100
    } else {
        r <- interest_rate
    }

    n_list <-
        n %>%
        subtract(1) %>%
        seq_len(.) %>%
        rev() %>%
        append(0) %>%
        as.list()

    r_list <-
        r %>%
        rep(n) %>%
        as.list()

    f <- function(cf, r, n) {
        cf * ((1 + r) ^ n)
    }

    fvalues <- pmap(list(cf, r_list, n_list), f)

    fvalues %>%
        map_dbl(., 1) %>%
        sum()

}


#' @rdname ivt_cf_fv
#' @export
#'
ivt_cf_stream_pv <- function(cf_stream, discount_rate) {

    cf <- as.list(cf_stream)
    n  <- length(cf)

    if (discount_rate > 1) {
        r <- discount_rate / 100
    } else {
        r <- discount_rate
    }

    n_list <-
        n %>%
        seq_len(.) %>%
        as.list()

    r_list <-
        r %>%
        rep(n) %>%
        as.list()

    f <- function(cf, r, n) {
        cf / ((1 + r) ^ n)
    }

    fvalues <- pmap(list(cf, r_list, n_list), f)

    fvalues %>%
        map_dbl(., 1) %>%
        sum()

}
