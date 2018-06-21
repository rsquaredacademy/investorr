tabPanel('Bond Pricing', value = 'tab_bond_price',

	fluidPage(

		includeCSS("mystyle.css"),

		fluidRow(
			column(12,
				tabsetPanel(type = 'tabs',
					tabPanel('Bond Pricing',
						fluidPage(
							br(),
							br(),
							fluidRow(

								column(2, offset = 2,

									numericInput(
										inputId = "bond_face_value_1",
										label   = "Face Value:",
										value   = 100
									)
								),

								column(2, 

									numericInput(
										inputId = "bond_coupon_rate_1",
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
										inputId = "bond_maturity_years_1",
										label   = "Maturity Years:",
										value   = 1,
										min     = 1,
										step    = 1
									)
								),

								column(2, 

									numericInput(
										inputId = "bond_yield_1",
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
										inputId = "bond_submit_1",
										label   = "Submit",
										width   = '150px'
									),

									br()
								),

								column(2, 

									actionButton(
										inputId = "bond_reset_1",
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

					                verbatimTextOutput('bond_price_output_1')

					            )

							)
						)
					),

					tabPanel('Bond Pricing',
						fluidPage(
							br(),
							br(),
							fluidRow(

								column(2, offset = 2,

									numericInput(
										inputId = "bond_face_value_2",
										label   = "Face Value:",
										value   = 100
									)
								),

								column(2, 

									numericInput(
										inputId = "bond_coupon_rate_2",
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
										inputId = "bond_maturity_years_2",
										label   = "Maturity Years:",
										value   = 1,
										min     = 1,
										step    = 1
									)
								),

								column(2, 

									numericInput(
										inputId = "bond_yield_2",
										label   = "Yield:",
										value   = 0.10,
										min     = 0,
										max     = 1,
										step    = 0.01
									)
								)
							),

							fluidRow(

								column(2, offset = 2,

									selectInput(
										inputId = 'bond_freq_2',
										label   = 'Frequency',
										choices = c('annual', 'semi-annual', 'quarterly', 'monthly'),
										selected = 'annual'
									)

								)

							),

							br(),
							br(),


							fluidRow(

								column(2, offset = 2,

									actionButton(
										inputId = "bond_submit_2",
										label   = "Submit",
										width   = '150px'
									),

									br()
								),

								column(2, 

									actionButton(
										inputId = "bond_reset_2",
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

					                verbatimTextOutput('bond_price_output_2')

					            )

							)
						)
					),

					tabPanel('Bond Pricing',
						fluidPage(
							br(),
							br(),
							fluidRow(

								column(2, offset = 2,

									numericInput(
										inputId = "bond_face_value_3",
										label   = "Face Value:",
										value   = 100
									)
								),

								column(2, 

									numericInput(
										inputId = "bond_redemption_value_3",
										label   = "Redemption Value:",
										value   = 100
									)
								)

								
							),

							fluidRow(

								column(2, offset = 2,

									numericInput(
										inputId = "bond_coupon_rate_3",
										label   = "Coupon Rate:",
										value   = 0.10,
										min     = 0,
										max     = 1,
										step    = 0.01
									)
								),

								column(2, 

									numericInput(
										inputId = "bond_yield_3",
										label   = "Yield:",
										value   = 0.10,
										min     = 0,
										max     = 1,
										step    = 0.01
									)
								)
							),

							fluidRow(

								column(2, offset = 2,

									dateInput(
										inputId = "bond_settle_date_3",
										label   = "Settlement Date"
									)
								),

								column(2, 

									dateInput(
										inputId = "bond_maturity_date_3",
										label   = "Maturity Date"
									)
								)
							),

							fluidRow(

								column(2, offset = 2,

									selectInput(
										inputId = 'bond_freq_3',
										label   = 'Frequency',
										choices = c('annual', 'semi-annual', 'quarterly'),
										selected = 'annual'
									)

								)

							),

							br(),
							br(),


							fluidRow(

								column(2, offset = 2,

									actionButton(
										inputId = "bond_submit_3",
										label   = "Submit",
										width   = '150px'
									),

									br()
								),

								column(2, 

									actionButton(
										inputId = "bond_reset_3",
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

					                verbatimTextOutput('bond_price_output_3')

					            )

							)
						)
					),

					tabPanel('Bond Pricing',
						fluidPage(
							br(),
							br(),
							fluidRow(

								column(2, offset = 2,

									numericInput(
										inputId = "bond_face_value_4",
										label   = "Face Value:",
										value   = 100
									)
								),

								column(2, 

									selectInput(
										inputId = 'bond_freq_4',
										label   = 'Frequency',
										choices = c('annual', 'semi-annual', 'quarterly'),
										selected = 'annual'
									)

								)

								
							),

							fluidRow(

								column(2, offset = 2,

									numericInput(
										inputId = "bond_coupon_rate_4",
										label   = "Coupon Rate:",
										value   = 0.10,
										min     = 0,
										max     = 1,
										step    = 0.01
									)
								),

								column(2, 

									numericInput(
										inputId = "bond_yield_4",
										label   = "Yield:",
										value   = 0.10,
										min     = 0,
										max     = 1,
										step    = 0.01
									)
								)
							),

							fluidRow(

								column(2, offset = 2,

									dateInput(
										inputId = "bond_settle_date_4",
										label   = "Settlement Date"
									)
								),

								column(2, 

									dateInput(
										inputId = "bond_maturity_date_4",
										label   = "Maturity Date"
									)
								)
							),

							br(),
							br(),


							fluidRow(

								column(2, offset = 2,

									actionButton(
										inputId = "bond_submit_4",
										label   = "Submit",
										width   = '150px'
									),

									br()
								),

								column(2, 

									actionButton(
										inputId = "bond_reset_4",
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

					                verbatimTextOutput('bond_price_output_4')

					            )

							)
						)
					)
				)
			)
		)
		
	)
)