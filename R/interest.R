accrued_interest <- function(last_date, next_date, settle_date, rate, par_value, freq) {

	# date transformation
	last_date <- as.Date(last_date)
	next_date <-as.Date(next_date)
	settle_date <- as.Date(settle_date)

	ldays <- as.numeric(settle_date - last_date)
	pdays <- as.numeric(next_date - last_date)

	# transform rate
	rate <- rate / 100

	# frequency conditions
	if (freq == 4) {
        rate <- rate / 4
    } else if (freq == 2) {
        rate <- rate / 2
    } else {
        rate <- rate 
    }

    # coupon payments
    coupon <- par_value * rate

    # accrued interest
    interest <- coupon * (ldays / pdays)
    interest <- round(interest, digits = 2)
    return(interest)
}

accrued_interest("2015-05-13", "2015-09-13", "2015-07-13", 7, 1000, 1)
