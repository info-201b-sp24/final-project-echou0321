# Load required packages
library(shiny)
library(ggplot2)
library(dplyr)

# Load the data from GitHub
data <- read.csv("https://raw.githubusercontent.com/info-201b-sp24/final-project-echou0321/main/cleaned_survey.csv")

# Define UI
ui <- fluidPage(
  titlePanel("Wellness Programs and Employee Perceptions of Mental Health Support"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("benefits", "Select Perception of Employer Support:",
                  choices = unique(data$benefits),
                  selected = unique(data$benefits)[1]),
      checkboxInput("show_all", "Show All Data", value = TRUE)
    ),
    
    mainPanel(
      plotOutput("wellnessPlot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  output$wellnessPlot <- renderPlot({
    plot_data <- data %>%
      filter(if(input$show_all) TRUE else benefits == input$benefits)
    
    ggplot(plot_data, aes(x = wellness_program, fill = benefits)) +
      geom_bar(position = "dodge") +
      labs(
        title = "Correlation between Wellness Programs and Perceptions of Mental Health Support",
        x = "Existence of Wellness Program",
        y = "Count",
        fill = "Perceived Support"
      ) +
      theme_minimal()
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
