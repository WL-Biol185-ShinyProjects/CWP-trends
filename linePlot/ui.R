library(shiny)

# Define UI for application that draws a histogram
fluidPage(
  titlePanel("Command Center"),
  sidebarLayout(
    sidebarPanel(
      selectInput("select1", label = h3("Disease Box"), 
                  choices = list("CWP" = 1, "PMF" = 2), 
                  selected = 1)
                ),
              
  mainPanel(
    plotOutput("linePlot"))
  
)
)