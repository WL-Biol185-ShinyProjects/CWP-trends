library(shiny)
library(jpeg)

navbarPage(theme = shinythemes::shinytheme("superhero"), 
                      "Trends",
                      selected = "Home",
           titlePanel(
                      h1 ("CWP and PMF Trends", align = "center")
                     ),
           tabPanel("Home",
                      h2("Welcome!", align = "center"),
                      br(),
                      mainPanel(
                          p("This application allows visualization of current trends
                          of two potentially debilitating coal dust-related lung 
                          diseases: Coal Workers' Pneumoconiosis", span("(CWP)", 
                                        style = "color:red"),
                                     "and Progressive Massive Fibrosis",
                                     span("(PMF).",
                                        style = "color:red"),
                          br(),
                          img(src = "coal101914.jpg", height = 200, width = 200) #need to figure this out for uploading image
                          )
                              )
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
                    
                            