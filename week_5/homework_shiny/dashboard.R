library(shiny)
library(shinythemes)
#library(shinydashboard)
source("homework_covid19.R")


ui <- fluidPage(
  #Theme
  theme = shinytheme("darkly"),
  titlePanel("Covid-19 UK analysis"),
  tabsetPanel(
    tabPanel("Total analysis",
      
    ),
    tabPanel("Confirmed cases",
             
    ),
    tabPanel("Recovered",
             
    ),
    tabPanel("Deaths",
             
    ),
    tabPanel("By country",
             
    ),
  )
)

server <- function(input, output) { 
  
  }

shinyApp(ui, server)