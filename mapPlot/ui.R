library(shiny)

# Define UI for application that draws a histogram
fluidPage(
  titlePanel("Approach"),
  sidebarLayout(
    sidebarPanel(
      sliderInput( "slider1"
                 , label = h3("Coal Exposure (gram-hours per cubic meter)")
                 , min = 0
                 , max = 200
                 , value = c(0, 200)
                 , round = TRUE
                 ),
      
      selectInput( "select1"
                 , label = h3("Disease Box")
                 , choices = list("CWP" = "CWP", "PMF" = "PMF")
                 , selected = 1
                 )
                ),
    
    mainPanel(
      plotOutput("expPlot")
             )
    
               )
        )
