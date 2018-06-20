tabPanel('Bond Analysis', value = 'tab_bonds', icon = icon('server'),

    navlistPanel(id = 'navlist_bonds',
        well = FALSE,
        widths = c(2, 10),

        source('ui/ui_bond_price.R', local = TRUE)[[1]]

    )
)
