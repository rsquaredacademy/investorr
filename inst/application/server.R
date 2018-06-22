library(dplyr)
library(tibble)
library(magrittr)
library(ggplot2)
library(purrr)
library(scales)
library(investorr)
library(lubridate)

shinyServer(function(input, output, session) {

    source("logic/logic_bonds.R", local = T)
    source("logic/logic_capm.R", local = T)
    source("logic/logic_stock.R", local = T)
    source("logic/logic_portfolio.R", local = T)
    source("logic/logic_cb.R", local = T)
    source("logic/logic_exit_button.R", local = T)

})


