output$ui_ncfs <- renderUI({
        ncol <- as.integer(input$cb_n_flows)
        if (ncol < 1) {
          NULL
        } else {
          lapply(1:ncol, function(i) {
              numericInput(paste("n_cf_", i),
                        label = "",
                        value = 100,
                        width   = '100px')
          })
        }
    })

    cf_val <- reactive({
        ncol <- as.integer(input$cb_n_flows)

        if (ncol < 1) {
          colors <- NULL
        } else {
          collect <- list(lapply(1:ncol, function(i) {
                          input[[paste("n_cf_", i)]]
                      }))

          colors <- unlist(collect)
        }
        colors

    })


result_cb_payback <- eventReactive(input$submit_cb, {
  ivt_payback_period(cf_val())
})

result_cb_npv <- eventReactive(input$submit_cb, {
  ivt_npv(cf_val(), input$cb_cost)
})

result_cb_eaa <- eventReactive(input$submit_cb, {
  ivt_eaa(cf_val(), input$cb_cost)
})

result_cb_pi <- eventReactive(input$submit_cb, {
  ivt_profit_index(cf_val(), input$cb_cost)
})

result_cb_be <- eventReactive(input$submit_cb, {
  ivt_break_even(cf_val())
})


# output
output$output_cb <- renderPrint({
    cat('Payback:               ', result_cb_payback(), '\n',
    	'Net Present Value:     ', result_cb_npv(), '\n',
    	'Equated Annual Annuity:', result_cb_eaa(), '\n',
    	'Profut Index:          ', result_cb_pi(), '\n',
    	'Break Even:            ', result_cb_be())
})
