tabPanel('Adj. Current Yield', value = 'tab_bond_adj_cyield',

	fluidPage(

		includeCSS("mystyle.css"),

		fluidRow(

								column(2, offset = 2,

									numericInput(
										inputId = "bond_adj_cyield_face_value",
										label   = "Face Value:",
										value   = 100
									)
								),

								column(2, 

									numericInput(
										inputId = "bond_adj_cyield_price",
										label   = "Price:",
										value   = 100
									)
								)

							),

							fluidRow(

								column(2, offset = 2,

									numericInput(
										inputId = "bond_adj_cyield_maturity_years",
										label   = "Maturity Years:",
										value   = 1,
										min     = 1,
										step    = 1
									)
								),

								column(2, 

									numericInput(
										inputId = "bond_adj_cyield_coupon_rate",
										label   = "Coupon Rate:",
										value   = 0.10,
										min     = 0,
										max     = 1,
										step    = 0.01
									)
								)
							),

							br(),
							br(),


							fluidRow(

								column(2, offset = 2,

									actionButton(
										inputId = "bond_adj_cyield_submit",
										label   = "Submit",
										width   = '150px'
									),

									br()
								),

								column(2, 

									actionButton(
										inputId = "bond_adj_cyield_reset",
										label   = "Reset",
										width   = '150px'
									),

									br()
								)

							),

							fluidRow(

					            column(4, offset =2, align = 'center',

					                br(),
					                br(),

					                verbatimTextOutput('bond_adj_cyield_output')

					            )

							)

		
	)
)