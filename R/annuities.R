# In this tutorial, we will write R functions to compute the following:

# 1. Present Value of Annuity
# 2. Future Value of Annuity
# 3. Present Value of Annuity Due
# 4. Future Value of Annuity Due
# 5. Payments - FV
# 6. Payments - PV
# 7. Periods - FV
# 8. Periods - PV

pv_annuity <- function(payment, rate, periods) {
    
    # transform the rate
    rate <- rate / 100
    
    # compute perpetuity
    perpetuity <- 1 / rate
    
    # compute discounting
    discount <- 1 / (rate * ((1 + rate) ^ periods))
    
    # present value
    pv <- payment * (perpetuity -  discount)
    pv <- round(pv, digits = 2)
    return(pv)
}

# Example 
pv_annuity(500000, 8, 5)


fv_annuity <- function(payment , rate, periods) {
    
    # transform the rate
    rate <- rate / 100
     
    # compute discount
    discount <- (1 + rate) ^ periods
    
    # future value
    fv <- payment * ((discount - 1) / rate)
    fv <- round(fv, digits = 2)
    return(fv)
}

fv_annuity(1000, 6, 5)


pv_annuity_due <- function(payment, rate, periods) {
    
    p_annuity <- pv_annuity(payment, rate, periods)
    p_an_due <- p_annuity * (1 + (rate / 100))
    p_an_due <- round(p_an_due, digits = 2)
    return(p_an_due)
}


pv_annuity_due(1000, 5, 5)


fv_annuity_due <- function(payment, rate, periods) {
    
    f_annuity <- fv_annuity(payment, rate, periods)
    f_an_due <- f_annuity * (1 + (rate / 100))
    f_an_due <- round(f_an_due, digits = 2)
    return(f_an_due)
}


fv_annuity_due(1000, 5, 5)

payment_fv <- function(future_value, rate, periods) {
    
    # transform rate
    rate <- rate / 100
    
    # compute payment
    payment <- (rate * future_value) / (((1 + rate) ^ periods) - 1)
    payment <- round(payment, digits = 2)
    return(payment)
}


payment_pv <- function(present_value, rate, periods) {
    
    # transform rate
    rate <- rate / 100
    
    # compute payment
    payment <- (rate * present_value) / (1 - ((1 + rate) ^ -periods))
    payment <- round(payment, digits = 2)
    return(payment)
}


periods_fv <- function(future_value, rate, payment) {
    
    # transform rate
    rate <- rate / 100
    
    periods <- log(((rate * future_value) / payment) + 1) / log(1 + rate)
    periods <- round(periods, digits = 2)
    return(periods)
}


periods_pv <- function(present_value, rate, payment) {
    
    # transform rate
    rate <- rate / 100
    
    periods <- - (log(1 - ((rate * present_value) / payment)) / log ( 1 + rate))
    periods <- round(periods, digits = 2)
    return(periods)
}



# test
periods_fv(500, 8, 50)
periods_pv(500, 8, 50)














