#' Cashflow
#'
#' Compute present and future value of cash flow/stream, payback period,
#' net present value, internal rate of return, equivalent annual annuity,
#' profitability and break even period.
#'
#' @section Arguments:
#' \describe{
#'   \item{cash_flow}{Cash flow.}
#'   \item{interest_rate}{Interest rate.}
#'   \item{discount_rate}{Discount rate.}
#'   \item{years}{Number of years.}
#'   \item{cf_stream}{Cash flow stream.}
#'   \item{capital_cost}{Cost of capital.}
#' }
#'
#' @section Details:
#'
#' \code{$new()} will instantiate an object of class \code{Cashflow}.
#'
#' \code{set_cash_flow()} will set the value for \code{cash_flow}.
#'
#' \code{set_interest_rate()} will set the value for \code{interest_rate}.
#'
#' \code{set_discount_rate()} will set the value for \code{discount_rate}.
#'
#' \code{set_years()} will set the value for \code{years}.
#'
#' \code{set_cf_stream()} will set the value for \code{cf_stream}.
#'
#' \code{set_capital_cost()} will set the value for \code{capital_cost}
#'
#' \code{compute_fv()} will compute the future value of a cash flow.
#'
#' \code{compute_pv()} will compute the present value of a cash flow.
#'
#' \code{compute_fv_stream()} will compute the future value of a cash flow stream.
#'
#' \code{compute_pv_stream()} will compute the present value of a cash flow stream.
#'
#' \code{compute_payback_period()} will compute the payback period of a project.
#'
#' \code{compute_npv()} will compute the net present value.
#'
#' \code{compute_eaa()} will compute the equivalent annual annuity.
#'
#' \code{compute_profit_index()} will compute profitability.
#'
#' \code{compute_break_even()} will compute the break even period.
#'
#' @examples
#' # compute future value of a cash flow
#' myCashflow <- Cashflow$new()
#' myCashflow$set_cash_flow(100)
#' myCashflow$set_interest_rate(10)
#' myCashflow$set_years(4)
#' myCashflow$compute_fv()
#'
#' # compute present value of a cash flow
#' myCashflow <- Cashflow$new()
#' myCashflow$set_cash_flow(39)
#' myCashflow$set_discount_rate(11.56)
#' myCashflow$set_years(7)
#' myCashflow$compute_pv()
#'
#' # compute future value of a cash flow stream
#' myCashflow <- Cashflow$new()
#' myCashflow$set_cf_stream(c(100, 200, 200, 300))
#' myCashflow$set_interest_rate(10)
#' myCashflow$compute_fv_stream()
#'
#' # compute present value of a cash flow stream
#' myCashflow <- Cashflow$new()
#' myCashflow$set_cf_stream(c(100, 200, 200, 300))
#' myCashflow$set_discount_rate(10)
#' myCashflow$compute_pv_stream()
#'
#' # capital budgeting
#' myCashflow <- Cashflow$new()
#' myCashflow$set_cash_flow(c(-1000, 500, 400, 300, 200, 100))
#' myCashflow$set_capital_cost(10)
#' myCashflow$compute_payback_period()
#' myCashflow$compute_npv()
#' myCashflow$compute_eaa()
#' myCashflow$compute_profit_index()
#' myCashflow$compute_break_even()
#'
#' @name Cashflow
#' @docType class
#' @format An R6 class
#' @importFrom purrr pmap map_dbl detect_index accumulate
#' @export
#'
Cashflow <- R6::R6Class("Cashflow",

  public = list(
    cash_flow = NULL,
    interest_rate = NULL,
    discount_rate = NULL,
    years = NULL,
    cf_stream = NULL,
    capital_cost = NULL,

    initialize = function(cash_flow = NA, interest_rate = NA, discount_rate = NA,
                          years = NA, cf_stream = NA, capital_cost = NA) {
        self$cash_flow     <- cash_flow
        self$interest_rate <- interest_rate
        self$discount_rate <- discount_rate
        self$years         <- years
        self$cf_stream     <- cf_stream
        self$capital_cost  <- capital_cost
    },

    set_cash_flow = function(val) {
        self$cash_flow <- val
    },

    set_interest_rate = function(val) {
        self$interest_rate <- val
    },

    set_discount_rate = function(val) {
        self$discount_rate <- val
    },

    set_years = function(val) {
        self$years <- val
    },

    set_cf_stream = function(val) {
        self$cf_stream <- val
    },

    set_capital_cost = function(val) {
        self$capital_cost <- val
    },

    compute_fv = function() {
        private$check_interest_rate()
        self$cash_flow * ((1 + self$interest_rate) ^ self$years)
    },

    compute_pv = function() {
        private$check_discount_rate()
        den <- (1 + self$discount_rate) ^ self$years
        self$cash_flow / den
    },

    compute_fv_stream = function() {
        cf <- as.list(self$cf_stream)
        n  <- length(cf)
        private$check_interest_rate()
        r <- self$interest_rate

        n_list <- as.list(append(rev(seq_len(n - 1)), 0))
        r_list <- as.list(rep(r, n))

        f <- function(cf, r, n) {
            cf * ((1 + r) ^ n)
        }

        fvalues <- pmap(list(cf, r_list, n_list), f)
        sum(map_dbl(fvalues, 1))
    },

    compute_pv_stream = function() {
        cf <- as.list(self$cf_stream)
        n  <- length(cf)
        private$check_discount_rate()
        r <- self$discount_rate

        n_list <- as.list(seq_len(n))
        r_list <- as.list(rep(r, n))

        f <- function(cf, r, n) {
            cf / ((1 + r) ^ n)
        }

        fvalues <- pmap(list(cf, r_list, n_list), f)
        sum(map_dbl(fvalues, 1))

    },

    compute_payback_period = function() {
        is_positive <- function(x) x > 0

        year  <- detect_index(accumulate(self$cash_flow, sum), is_positive)
        lyncf <- year - 2
        ncf   <- accumulate(self$cash_flow, sum)[year]
        tcf   <- self$cash_flow[year + 1]

        lyncf + (ncf / tcf)
    },

    compute_npv = function() {
        private$check_capital_cost()
        pos_flow <- as.list(self$cash_flow[-1])
        t <- seq_len(length(pos_flow))
        r <- as.list(rep(self$capital_cost, length(t)))

        f <- function(p, i, t) {
            p / ((1 + i) ^ t)
        }

        sum(map_dbl(pmap(list(pos_flow, r, t), f), 1)) + self$cash_flow[1]
    },

    compute_eaa = function() {
        private$check_capital_cost()
        n   <- length(self$cash_flow[-1])
        npv <- ivt_npv(self$cash_flow, self$capital_cost)
        num <- self$capital_cost * npv
        den <- 1 - ((1 + self$capital_cost) ^ -n)
        num / den
    },

    compute_profit_index = function() {
        private$check_capital_cost()
        outflow <- -self$cash_flow[1]
        npv <- ivt_npv(self$cash_flow, self$capital_cost)
        (npv + outflow) / outflow
    },

    compute_break_even = function() {
        out_flow <- -self$cash_flow[1]
        br_even  <- function(x) x >= out_flow
        flow     <- cumsum(self$cash_flow[-1])
        detect_index(accumulate(self$cash_flow[-1], sum), br_even)
    }
  ),

  private = list(

      check_interest_rate = function() {
          if (self$interest_rate > 1) {
              self$interest_rate <- self$interest_rate / 100
          }
      },

      check_discount_rate = function() {
          if (self$discount_rate > 1) {
              self$discount_rate <- self$discount_rate / 100
          }
      },

      check_capital_cost = function() {
          if (self$capital_cost > 1) {
              self$capital_cost <-  self$capital_cost / 100
          }
      }
  )
)
