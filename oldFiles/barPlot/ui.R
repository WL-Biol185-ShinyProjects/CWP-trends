library(shiny)

# Define UI for application that draws a histogram
fluidPage(
  titlePanel("Command Center"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("slider1", 
              label = h3("Coal Exposure (gram-hours per cubic meter)"),
              min = 0, 
              max = 200,
              value = c(0, 200),
              round = TRUE
                 )
                ),
    
      mainPanel(
        plotOutput("expPlot"),
        plotOutput("cwpExpPlot"))
    
              )
               )
        

 
