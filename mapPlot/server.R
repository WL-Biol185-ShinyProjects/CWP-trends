library(shiny)
library(ggplot2)
library(dplyr)

#Load in, rename region data relating region to state
load("mapPlot/data/serverData.RData")
regionData <- df_join
remove(df_join)

#Load in polygon info for country and state in U.S.
uscounties <- rgdal::readOGR("mapPlot/data/counties_5m.json", "OGRGeoJSON")
usstates   <- rgdal::readOGR("mapPlot/data/state_5m.json", "OGRGeoJSON")

#Load in rapid progression data
rapidProg <- read.csv("mapPlot/data/rapidProgression_clean.csv")

------------------------- not finished below-----------------------------------
# Define server logic required to draw map plot
shinyServer(function(input, output) {
  
  
  
  output$expPlot <- renderPlot({
    rapidProg%>%
      filter(XRAY_YEAR >= input$slider1[1], XRAY_YEAR <= input$slider1[2]) %>%
      group_by(REGION) %>%
      count(AGE, REGION) %>%
      ggplot(aes(AGE, n, fill = REGION)) +
      geom_bar(stat = "identity", position = "stack")
    
    
    
  })
  
})

