library(shiny)
library(shinythemes)
library(dplyr)
library(ggplot2)
library(CodeClanData)

all_countries <- olympics_overall_medals$team

all_teams <- unique(olympics_overall_medals$team)
# Define UI for application that draws a histogram
ui <- fluidPage(
    #Theme
    theme = shinytheme("darkly"),
    # Application title
    titlePanel("Olympics Medal Comparison"),

    tabsetPanel(
        tabPanel("Random Sample Plot",
    # Sidebar with a slider input for number of bins 
    fluidRow(
        
        # Show a plot of the generated distribution
        
            column(10,
            plotOutput("distPlot")
            ),
            
            column(2,
                   radioButtons(
                       "season", #ID
                       tags$h3("Choose Season"), #LABEL
                       choices = c("Summer", "Winter"), selected = "Summer"
                   ),
                   radioButtons(
                       "medal", #ID
                       tags$h3("Pick Medal"), #LABEL
                       choices = c("Bronze", "Silver", "Gold"), selected = "Gold"
                   ),
                  
                   
                   # Copy the line below to make a slider bar 
                   sliderInput("slider1", 
                               label = h3("Number of Countries (random)"), 
                               min = 1, 
                               max = length(all_teams), 
                               value = 20),
                 
            )
        ),
    fluidRow(
        column(12,
               tags$h3("Data sampled"),
               tableOutput('table')
        )
    )
    ),
    tabPanel("Specific Country Plot",
    # Copy the line below to make a select box 
            fluidRow(
                # Show a plot of the generated distribution
                column(10,
                       plotOutput("distPlot2")
                ),
                
                column(2, 
                       selectInput("select2", 
                            label = h3("Select country"), 
                            choices = all_teams, selected = "Chile"),
                       radioButtons(
                           "season2", #ID
                           tags$h3("Choose Season"), #LABEL
                           choices = c("Summer", "Winter"), selected = "Summer"
                           ),
                       # Copy the chunk below to make a group of checkboxes
                       checkboxGroupInput("checkGroup", 
                                          label = h3("Select medals"), 
                                          choices = c("Gold", "Bronze", "Silver"),
                                          selected = c("Gold", "Silver", "Bronze"))
                    )
                )
            )
    )

)
# Define server logic required to draw a histogram
server <- function(input, output) {
    selectedTable <- reactive({
        sample_n(olympics_overall_medals, 
                 input$slider1)
    })

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
         selectedTable() %>%
            filter(medal == input$medal) %>%
            filter(season == input$season) %>%
            ggplot() +
            aes(x = count, y = team, fill = team) +
            geom_col() +
            labs(x = "Total medals",
                 y = "Team", 
                caption = paste("(Based on data selected by user from a random sample of size",
                                input$slider1,". Check table below for further information)")
                )
    })
    output$table <- renderTable(
        selectedTable()
    ) 
    
    
    output$distPlot2 <- renderPlot({
        # generate bins based on input$bins from ui.R
        olympics_overall_medals %>%
            filter(medal %in% input$checkGroup) %>%
            filter(season == input$season2) %>%
            filter(team == input$select2) %>% 
            ggplot() +
            aes(x = medal, y = count, fill = medal) +
            geom_col() +
            scale_fill_manual(values = c(
                "Gold" = "#DAA520",
                "Silver" = "#C0C0C0",
                "Bronze" = "#CD7F32")) +
                labs(caption = paste("(Medals won by ", input$select2, " during ", input$season2, ")"),
                     y = "Total medals",
                     x = "")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
