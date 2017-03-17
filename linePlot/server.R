library(shiny)
library(ggplot2)
library(dplyr)
rapidProg_disease <- read.csv("../data/rapidProg_disease.csv")

rapidProg_disease$REGION <- factor( rapidProg_disease$REGION
                                  , levels = c( "West"
                                              , "Mid-West"
                                              , "Northern Appalachia"
                                              , "Central Appalachia"
                                              , "Southern Appalachia"
                                              )
                                  )


shinyServer(function(input, output) {
  
output$linePlot <- renderPlot({
  rapidProg_disease %>%
    filter(DISEASE == input$select1) %>%
    group_by(XRAY_YEAR) %>%
    count(XRAY_YEAR, REGION) %>%
    ggplot(aes(XRAY_YEAR, n, color = REGION)) +
    geom_line() +
    ggtitle("Temporal Disease Trends") +
    labs(x="Year",y="Number of Cases") +
    xlim(1969, 2002)
  
})

})
