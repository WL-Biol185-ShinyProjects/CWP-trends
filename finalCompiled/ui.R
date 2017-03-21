library(shiny)


navbarPage(theme = shinythemes::shinytheme("superhero"), "Trends",
           tabPanel("Exposure Plots",
                    sidebarLayout(
                      sidebarPanel(
                        sliderInput("slider1", 
                                    label = h3("Coal Exposure (gram-hours per cubic meter)"),
                                    min = 0, 
                                    max = 200,
                                    value = c(0, 200),
                                    round = TRUE)
                                   ),
                        mainPanel(
                          plotOutput("expPlot"),
                          plotOutput("cwpExpPlot")
                                 )
                                )
                    ),
                    
           tabPanel("Temporal Plots",
                    sidebarLayout(
                      sidebarPanel(
                        selectInput("select1", label = h3("Disease Box"), 
                                    choices = list("CWP" = "CWP", "PMF" = "PMF"), 
                                    selected = 1)
                                  ),
                      mainPanel(
                          tabsetPanel(type = "tabs",
                              tabPanel("Plot", plotOutput("linePlot")),
                              tabPanel("Summary", verbatimTextOutput("summary"))
                                     )
                                )
                               )
                    )
          )
                    
                            