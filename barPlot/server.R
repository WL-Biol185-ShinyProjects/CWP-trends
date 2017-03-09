library(shiny)
library(ggplot2)
library(dplyr)
ncsr4 <- read.csv("data/ncsr4_clean.csv")


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$range <- renderPrint({input$slider2})

  
  renderPlot({
      ncsr4 %>%
      filter(EXP == output$range) %>%
      group_by(PMF, AGE) %>%
      summarize(n = n()) %>%
      ggplot(aes(AGE, n)) +
          geom_histogram()
        
    
   
  })
  
})