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

ncsr4 <- read.csv("../data/ncsr4_clean.csv")

ncsr4$REGION <- factor(ncsr4$REGION, levels = c("HI RANK", "MED RANK", "LOW RANK"))

shinyServer(function(input, output) {
  
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
  })

