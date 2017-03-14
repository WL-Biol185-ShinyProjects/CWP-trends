library(shiny)

# Define UI for application that draws a histogram
fluidPage(
  titlePanel("Approach"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("slider1", 
              label = h3("Coal Exposure (gram-hours per cubic meter)"),
              min = 0, 
              max = 200,
              value = c(0, 200)
                 ),
      selectInput("select1", label = h3("Select Disease"), 
                  choices = list("CWP-Category 1 " = 1, "CWP-Category 2" = 2, "PMF" = 3), 
                  selected = 1)
                ),
    
      mainPanel(
        plotOutput("expPlot") )
    
              )
               )
        

 
