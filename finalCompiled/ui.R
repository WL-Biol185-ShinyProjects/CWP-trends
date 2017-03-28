library(shiny)
library(leaflet)

navbarPage( theme = shinythemes::shinytheme("superhero")
          , "Trends"
          , selected = "Home"
          
          ##Home Page
          , tabPanel( "Home"
                    , h1("CWP and PMF Trends", align = "center")
                    , br()
                    , h2("Welcome!", align = "Left")
                    , br()
                    , mainPanel(
                          p( "This application allows visualization of current trends
                             of two potentially debilitating coal dust-related lung 
                             diseases: Coal Workers' Pneumoconiosis"
                             
                           , span( "(CWP)"
                                 , style = "color:red"
                                 )
                           
                           , "and Progressive Massive Fibrosis"
                           
                           , span( "(PMF)."
                                 , style = "color:red"
                                 , align = "center"
                                 )
                           ,"Please click on a tab above to begin!"
                           
                           , br()
                           , br()
                           
                           , img( src = "coal2.png"
                                , width = 480
                                , height = 250
                                , align = "center"
                                )
                           )
                               )
                    )
          
          ##Background Page
          , tabPanel( "Background"
                    , titlePanel("Background")
                    
                    , mainPanel( h3( "Coal Workers's Pneumoconiosis"
                                   , align = "left"
                                   , style = "color:red"
                                   )
                               
                               , br()
                               
                               , p( "CWP is a lung diseased caused by inhalation of 
                                    respirable coal dust from mining operations. It is 
                                    characerized by the presence of small opacities 
                                    (<10mm diameter) on chest radiographs. CWP is divided 
                                    into four profusion categories, 0-3, which indicate 
                                    increasing profusion or density of opacities in the lungs."
                                  )
                               
                               , br()
                               , br()
                          
                               , h3( "Progressive Massive Fibrosis"
                               , align = "left"
                               , style = "color:red"
                               )
                          
                               , br()
                          
                               , p( "PMF is an often debilitating lung disease which can 
                                    develop in patients with CWP. PMF is characterized by 
                                    large opacities (>10mm diameter) on a chest radiograph. 
                                    It is classified into three categories, A-C, indicating
                                    an increasing size of the large opacities."
                                  )
                               )
                    )
          
          ##Geographic Leaflet Map Plot
          , tabPanel( "Geographic Plots"
                    , sidebarLayout(
                        sidebarPanel(
                          sliderInput( "slider1"
                                     , label = h3("Years Mapped")
                                     , min = 1969
                                     , max = 2002
                                     , value = c(1969)
                                     , round = TRUE
                                     , sep = ""
                                     , animate = animationOptions(interval=5000)
                                     )
                          
                          , selectInput( "select1"
                                       , label = h3("Disease Box")
                                       , choices = list( "CWP" = "CWP"
                                                       , "PMF" = "PMF"
                                                       )
                                       , selected = 1
                                       )
                                    )
                        
                        , mainPanel( strong("Figure 1: xxx")
                                     
                                   , br()
                                   
                                   , p( "Geographic Trends of the number of cases of 
                                        PMF and CWP over time. Cases were grouped by 
                                        the commonly accepted regions in the 
                                        literature: Midwest, Southern Appalachia, 
                                        Central Appalachia, Northern Appalachia,
                                        and West."
                                      )
                        
                                   , leafletOutput("mapPlot")
                                   )
                                   )
                    )
          
          ##Exposure Bar Plots
          , tabPanel( "Exposure Plots"
                    , sidebarLayout(
                        sidebarPanel( "Choose:"
                                    , sliderInput("slider8" 
                                    , label = ("Coal Exposure (gram-hours per cubic meter)")
                                    , min = 0
                                    , max = 200
                                    , value = c(0, 200)
                                    , round = TRUE)
                                    )
                        
                        , mainPanel( strong("Figure 2")
                                     
                                   , p( "The number of individuals diagnosed with PMF is 
                                        displayed as a function of age. Stacked bars represent
                                        exposure to three types of coal: high rank, medium rank,
                                        and low rank."
                                      )
                               
                                   , plotOutput("expPlot")
                               
                                   , br()
                               
                                   , strong("Figure 3")
                                   
                                   , p( "The number of individuals diagnosed with CWP is 
                                        displayed as a function of age. Stacked bars represent 
                                        exposure to three types of coal: high rank, medium rank,
                                        and low rank."
                                      )
                               
                                   , plotOutput("cwpExpPlot")
                                   )
                                  )
                    )
          
          ##Temporal Line Plots by Region
          , tabPanel( "Temporal Plots"
                    , sidebarLayout(
                        sidebarPanel( selectInput( "select9"
                                                 , label = h3("Disease Box")
                                                 , choices = list( "CWP" = "CWP"
                                                                 , "PMF" = "PMF"
                                                                 )
                                                 , selected = 1
                                                 )
                                     )
                        , mainPanel( strong("Figure 4")
                                   , p( "The number of individuals with CWP or 
                                        PMF is displayed as a function of time. 
                                        Each line indicates a different coal 
                                        region."
                                      )
                                   
                                   , tabsetPanel( type = "pills"
                                                , tabPanel( "Plot"
                                                          , plotOutput("linePlot")
                                                          )
                                                , tabPanel( "Summary"
                                                          , verbatimTextOutput("summary")
                                                          )
                                                )
                                   )
                        )
                    )
          
          ##References and Sources
          , tabPanel( "References"
                    , mainPanel( h2("References")
                               
                               , br()
                               , br()
                               
                               , p( "Coal Picture from"
                                  , span( "http://www.pittstoncity.org/wp-content/uploads/2017/02/coal.jpg"
                                        , style = "color:red"
                                        )
                                  )
                               
                               , br()
                               
                               , p( "International labor Office Guidelines from"
                                  , span( "http://www.ilo.org/safework/info/WCMS_108548/lang--en/index.htm"
                                        , style = "color:red"
                                        )
                                  )
                               
                               , br()
                               , br()
                               , br()
                               
                               ,h2("Data")
                               
                               , downloadButton( "downloadData"
                                               , label = "Download Rapid Progression Data"
                                               , class = NULL
                                               )
                               
                               , p( "from"
                                  , span( "https://www.cdc.gov/niosh/topics/cwhsp/cwhsp-public-data.html"
                                        , style = "color:red"
                                        )
                                  )
                               
                               , br()
                               
                               , downloadButton( "downloadData1"
                                               , label = "Download ncsr4 Data"
                                               , class = NULL
                                               )
                               
                               , p( "from"
                                  , span( "https://www.cdc.gov/niosh/topics/cwhsp/cwhsp-public-data.html"
                                        , style = "color:red"
                                        )
                                  )
                               )
                    )
          )
            