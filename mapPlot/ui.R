library(shiny)

# Define UI for application that draws a histogram
fluidPage(
  titlePanel("Approach"),
  sidebarLayout(
    sidebarPanel(
      sliderInput( "slider1"
                 , label = h3("Years Mapped")
                 , min = 1969
                 , max = 2002
                 , value = c(1969, 2002)
                 , round = TRUE
                 , sep = ""
                 ),
      
      selectInput( "select1"
                 , label = h3("Disease Box")
                 , choices = list("CWP" = "CWP", "PMF" = "PMF")
                 , selected = 1
                 )
                ),
    
    mainPanel(
      plotOutput("mapPlot")
             )
    
               )
        )
