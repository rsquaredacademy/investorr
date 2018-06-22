tabPanel('Portfolio Analysis', value = 'tab_pf', 

    navlistPanel(id = 'navlist_pf',
        well = FALSE,
        widths = c(2, 10),

        source('ui/ui_stock_risk_return.R', local = TRUE)[[1]],
        source('ui/ui_pf_risk_return.R', local = TRUE)[[1]],
        source('ui/ui_pf_frontier.R', local = TRUE)[[1]]

    )
)
