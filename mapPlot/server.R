library(shiny)
library(dplyr)
library(leaflet)


#Load in
load("~/CWP-trends/mapPlot/data/serverData.RData")
#in toMerge: n = number of the disease for that year for that region


shinyServer(function (input, output, session) {

output$mapPlot <- renderLeaflet({
  
  leaflet(data = uscounties) %>%
    addTiles() %>%
    addPolygons(data = usstates, color = "black", weight = 5, fillOpacity = 0) %>%
    setView(lng = -93.85, lat = 37.45, zoom = 4)
  })

observe({value <- toMerge %>%
  filter(XRAY_YEAR >= input$slider1[1], XRAY_YEAR <= input$slider1[2]) %>%
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

leafletProxy("mapPlot", data = uscounties) %>%
  addPolygons(color = ~colorNumeric("YlOrRd", uscounties@data$sumTotal)(uscounties@data$sumTotal), fillOpacity = 0.5, weight = 1) %>%
})

})

