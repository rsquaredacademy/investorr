# libraries
tbill_price <- function(rate, days) {

	# transform rate
	rate <- rate / 100

	# compute price
	r_days <- rate * days
	r_year <- r_days / 360
	r_one <- 1 - r_year
	price <- r_one * 100
	price <- round(price, digits = 3)

	return(price)
}

# tbill_price(0.145, 57)


tbill_rate <- function(price, days) {

	rate <- (100 - price) * (360 / days)
	rate <- round(rate, digits = 2)
    return(rate)
}

# tbill_rate(93, 360)

library(dplyr)
library(ggplot2)
source("t_bill.R")


# rate for different maturity days
rate_index <- function(price, days) {
    
    # increase the days by 200
    day1 <- days - 100
    day2 <- days + 100
    z <- c(day1, day2)
    
    # create an empty data frame
    rate_df <- data.frame(Days = as.numeric(), Rate = as.numeric())
    
    for (days in z) {
        rate <- tbill_rate(price, days)
        rate_df <- rbind(rate_df, data.frame(Days = days, Rate = rate))
    }
    
    # use ggplot2 to plot the rate data
    viz <- ggplot(data = rate_df, aes(x = Days, y = Rate)) + geom_line(colour = "blue") +
        xlab("Days Until Maturity") + ylab("Rate") + ggtitle("T-Bill Rate") + theme_bw()
    
    return(viz)
}


#rate_index(93, 200)



# rate for different maturity days
rate_index <- function(price, days) {
    
    # increase the days by 200
    day1 <- days - 100
    day2 <- days + 100
    
    # create an empty data frame
    rate_df <- data.frame(Days = as.numeric(), Rate = as.numeric())
    
    for (days in day1:day2) {
        rate <- tbill_rate(price, days)
        rate_df <- rbind(rate_df, data.frame(Days = days, Rate = rate))
    }
    
    # use ggplot2 to plot the rate data
    viz <- ggplot(data = rate_df, aes(x = Days, y = Rate)) + geom_line(colour = "blue") +
        xlab("Days Until Maturity") + ylab("Rate") + ggtitle("T-Bill Rate") + theme_bw()
    
    return(viz)
}



rate_index(93, 90)















