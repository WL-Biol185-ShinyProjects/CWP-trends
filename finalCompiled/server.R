library(shiny)
library(ggplot2)
library(dplyr)
library(leaflet)

##Load in Data
rapidProg_disease <- read.csv("../data/rapidProg_disease.csv")
load("~/CWP-trends/mapPlot/data/serverData.RData")
ncsr4 <- read.csv("../data/ncsr4_clean.csv")

##Edit rapidProg_disease and ncsr4 to incude factored regions for exposure and line plots
rapidProg_disease$REGION <- factor( rapidProg_disease$REGION
                                  , levels = c( "West"
                                              , "Mid-West"
                                              , "Northern Appalachia"
                                              , "Central Appalachia"
                                              , "Southern Appalachia"
                                              )
                                  )

ncsr4$REGION <- factor( ncsr4$REGION, levels = c( "HI RANK"
                                                , "MED RANK"
                                                , "LOW RANK"
                                                )
                      )


##Server Code
shinyServer(function(input, output) {
  
##Geographic Leaflet Map Plot  
  ##Render Initial Leaflet map wih just state polygons
  output$mapPlot <- renderLeaflet({
    leaflet(data = uscounties) %>%
      addTiles() %>%
      addPolygons( data = usstates
                 , color = "black"
                 , weight = 5
                 , fillOpacity = 0
                 ) %>%
      setView( lng = -93.85
             , lat = 37.45
             , zoom = 4
             )
    })
  
  ##Filter and subset data for counties colored by number of cases
  observe({
    ##Create variable 'value' containing needed values for number of cases based on parameters passed from ui.R
    value <- toMerge %>%
    filter(XRAY_YEAR == input$slider1[1]) %>%
    subset(DISEASE == input$select1) %>%
    group_by(REGION, XRAY_YEAR) %>%
    summarise(total = mean(n))
  
    toMerge$XRAY_YEAR <- NULL
    toMerge$n         <- NULL
    
    ##Merge value df with merge in order to be able to merge into uscounties
    filt_toMerge <- filter(toMerge, DISEASE == input$select1)
    join         <- left_join(filt_toMerge, value, by = "REGION")
    dd.join      <- join[!duplicated(join), ]
    
    ##Merge dd.joi with uscounties
    uscounties@data <- left_join(uscounties@data, dd.join, by = "GEO_ID")
    uscounties@data$total[is.na(uscounties@data$total)] <- 0
    
    ##Add in county data colored by number of cases to existing leaflet map
    leafletProxy("mapPlot", data = uscounties) %>%
    addPolygons( color = ~colorNumeric( "YlOrRd"
                                      , uscounties@data$total)(uscounties@data$total)
               , fillOpacity = 0.5
               , weight = 1
               )
  })
  
##Exposure Bar Plots
  ##PMF
  output$expPlot <- renderPlot({
    ##Filter based on ui.R input
    ncsr4 %>%
      filter( PMF == "PMF+"
            , EXP >= input$slider1[1]
            , EXP <= input$slider1[2]
            ) %>%
      group_by(AGE) %>%
      count(AGE, REGION) %>%
      
      ##Plot
      ggplot(aes(AGE , n, fill = REGION)) +
      geom_bar(stat = "identity", position = "stack") +
      ggtitle("Progressive Massive Fibrosis") +
      labs(x="Age", y="Number of Cases") +
      xlim(32, 62)
    })
  
  ##CWP
  output$cwpExpPlot <- renderPlot({
    ##Filter based on ui.R input
    ncsr4 %>%
      filter( CAT1 == "1/0+"
            , EXP >= input$slider1[1]
            , EXP <= input$slider1[2]
            ) %>%
      group_by(AGE) %>%
      count(AGE, REGION) %>%
      
      ##Plot
      ggplot(aes(AGE, n, fill = REGION)) +
      geom_bar(stat = "identity", position = "stack") +
      ggtitle("Coal Workers' Pneumoconiosis (Category 1 or Greater)") +
      labs(x="Age",y="Number of Cases") +
      xlim(32, 62) 
    })

##Temporal Line Plots by Region
  output$linePlot <- renderPlot({
    ##Filter based on ui.R input
    rapidProg_disease %>%
      filter(DISEASE == input$select1) %>%
      group_by(XRAY_YEAR) %>%
      count(XRAY_YEAR, REGION) %>%
      
      ##Plot
      ggplot(aes(XRAY_YEAR, n, color = REGION)) +
      geom_line() +
      ggtitle("Temporal Disease Trends") +
      labs(x="Year",y="Number of Cases") +
      xlim(1969, 2002)
      
    })

  ##Summary data for rapidProg for Temporal Line Plots tab
  output$summary <- renderPrint({
    summary(rapidProg_disease)
  })
  
  
##Tab for downloading the raw data used
  ##rapidProgression
  output$downloadData <- downloadHandler( filename = "rapidProgression.csv"
                                        , content = function(file) {
                                          write.csv(rapidProg_disease, file)
                                          }
                                        )
  ##ncsr4
  output$downloadData <- downloadHandler( filename = "ncsr4.csv"
                                        , content = function(file) {
                                          write.csv(ncsr4, file)
                                          }
                                        )
})
