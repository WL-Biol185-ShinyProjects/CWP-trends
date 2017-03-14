library(shiny)
library(ggplot2)
library(dplyr)
ncsr4 <- read.csv("data/ncsr4_clean.csv")
ncsr4$REGION <- factor(ncsr4$REGION, levels = c("HI RANK", "MED RANK", "LOW RANK"))

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$range <- renderPrint({input$slider2})

 
  renderPlot({
    ncsr4 %>%
      filter(PMF == "PMF+", EXP > 11) %>%
      group_by(AGE) %>%
      count(AGE, REGION) %>%
      ggplot(aes(AGE, n, fill = REGION)) +
      geom_bar(stat = "identity", position = "stack")
        
    
   
  })
  
})
