# Load required packages
library(shiny)
library(ggplot2)
library(dplyr)

# Load the data
data <- cleaned_survey

# Define UI
ui <- fluidPage(
  titlePanel("How Often Does Mental Health Interfere with Work?"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("work_interfere", "Select Mental Health Interference Level:",
                  choices = c("Never", "Rarely", "Sometimes", "Often"),
                  selected = "Sometimes"),
      checkboxInput("show_all", "Show All Data", value = TRUE)
    ),
    
    mainPanel(
      plotOutput("interferencePlot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  output$interferencePlot <- renderPlot({
    plot_data <- data %>%
      filter(if(input$show_all) TRUE else work_interfere == input$work_interfere)
    
    ggplot(plot_data, aes(x = work_interfere, fill = work_interfere)) +
      geom_bar() +
      labs(
        title = "Mental Health Interference at Work",
        x = "Mental Health Interference",
        y = "Count",
        fill = "Interference Level"
      ) +
      theme_minimal()
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
