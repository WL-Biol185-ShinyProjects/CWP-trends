library(shiny)
library(leaflet)

navbarPage( theme = shinythemes::shinytheme("slate")
          , "CWP & PMF Trends"
          , selected = "Home"
          , header = "© 2017 John Bowman, Michael North Jr."
          , collapsible = TRUE
          
          ##Home Page
          , tabPanel( "Home"
                    , fluidRow( h1( span( "CWP"
                                        , style = "color:#ffb499"
                                        )
                                  , "and"
                                  , span( "PMF"
                                        , style = "color:#92ede8"
                                        )
                                  , "Trends"
                                  , align = "center"
                                  )
                                       
                              , br()
                              , br()
                              
                              , p( "Welcome! This application allows
                                   visualization of current trends of two 
                                   potentially debilitating coal dust-related 
                                   lung diseases: Coal Workers' Pneumoconiosis"
                                  , span( "(CWP)", style = "color:#ffb499")
                                  , "and Progressive Massive Fibrosis"
                                  , span( "(PMF)."
                                        , style = "color:#92ede8"
                                        , align = "center"
                                        )
                                  , "Please click on a tab above to begin!"
                                  , align = "center"
                                  )

                              , br()
                              , br()
                           
                              , img( src = "coal2.png"
                                   , width = 480
                                   , height = 250
                                   , style = "display: block; margin-left: auto; margin-right: auto;"
                                   )
                              )
                    )
                    
          
          ##Background Page
          , tabPanel( "Background"
                    , titlePanel("Background")
                    
                    , mainPanel( h3( "Coal Workers's Pneumoconiosis"
                                   , align = "left"
                                   , style = "color:#ffb499"
                                   )
                               
                               , br()
                               
                               , p( span( "CWP", style = "color:#ffb499")
                                  , "is a lung diseased caused by inhalation 
                                    of respirable coal dust from mining 
                                    operations. It is characerized by the 
                                    presence of small opacities (<10mm diameter)
                                    on chest radiographs."
                                  , span("CWP"
                                  , style = "color:#ffb499")
                                  , "is divided 
                                    into four profusion categories, 0-3, which 
                                    indicate increasing profusion or density of 
                                    opacities in the lungs."
                                  )
                               
                               , br()
                               , br()
                          
                               , h3( "Progressive Massive Fibrosis"
                               , align = "left"
                               , style = "color:#92ede8"
                               )
                          
                               , br()
                          
                               , p( span( "PMF", style = "color:#92ede8")
                                  , "is an often debilitating lung disease which
                                    can develop in patients with"
                                  , span("CWP", style = "color:#ffb499")
                                  , "and is characterized by large opacities 
                                    (>10mm diameter) on a chest radiograph. It 
                                    is classified into three categories, A-C, 
                                    indicatingan increasing size of the large 
                                    opacities."
                                  )
                               )
                    , width = 12
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

                    , mainPanel( tabsetPanel( type = "pills"
                                            , tabPanel( "Plot"
                                                      , plotOutput("linePlot")
                                                 
                                            , strong("Figure 1")
                                                  
                                            , p( "The number of individuals with"
                                               , span( "CWP"
                                                     , style = "color:#ffb499"
                                                     ) 
                                               ,"or"
                                               , span( "PMF"
                                                     , style = "color:#92ede8"
                                                     )
                                               , "displayed as a function 
                                                 of time. Lines are colored by
                                                 represented region."
                                               , br()
                                               , br()
                                               , h6( span( "West:"
                                                         , style = "color:#d62929"
                                                         )
                                                   , "All Counties in Arizona 
                                                     , Colorado, Montana,  
                                                     New Mexico, North Dakota
                                                     , Oklahoma, Texas, Utah,
                                                     Wyoming, and Washington."
                                                   )
                                               , h6( span( "Mid-West:"
                                                         , style = "color:#c284e1"
                                                         )
                                                   , "All Counties in 
                                                     Illinois and Indiana; 
                                                     Hopkins, Union, and 
                                                     Webster Counties in 
                                                     Kentucky."
                                                   )
                                               , h6( span( "Northern Appalachia:"
                                                         , style = "color:DeepSkyBlue"
                                                         )
                                                   , "All Counties in Maryland
                                                     , Pennsylvania and Ohio;
                                                     Barbour, Brooke, Clay, 
                                                     Grant, Greenbrier, 
                                                     Harrison, Lincoln, 
                                                     Marion, Marshall, 
                                                     Monongalia, Preston, 
                                                     Raleigh, Randolph, 
                                                     Tucker, Upshur, and 
                                                     Webster Counties in West
                                                     Virginia."
                                                   )
                                               , h6( span( "Central Appalachia:"
                                                         , style = "color:#2db92d"
                                                         )
                                                   , "All Counties in Virginia 
                                                     and Tennessee; Bell, Boyd
                                                     , Breathitt, Christian, 
                                                     Clay, Daviess, Estill, 
                                                     Floyd, Harlan, Henderson
                                                     , Jackson, Johnson, Knott
                                                     , Knox, Laurel, Lawrence
                                                     , Leslie, Letcher, Martin
                                                     , Mclean, Muhlenberg, 
                                                     Perry, Pike, Whitley, 
                                                     and Wolfe Counties in 
                                                     Kentucky; Boone, Fayette
                                                     , Kanawha, Logan, 
                                                     McDowell, Mingo, Nicholas
                                                     , Wayne, and Wyoming 
                                                     Counties in West 
                                                     Virginia."
                                                   )
                                               , h6( span( "Southern Appalachia:"
                                                         , style = "color:Gold"
                                                         )
                                                   , "All Counties in Alabama
                                                     , Arkansas, and Louisiana."
                                                   )
                                              )
                                            )
                                            , tabPanel( "Summary"
                                                      , verbatimTextOutput("summary")
                                                      )
                                           )
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
                                     , value = c(1985)
                                     , round = TRUE
                                     , sep = ""
                                     )
                          
                          , selectInput( "select1"
                                       , label = h3("Disease Box")
                                       , choices = list( "CWP" = "CWP"
                                                       , "PMF" = "PMF"
                                                       )
                                       , selected = 1
                                       )
                                    )
                        
                        , mainPanel( leafletOutput("mapPlot")
                                   , strong("Figure 2")
                                     
                                   , br()
                                   
                                   , p( "Geographic Trends of the number of"
                                      , span( "PMF", style = "color:#92ede8")
                                      , " cases and"
                                      , span( "CWP", style = "color:#ffb499")
                                      , "over time. Cases are grouped by 
                                        the commonly accepted regions in the 
                                        literature: "
                                      , span( "West", style = "color:#d62929")
                                      , ","
                                      , span( "Mid-West"
                                            , style = "color:#c284e1"
                                            )
                                      , ","
                                      , span( "Northern Appalachia"
                                            , style = "color:DeepSkyBlue"
                                            )
                                      , ","
                                      , span( "Central Appalachia"
                                            , style = "color:#2db92d"
                                            )
                                      , ","
                                      , "and"
                                      , span( "Southern Appalachia"
                                            , style = "color:Gold"
                                            )
                                      , "."
                                      )
                                  
                                   , br()
                                   , br()
                                  
                                   , h6( span("West:", style = "color:#d62929")
                                       , "All Counties in Arizona, Colorado, 
                                         Montana, New Mexico, North Dakota, 
                                         Oklahoma, Texas, Utah, Wyoming, and 
                                         Washington."
                                       )
                                  
                                   , h6( span( "Mid-West:"
                                             , style = "color:#c284e1"
                                             )
                                       , "All Counties in Illinois and Indiana; 
                                         Hopkins, Union, and Webster Counties in 
                                         Kentucky."
                                       )
                                  
                                   , h6( span( "Northern Appalachia:"
                                             , style = "color:DeepSkyBlue"
                                             )
                                       , "All Counties in Maryland,
                                         Pennsylvania and Ohio; Barbour, Brooke, 
                                         Clay, Grant, Greenbrier,Harrison, 
                                         Lincoln, Marion, Marshall, Monongalia, 
                                         Preston, Raleigh, Randolph, Tucker, 
                                         Upshur, and Webster Counties in West 
                                         Virginia."
                                       )
                                  
                                   , h6( span( "Central Appalachia:"
                                             , style = "color:#2db92d"
                                             ) 
                                       , "All Counties in Virginia and Tennessee;
                                         Bell, Boyd, Breathitt, Christian, Clay, 
                                         Daviess, Estill, Floyd, Harlan, 
                                         Henderson, Jackson, Johnson, Knott, Knox
                                         , Laurel, Lawrence, Leslie, Letcher, 
                                         Martin, Mclean, Muhlenberg, Perry, Pike,
                                         Whitley, and Wolfe Counties in Kentucky;
                                         Boone, Fayette, Kanawha, Logan, McDowell
                                         , Mingo, Nicholas, Wayne, and Wyoming 
                                         Counties in West Virginia."
                                       )
                                  
                                   , h6( span( "Southern Appalachia:"
                                             , style = "color:Gold"
                                             )
                                       , "All Counties in Alabama, Arkansas, 
                                         and Louisiana."
                                       )
                                   )
                                   )
                    )

          
          ##Exposure Bar Plots
          , tabPanel( "Exposure Plots"
                    , sidebarLayout(
                        sidebarPanel(sliderInput("slider8"
                                    , label = h3("Coal Exposure (gram-hours per cubic meter)")
                                    , min = 0
                                    , max = 200
                                    , value = c(0, 200)
                                    , round = TRUE)
                                    )
                        
                        , mainPanel( column( 6
                                           , align = "left"
                                           , plotOutput("expPlot")
                                   
                                           , strong("Figure 3")
                                   
                                           , p( "The number of individuals diagnosed with"
                                              , span( "PMF"
                                                    , style = "color:#92ede8"
                                                    )
                                              , "displayed as a function of age. 
                                                Stacked bars represent exposure 
                                                to three types of coal: high
                                                , medium, and low rank."
                                              )
                                           )
                               
                                   , column( 6
                                           , align = "left"
                                           , plotOutput("cwpExpPlot") 
                                     
                                           , strong("Figure 4")
                                   
                                           , p( "The number of individuals diagnosed with"
                                              , span( "CWP"
                                                    , style = "color:#ffb499"
                                                    )
                                              , "displayed as a function of age.
                                                Stacked bars represent exposure 
                                                to three types of coal: high 
                                                , medium, and low rank."
                                              )
                               
                                           )
                                  )
                                 ) 
                    )
          
          
          ##References and Sources
          , tabPanel( "References"
                    , fluidRow( h2("References")
                               
                               , br()
                               , br()
                               
                               , p( "Coal Picture from:"
                                  , span( a( href = "http://www.pittstoncity.org/wp-content/uploads/2017/02/coal.jpg"
                                           , "http://www.pittstoncity.org/wp-content/uploads/2017/02/coal.jpg"
                                           )
                                        )
                                  )
                               
                               , br()
                               
                               , p( "International labor Office Guidelines from:"
                                  , span( a( href = "http://www.ilo.org/safework/info/WCMS_108548/lang--en/index.htm"
                                           , "http://www.ilo.org/safework/info/WCMS_108548/lang--en/index.htm")
                                        )
                                  )
                               
                               , br()
                               , br()
                               
                               ,h2("Data")
                               
                               , downloadButton( "downloadData"
                                               , label = "Download Rapid Progression Data"
                                               , class = NULL
                                               )
                               
                               , p( "or from:"
                                  , span( a( href = "https://www.cdc.gov/niosh/topics/cwhsp/cwhsp-public-data.html"
                                           , "https://www.cdc.gov/niosh/topics/cwhsp/cwhsp-public-data.html")
                                        )
                                  )
                               
                               , br()
                               
                               , downloadButton( "downloadData1"
                                               , label = "Download ncsr4 Data"
                                               , class = NULL
                                               )
                               
                               , p( "or from:"
                                  , span( a( href = "https://www.cdc.gov/niosh/topics/cwhsp/cwhsp-public-data.html"
                                           , "https://www.cdc.gov/niosh/topics/cwhsp/cwhsp-public-data.html")
                                        )
                                  )
                               
                               , p( "GeoJSON data from:"
                                  , br()
                                  , span( a( href = "http://eric.clst.org/wupl/Stuff/gz_2010_us_050_00_5m.json"
                                           , "http://eric.clst.org/wupl/Stuff/gz_2010_us_050_00_5m.json")
                                        )
                                  , br()
                                  , span( a( href = "http://eric.clst.org/wupl/Stuff/gz_2010_us_040_00_5m.json"
                                           , "http://eric.clst.org/wupl/Stuff/gz_2010_us_040_00_5m.json")
                                        )
                                  , br()
                                  , "and the U.S. Census Bureau."
                                  )
                               )
                )
          )
