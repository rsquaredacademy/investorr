#' Risk and return
#'
#' Computes expected return, risk, beta and risk free rate.
#'
#' @param probs Probability distribution of future returns.
#' @param returns Returns on stock.
#' @param returns_1 Returns on stock 1.
#' @param returns_2 Returns on stock 2.
#' @param risk_1 Risk on stock 1.
#' @param risk_2 Risk on stock 2.
#' @param correlation Correlation between stock returns.
#' @param weight_1 Proportion of portfolio invested in stock 1.
#'
#' @examples
#' ivt_stock_risk_return(c(20, 30, 30, 20), c(5, 10, 15, 20))
#' ivt_pf_risk_return(c(20, 30, 30, 20), c(5, 10, 15, 20), c(50, 30, 10, -10),
#' correlation = 1, weight_1 = 0.5)
#'
#' @export
ivt_stock_risk_return <- function(probs, returns) {

    if (length(probs) != length(returns)) {
        stop("Looks like you have not specified the same number of
              probability and returns.")
    }

    if (any(probs > 1)) {
        probs %<>% divide_by(100)
    }

    if (any(returns > 1)) {
        returns %<>% divide_by(100)
    }

    exp_ret <-
        probs %>%
        multiply_by(returns) %>%
        sum()

    rr <- tibble(probs = probs, returns = returns)

    rr %<>%
        mutate(
            variance = probs * ((returns - exp_ret) ^ 2)
        )

    risk_var <-
        rr %>%
        pull(variance) %>%
        sum()

    risk_sd <- sqrt(risk_var)

    result <- list(
        expected_return = exp_ret,
        variance        = risk_var,
        std_deviation   = risk_sd

    )

    return(result)

}

#' @rdname ivt_stock_risk_return
#' @export
#'
ivt_pf_risk_return <- function(probs, returns_1, returns_2, correlation, weight_1) {

    if (any(probs > 1)) {
        probs %<>% divide_by(100)
    }

    if (any(returns_1> 1)) {
        returns_1%<>% divide_by(100)
    }

    if (any(returns_2 > 1)) {
        returns_2 %<>% divide_by(100)
    }

    pf_data <- tibble(probs = probs, ret_1 = returns_1, ret_2 = returns_2)

    pf_data %<>%
        mutate(
            expret_1 = probs * ret_1,
            expret_2 = probs * ret_2
        )

     er_1 <-
        pf_data %>%
        pull(expret_1) %>%
        sum()

    er_2 <-
        pf_data %>%
        pull(expret_2) %>%
        sum()

    pf_data %<>%
        mutate(
            var_1 = probs * ((ret_1 - er_1) ^ 2),
            var_2 = probs * ((ret_2 - er_2) ^ 2)
        )

    sd_1 <-
        pf_data %>%
        pull(var_1) %>%
        sum() %>%
        sqrt(.)

    sd_2 <-
        pf_data%>%
        pull(var_2) %>%
        sum() %>%
        sqrt(.)

    weight_2 <- 1 - weight_1

    pf_return <- weight_1 * er_1 + weight_2 * er_2

    var_return <- ((weight_1 ^ 2) * (sd_1 ^ 2)) +
        ((weight_2 ^ 2) * (sd_2 ^ 2)) +
        2 * weight_1 * weight_2 * correlation * sd_1 * sd_2

    sd_return <- sqrt(var_return)

    result <- list(
        portfolio_return = pf_return,
        portfolio_var    = var_return,
        portfolio_sd     = sd_return
    )

    return(result)

}

#' Efficient frontier
#'
#' Two stock portfolio efficient frontier.
#'
#' @param returns_1 Returns from stock 1.
#' @param risk_1 Risk of stock 1.
#' @param returns_2 Returns from stock 2.
#' @param risk_2 Risk from stock 2.
#' @param correlation Correlation between stock 1 and stock 2.
#' @param x An object of class \code{ivt_pf_ef}.
#' @param ... Other arguments.
#'
#' @examples
#' ivt_pf_ef(8, 10, 16, 20, -1)
#' plot(ivt_pf_ef(8, 10, 16, 20, -1))
#'
#' @export
#'
ivt_pf_ef <- function(returns_1, risk_1, returns_2, risk_2,
                      correlation) UseMethod('ivt_pf_ef')

#' @export
#'
ivt_pf_ef.default <- function(returns_1, risk_1, returns_2, risk_2, correlation)  {

    if (any(returns_1> 1)) {
        returns_1%<>% divide_by(100)
    }

    if (any(returns_2 > 1)) {
        returns_2 %<>% divide_by(100)
    }

    if (any(risk_1> 1)) {
        risk_1%<>% divide_by(100)
    }

    if (any(risk_2 > 1)) {
        risk_2 %<>% divide_by(100)
    }

    result <-
      tibble(
        w_1 = seq(1, 0, -0.01),
        w_2 = 1 - w_1,
        pf_er  = w_1 * returns_1 + w_2 * returns_2,
        pf_var = ((w_1 ^ 2) * (risk_1 ^ 2)) +
        ((w_2 ^ 2) * (risk_2 ^ 2)) +
            2 * w_1 * w_2 * correlation * risk_1 * risk_2,
        pf_sd = sqrt(pf_var)
      )

    class(result) <- c('ivt_pf_ef', 'tibble', 'data.frame')
    return(result)

}

#' @rdname ivt_pf_ef
#' @importFrom ggplot2 geom_point aes xlim ylim scale_x_continuous scale_y_continuous
#' @export
#'
plot.ivt_pf_ef <- function(x, ...) {

  xmax <-
    x %>%
    pull(pf_sd) %>%
    max() %>%
    multiply_by(1.25)

  ymax <-
    x %>%
    pull(pf_er) %>%
    max() %>%
    multiply_by(1.25)

    x %>%
      select(pf_sd, pf_er) %>%
      ggplot() +
      geom_point(aes(x = pf_sd, y = pf_er), color = "red") +
      ggtitle('Efficient Frontier') + xlab('Standard Deviation') +
      ylab('Expected Return') +
      scale_x_continuous(labels = scales::percent, limits = c(0, xmax)) +
      scale_y_continuous(labels = scales::percent, limits = c(0, ymax))

}
