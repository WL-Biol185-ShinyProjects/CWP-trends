library(shiny)

# Define UI for application that draws a histogram
fluidPage(
  fluidRow(
    column(4,
    sidebarLayout(
    sidebarPanel(
  sliderInput("slider1", 
              label = h3("Coal Exposure (gram-hours per cubic meter)"),
              min = 0, 
              max = 100,
              value = c(40, 60))
                )
                 )
         )
         ),
  mainPanel(
  plotOutput("expPlot")
           )
        )

 
