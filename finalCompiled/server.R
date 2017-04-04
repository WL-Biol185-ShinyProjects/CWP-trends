library(shiny)
library(ggplot2)
library(dplyr)
library(leaflet)

##Load in Data
rapidProg_disease <- read.csv("../data/rapidProg_disease.csv")
ncsr4             <- read.csv("../data/ncsr4_clean.csv")
load("~/CWP-trends/mapPlot/data/serverData.RData")

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
    
    ##Merge dd.join with uscounties
    uscounties@data <- left_join(uscounties@data, dd.join, by = "GEO_ID")
    uscounties@data$total[is.na(uscounties@data$total)] <- 0
    
    ##Generate Color Matrix
    colNum   <- length(unique(uscounties@data$total))
    colfunc  <- colorRampPalette(c("white", "red"))
    col      <- colfunc(colNum)
    pal      <- colorNumeric( col
                            , domain = uscounties@data$total
                            , na.color = "#FFFFFF"
                            )
    mapColor <- pal(uscounties@data$total)
  
  ##Plot Map
  output$mapPlot <- renderLeaflet({
    leaflet(uscounties) %>%
      addTiles(options = tileOptions(noWrap = TRUE)) %>%
      setView(lng = -93.85, lat = 37.45, zoom = 4) %>%
      addPolygons( color       = mapColor
                 , fillOpacity = 0.5
                 , weight      = 1
                 ) %>%
      addPolygons( data        = usstates
                 , color       = "black"
                 , weight      = 3
                 , fillOpacity = 0
                 ) %>%
      addLegend( position = "bottomleft"
               , pal      = pal
               , values   = unique(uscounties@data$total)
               , title    = paste( "Number of"
                                 , input$select1
                                 , "Cases per Region"
                                 )
               )
  })
})
  
  
##Exposure Bar Plots
  ##PMF
  output$expPlot <- renderPlot({
    ##Filter based on ui.R input
    ncsr4 %>%
      filter( PMF == "PMF+"
             , EXP >= input$slider8[1]
             , EXP <= input$slider8[2]
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
             , EXP >= input$slider8[1]
             , EXP <= input$slider8[2]
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
 colpal <- c("deepskyblue2", "forestgreen", "gold2", "darkorchid2", "firebrick2") 
 
 
  output$linePlot <- renderPlot({
    ##Filter based on ui.R input
    rapidProg_disease %>%
      filter(DISEASE == input$select9) %>%
      group_by(XRAY_YEAR) %>%
      count(XRAY_YEAR, REGION) %>%
      
      ##Plot
      ggplot(aes(XRAY_YEAR, n, color = REGION)) +
      geom_line() +
      scale_colour_manual(values = c("Northern Appalachia" = "deepskyblue2"
                                     , "Central Appalachia" = "forestgreen"
                                     , "Southern Appalachia" = "gold2"
                                     , "Mid-West" = "darkorchid2"
                                     , "West" = "firebrick2")) +
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
