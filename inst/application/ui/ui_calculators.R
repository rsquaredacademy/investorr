navbarMenu('Calculators', icon = icon('calculator'),

  source('ui/ui_bonds.R', local = TRUE)[[1]],
  source('ui/ui_capm.R', local = TRUE)[[1]],
  source('ui/ui_stock.R', local = TRUE)[[1]]

)
