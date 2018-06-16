#' Treasury bill 
#'
#' Computes treasury bill price, rate and rate index.
#' 
#' @param rate Annual interest rate.
#' @param days Days to maturity.
#' 
#' @examples
#' ivt_tbill_price(0.145, 57)
#' ivt_tbill_rate(93, 360)
#' ivt_rate_index(93, 200)
#'
#' @export
#'
ivt_tbill_price <- function(rate, days) {

	# transform rate
    if (rate > 1) {
        rate %<>% divide_by(100)
    }

	# compute price
    rate_year <-
      rate %>%
      multiply_by(days) %>%
      divide_by(360)

    1 %>%
      subtract(rate_year) %>%
      multiply_by(100)
	
}

#' @rdname ivt_tbill_price
#' @export
#'
ivt_tbill_rate <- function(price, days) {

	(100 - price) * (360 / days)
	
}

#' @rdname ivt_tbill_price
#'
#' @importFrom ggplot2 ggplot geom_line xlab ylab ggtitle theme_bw
#'
#' @export
#'
ivt_rate_index <- function(price, days) {
    
    # increase the days by 200
    day1 <- days - 100
    day2 <- days + 100
    z    <- c(day1, day2)
    
    # create an empty data frame
    rate_df <- data.frame(Days = as.numeric(), Rate = as.numeric())
    
    for (days in z) {
        rate    <- tbill_rate(price, days)
        rate_df <- rbind(rate_df, data.frame(Days = days, Rate = rate))
    }
    
    # use ggplot2 to plot the rate data
    ggplot(data = rate_df, aes(x = Days, y = Rate)) + 
      geom_line(colour = "blue") + xlab("Days Until Maturity") + 
      ylab("Rate") + ggtitle("T-Bill Rate") + theme_bw()
    
}


















