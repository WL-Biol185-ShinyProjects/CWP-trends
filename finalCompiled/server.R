library(shiny)
library(ggplot2)
library(dplyr)
library(leaflet)

rapidProg_disease <- read.csv("../data/rapidProg_disease.csv")
load("~/CWP-trends/mapPlot/data/serverData.RData")

rapidProg_disease$REGION <- factor( rapidProg_disease$REGION
                                    , levels = c( "West"
                                                  , "Mid-West"
                                                  , "Northern Appalachia"
                                                  , "Central Appalachia"
                                                  , "Southern Appalachia"
                                                )
                                  )

ncsr4 <- read.csv("../data/ncsr4_clean.csv")

ncsr4$REGION <- factor(ncsr4$REGION, levels = c("HI RANK", "MED RANK", "LOW RANK"))

shinyServer(function(input, output) {
  
  output$mapPlot <- renderLeaflet({
    leaflet(data = uscounties) %>%
      addTiles() %>%
      addPolygons(data = usstates, color = "black", weight = 5, fillOpacity = 0) %>%
      setView(lng = -93.85, lat = 37.45, zoom = 4)
  })
  
  observe({value <- toMerge %>%
    filter(XRAY_YEAR == input$slider1[1]) %>%
    subset(DISEASE == input$select1) %>%
    group_by(REGION, XRAY_YEAR) %>%
    summarise(total = mean(n))
  toMerge$XRAY_YEAR <- NULL
  toMerge$n         <- NULL
  filt_toMerge <- filter(toMerge, DISEASE == input$select1)
  join         <- left_join(filt_toMerge, value, by = "REGION")
  dd.join      <- join[!duplicated(join), ]
  uscounties@data <- left_join(uscounties@data, dd.join, by = "GEO_ID")
  uscounties@data$total[is.na(uscounties@data$total)] <- 0
  leafletProxy("mapPlot", data = uscounties) %>%
    addPolygons(color = ~colorNumeric("YlOrRd", uscounties@data$total)(uscounties@data$total), fillOpacity = 0.5, weight = 1)
  })
  
  
  output$expPlot <- renderPlot({
    ncsr4 %>%
      filter(PMF == "PMF+", EXP >= input$slider1[1], EXP <= input$slider1[2]) %>%
      group_by(AGE) %>%
      count(AGE, REGION) %>%
      ggplot(aes(AGE, n, fill = REGION)) +
      geom_bar(stat = "identity", position = "stack") +
      ggtitle("Progressive Massive Fibrosis") +
      labs(x="Age",y="Number of Cases") +
      xlim(32, 62)
  
                              })

  output$cwpExpPlot <- renderPlot({
    ncsr4 %>%
      filter(CAT1 == "1/0+", EXP >= input$slider1[1], EXP <= input$slider1[2]) %>%
      group_by(AGE) %>%
      count(AGE, REGION) %>%
      ggplot(aes(AGE, n, fill = REGION)) +
      geom_bar(stat = "identity", position = "stack") +
      ggtitle("Coal Workers' Pneumoconiosis (Category 1 or Greater)") +
      labs(x="Age",y="Number of Cases") +
      xlim(32, 62) 
    
                                  })

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


  output$summary <- renderPrint({
    summary(rapidProg_disease)
  })
  
  
  output$downloadData <- downloadHandler( 
    filename = "rapidProgression.csv",
    content = function(file) {
      write.csv(rapidProg_disease, file)
    }
  )
  
  output$downloadData <- downloadHandler( 
    filename = "ncsr4.csv",
    content = function(file) {
      write.csv(ncsr4, file)
    }
  )
  
})
  

