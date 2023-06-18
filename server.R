library(shiny)
library(quantmod)

#------------------------------------------------------------------------------
# Function to get the xts data of selected stock and transfer to dataframe 
xts2df <- function(symb_name, from, to){
                tempD <- getSymbols(symb_name, src = "yahoo", from , to , auto.assign = FALSE) 
                tempD <- data.frame(tempD)
                val_date <- as.Date(rownames(tempD))
                df <- cbind(date=val_date,tempD[,1:6])
        return(df)
}

#------------------------------------------------------------------------------
shinyServer(function(input, output){
        dataInput <- reactiveVal()
        dataplot <- reactive(brushedPoints(dataInput(), input$data_select, allRows = FALSE, xvar = "date", yvar = colnames(dataInput()[5])))
        # When click the "Append" bottom, the information of selected stock in the range of selected date
        # was downloaded and transfer to a dataframe
        observeEvent(input$apply,{
               
                dataInput(xts2df(input$stk_symbol, from = input$dates[1], to = input$dates[2]))
                
        })
        
        # Using the saved dataframe to plot a line chart with x axis of date, y axis of closed price 
        output$plot <- renderPlot({
               plot(y = dataInput()[,2], x= dataInput()[,1], type = "l", xlab = "Date", ylab = "Price") 
        })
        
        # When brushing the line chart above to select the range of closed price, a histograme of frequency of closed price 
        # will display
        observeEvent(input$data_select,{
                               output$histo <- renderPlot({
                                            hist(dataplot()[,5],main ="Histogram of Close Price", xlab = "Price")
                        
                        })
        })
})