library(shiny)
library(quantmod)

#-------------------------------------------------------------------------------
# 
shinyUI(fluidPage(
        titlePanel("Stock Watch"),
        wellPanel(
                helpText("1. Input the stock symbol and Date, and then press 'Append' inoder to obtain the chosen stock price line chart."),
                fluidRow(
                        # Input the stock symbol of which stock you would like to watch
                        column(3, textInput("stk_symbol", label = "Input the Stock Symbol", value = "tsl")),
                        # Select the range of data to show the selected stock price
                        column(6, dateRangeInput("dates","Date range",start = "2018-01-01",end = as.character(Sys.Date()))),
                        # Click to search for the symbol of stock name you would like to watch
                        column(3, helpText(a("Search for the stock symbol", href = "https://finance.yahoo.com/lookup/")),  actionButton("apply", label = "Append"))
                )
        ),
        helpText("2. The chosen stock price line chart display as below, can be brushed to selected a series of stock price data for histogram."),
        # Display the chart of selected stock price in the range of selected date
        fluidRow(column(12,plotOutput("plot", brush = "data_select"))),
        helpText("3. The histogram of selected data of stock price from above chart showed the frequency of stock price."),
        # Display the histogram of Closed stock price by selecting range of date via brushing the above chart 
        fluidRow(column(12, plotOutput("histo")))
        
        
)
        
        
)