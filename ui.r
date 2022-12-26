shinyUI(fluidPage(
  titlePanel("World Happiness Data"),
  tabsetPanel(
    tabPanel("Generosity", 
             sidebarLayout(
 

               sidebarPanel(
                 selectInput("dataset1","select year",
                             choices = c("2015","2016")),
                 selectInput("region1","Select the continent",
                             choices = c("All","Western Europe","Australia and New Zealand","Latin America and Caribbean","Eastern Asia","Central and Eastern Europe","Australia and New Zealand","Middle East and Northern Africa","North America","Southeastern Asia","Southern Asia","Sub-Saharan Africa"))
                 
                 
               ),
               mainPanel(
                 plotOutput("myPlot")
               )
             )
  
            ),
    
    tabPanel("Data and Prediction",
             
             sidebarPanel(
               selectInput("dataset2","select year",
                           choices = c("2015","2016")),
              
               textInput("country","Input the country")
            
               
               ),
             
             mainPanel(
               tabsetPanel(type="tab",
                           tabPanel("Summary",
                                    verbatimTextOutput("summary"),
                                    helpText("Predicted Happiness score"),
                                    verbatimTextOutput("predScore"),
                                    helpText("Real score"),
                                    verbatimTextOutput("realScore")),
                           tabPanel("Data", 
                                    formattableOutput("data")),
                           tabPanel("Plot",
                                    plotOutput("myPredict")),
                           tabPanel("Correlation",
                                    plotOutput("correl") )
                 
                 
               )
               
             )
             
             
             ),
    tabPanel("Freedom",
             sidebarLayout(
               
               
               
               ##headerPanel("Does generosity affect Happiness?"),
               sidebarPanel(
                 selectInput("dataset3","select year",
                             choices = c("2015","2016")),
                 selectInput("region3","Select the continent",
                             choices = c("Western Europe","Australia and New Zealand","Latin America and Caribbean","Eastern Asia","Central and Eastern Europe","Australia and New Zealand","Middle East and Northern Africa","North America","Southeastern Asia","Southern Asia","Sub-Saharan Africa"))
                 
                 
               ),
               mainPanel(
                 plotOutput("geomText")
               )
             )
             
             
             ),
    tabPanel("Plot_ly",
             sidebarLayout(
      
               sidebarPanel(
                 selectInput("datasetPlotly","select year",
                             choices = c("2015","2016"))
                 
                 
               ),
               mainPanel(
                 plotlyOutput("tride")
               )
             )
             
             
    ),
    
    tabPanel("Boxplot",
             sidebarLayout(
               
               
               
               
               sidebarPanel(
                 selectInput("datasetBox","select year",
                             choices = c("2015","2016"))
                 
                 
               ),
               mainPanel(
                 plotlyOutput("boxes")
               )
             )
             
             
    ),
    
    tabPanel("Clusters",
             sidebarLayout(
               
               
               
               
               sidebarPanel(
                 selectInput("datasetClust","select year",
                             choices = c("2015","2016"))
                 
                 
               ),
               mainPanel(
                 plotOutput("clust")
               )
             )
            ),
    
    tabPanel("Map",
             sidebarLayout(
               
               
               
               ##headerPanel("Does generosity affect Happiness?"),
               sidebarPanel(
                 selectInput("dataset4","select year",
                             choices = c("2015","2016"))
                 
                 
               ),
               mainPanel(
                 plotOutput("googlemap")
               )
             )
             
             
    )

    
 
  )))
 