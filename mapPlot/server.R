library(shiny)
library(dplyr)
library(leaflet)

shinyServer(function (input, output) {
  
  output$mapPlot <- renderPlot({
#Load in
load("~/CWP-trends/mapPlot/data/serverData.RData")

#in toMerge: n = number of the disease for that year for that region

value <- toMerge %>%
            filter(XRAY_YEAR >= input$slider[1], XRAY_YEAR <= input$slider[2]) %>%
            subset(DISEASE == input$select1) %>%
            group_by(REGION, XRAY_YEAR) %>%
            summarise(total = mean(n)) %>%
            group_by(REGION) %>%
            summarise(sumTotal = sum(total))
            
toMerge$XRAY_YEAR <- NULL
toMerge$n         <- NULL

filt_toMerge <- filter(toMerge, DISEASE == input$select1)
join         <- left_join(filt_toMerge, value, by = "REGION")
dd.join      <- join[!duplicated(join), ]
          
uscounties@data <- left_join(uscounties@data, dd.join, by = "GEO_ID")
uscounties@data$sumTotal[is.na(uscounties@data$sumTotal)] <- 0

leaflet(data = uscounties) %>%
  addTiles() %>%
  addPolygons(color = ~colorNumeric("YlOrRd", sumTotal)(sumTotal), fillOpacity = 0.5, weight = 1) %>%
  addPolygons(data = usstates, color = "black", weight = 5, fillOpacity = 0)
  })
})

