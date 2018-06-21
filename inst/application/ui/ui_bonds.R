tabPanel('Bond Analysis', value = 'tab_bonds', 

    navlistPanel(id = 'navlist_bonds',
        well = FALSE,
        widths = c(2, 10),

        source('ui/ui_bond_price.R', local = TRUE)[[1]],
        source('ui/ui_bond_duration.R', local = TRUE)[[1]],
        source('ui/ui_bond_convexity.R', local = TRUE)[[1]],
        source('ui/ui_bond_yield.R', local = TRUE)[[1]],
        source('ui/ui_bond_current_yield.R', local = TRUE)[[1]],
        source('ui/ui_bond_adj_cyield.R', local = TRUE)[[1]]

    )
)
