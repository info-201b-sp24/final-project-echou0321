# Load required packages
library(shiny)
library(ggplot2)
library(dplyr)

# Load the data from GitHub
data <- read.csv("https://raw.githubusercontent.com/info-201b-sp24/final-project-echou0321/main/shinyApp/cleaned_survey.csv")

# Define UI
ui <- fluidPage(
  titlePanel("Mental Health Interference and Remote Work Options"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("work_interfere", "Select Mental Health Interference Level:",
                  choices = c("Never", "Rarely", "Sometimes", "Often"),
                  selected = "Sometimes"),
      checkboxInput("show_all_interference", "Show All Interference Levels", value = TRUE),
      selectInput("remote_work", "Select Remote Work Option:",
                  choices = unique(data$remote_work),  # Use unique values from the data
                  selected = unique(data$remote_work)[1]),  # Set default to the first unique value
      checkboxInput("show_all_remote", "Show All Remote Work Options", value = TRUE)
    ),
    
    mainPanel(
      plotOutput("remoteInterferencePlot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  output$remoteInterferencePlot <- renderPlot({
    plot_data <- data %>%
      filter(
        (if(input$show_all_interference) TRUE else work_interfere == input$work_interfere) &
          (if(input$show_all_remote) TRUE else remote_work == input$remote_work)
      )
    
    ggplot(plot_data, aes(x = remote_work, fill = work_interfere)) +
      geom_bar(position = "dodge") +
      labs(
        title = "Mental Health Interference at Work by Remote Work Options",
        x = "Remote Work Option",
        y = "Count",
        fill = "Mental Health Interference"
      ) +
      theme_minimal()
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

