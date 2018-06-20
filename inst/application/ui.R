library(shiny)
library(shinyBS)
library(shinythemes)
library(shinycssloaders)
library(magrittr)
library(shinycssloaders)

shinyUI(

    navbarPage(HTML("investorr"), id = 'mainpage',
    source('ui/ui_calculators.R', local = TRUE)[[1]],
    source('ui/ui_exit_button.R', local = TRUE)[[1]]

))
