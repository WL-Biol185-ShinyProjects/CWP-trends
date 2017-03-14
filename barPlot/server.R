library(shiny)
library(ggplot2)
library(dplyr)
ncsr4 <- read.csv("data/ncsr4_clean.csv")


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$range <- renderPrint({input$slider2})

  
  renderPlot({
    ncsr4 %>%
      filter(PMF == "PMF+", EXP == output$range) %>%
      group_by(AGE) %>%
      count(AGE) %>%
      ggplot(aes(AGE, n)) +
      geom_bar(stat = "identity")
        
    
   
  })
  
})
