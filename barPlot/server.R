library(shiny)
library(ggplot2)

ncsr4 <- ncsr4

selectInput("", label = "Risk Factor:", choices = c("tenure", "exposure"))

renderPlot({
   ncsr4 %>%
    group_by(input$group, carrier) %>%
    summarize(ave_delay = mean(sum(arr_delay + dep_delay, na.rm = TRUE))) %>%
    ggplot(aes(input$group, ave_delay, colour = carrier)) + geom_bar(stat = "identity")
})

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  })
  
})