library(shiny)

navbarPage(theme = shinythemes::shinytheme("superhero"), 
           "Trends",
           selected = "Exposure Plots",
           titlePanel(
                      h1 ("CWP and PMF Trends", align = "center")
                     ),
           tabPanel("Exposure Plots",
                    sidebarLayout(
                      sidebarPanel("Choose:",
                        sliderInput("slider1", 
                                    label = ("Coal Exposure (gram-hours per cubic meter)"),
                                    min = 0, 
                                    max = 200,
                                    value = c(0, 200),
                                    round = TRUE)
                                   ),
                        mainPanel(
                          strong("Figure 2"),
                          p("The number of individuals diagnosed with PMF is 
                            displayed as a function of age. Stacked bars represent
                            exposure to three types of coal: high rank, medium rank,
                            and low rank."),
                          plotOutput("expPlot"),
                          br(),
                          strong("Figure 3"),
                          p("The number of individuals diagnosed with CWP is 
                            displayed as a function of age. Stacked bars represent 
                            exposure to three types of coal: high rank, medium rank,
                            and low rank."),
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
                        strong("Figure 4"),
                        p("The number of individuals with CWP or PMF is displayed as a function of time. Each line indicates a different coal region."),
                        tabsetPanel(type = "pills",
                              tabPanel("Plot", plotOutput("linePlot")),
                              tabPanel("Summary", verbatimTextOutput("summary"))
                                     )
                                )
                               )
                    )
          )
                    
                            