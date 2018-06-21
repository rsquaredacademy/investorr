tabPanel('Stock', value = 'tab_stock',

	fluidPage(

		includeCSS("mystyle.css"),

		fluidRow(

			column(6, align = 'right',
				br(),
				h5('Dividend (Div):')
			),
			
			column(6, align = 'left',

				numericInput(
					inputId = "stock_dividend",
					label   = "",
					value   = NULL,
					min     = 0,
					step    = 0.01,
					width   = '130px'
				)
			)
		),

		fluidRow(

			column(6, align = 'right',
				br(),
				h5('Dividend type:')
			),
			
			column(6, align = 'left',

				selectInput(
					inputId = "stock_dividend_type",
					label   = "",
					choices = c("TRUE" = TRUE, "FALSE" = FALSE),
					selected = "FALSE",
					width = '130px'
				)
			)

		),

		fluidRow(

			column(6, align = 'right',
				br(),
				h5('Growth rate (g):')
			),
			
			column(6, align = 'left',

				numericInput(
					inputId = "stock_growth_rate",
					label   = "",
					value   = NULL,
					min     = 0,
					step    = 0.01,
					width   = '130px'
				)
			)
								
		),

		fluidRow(

			column(6, align = 'right',
				br(),
				h5('Required return (r):')
			),
			
			column(6, align = 'left',

				numericInput(
					inputId = "stock_required_return",
					label   = "",
					value   = NULL,
					min     = 0,
					step    = 0.01,
					width   = '130px'
				)
			)

		),

		fluidRow(
			
			column(6, align = 'right',
				br(),
				h5('Price (P):')
			),
			
			column(6, align = 'left',

				numericInput(
					inputId = "stock_price",
					label   = "",
					value   = NULL,
					min     = 0,
					step    = 0.01,
					width   = '130px'
				)
			)
								
		),

		br(),
		br(),


		fluidRow(

			column(4, h3("")),

			column(1, 

				actionButton(
					inputId = "compute_stock_dividend",
					label   = "Div",
					width   = '100px'
				)
			
			),

			column(1, 

				actionButton(
					inputId = "compute_stock_growth",
					label   = "g",
					width   = '100px'
				)
			
			), 

			column(1, 

				actionButton(
					inputId = "compute_stock_return",
					label   = "r",
					width   = '100px'
				)
			
			),

			column(1, 

				actionButton(
					inputId = "compute_stock_price",
					label   = "P",
					width   = '100px'
				)
			
			),

			column(4, h3(""))

		),

		fluidRow(

			column(4, offset =2, align = 'center',

				br(),
				br(),

				verbatimTextOutput('stock_output')

			)

		)

		
	)
)