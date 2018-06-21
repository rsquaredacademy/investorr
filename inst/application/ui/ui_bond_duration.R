tabPanel('Bond Duration', value = 'tab_bond_duration',

	fluidPage(

		includeCSS("mystyle.css"),

		fluidRow(
			column(12,
				tabsetPanel(type = 'tabs',
					tabPanel('Macaulay Duration',
						fluidPage(
							br(),
							br(),
							fluidRow(

								column(2, offset = 2,

									numericInput(
										inputId = "bond_macd_face_value",
										label   = "Face Value:",
										value   = 100
									)
								),

								column(2, 

									numericInput(
										inputId = "bond_macd_coupon_rate",
										label   = "Coupon Rate:",
										value   = 0.10,
										min     = 0,
										max     = 1,
										step    = 0.01
									)
								)
							),

							fluidRow(

								column(2, offset = 2,

									numericInput(
										inputId = "bond_macd_maturity_years",
										label   = "Maturity Years:",
										value   = 1,
										min     = 1,
										step    = 1
									)
								),

								column(2, 

									numericInput(
										inputId = "bond_macd_yield",
										label   = "Yield:",
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
										inputId = "bond_macd_submit",
										label   = "Submit",
										width   = '150px'
									),

									br()
								),

								column(2, 

									actionButton(
										inputId = "bond_macd_reset",
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

					                verbatimTextOutput('bond_macd_output')

					            )

							)
						)
					),

					tabPanel('Modified Duration',
						fluidPage(
							br(),
							br(),
							fluidRow(

								column(2, offset = 2,

									numericInput(
										inputId = "bond_mod_face_value",
										label   = "Face Value:",
										value   = 100
									)
								),

								column(2, 

									numericInput(
										inputId = "bond_mod_coupon_rate",
										label   = "Coupon Rate:",
										value   = 0.10,
										min     = 0,
										max     = 1,
										step    = 0.01
									)
								)
							),

							fluidRow(

								column(2, offset = 2,

									numericInput(
										inputId = "bond_mod_maturity_years",
										label   = "Maturity Years:",
										value   = 1,
										min     = 1,
										step    = 1
									)
								),

								column(2, 

									numericInput(
										inputId = "bond_mod_yield",
										label   = "Yield:",
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
										inputId = "bond_mod_submit",
										label   = "Submit",
										width   = '150px'
									),

									br()
								),

								column(2, 

									actionButton(
										inputId = "bond_mod_reset",
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

					                verbatimTextOutput('bond_mod_output')

					            )

							)
						)
					)
				)
			)
		)
		
	)
)