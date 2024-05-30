# Load required packages
library(shiny)
library(ggplot2)
library(dplyr)

# Load the data from GitHub
data <- read.csv("https://raw.githubusercontent.com/info-201b-sp24/final-project-echou0321/main/shinyApp/cleaned_survey.csv")

# Mapping for dropdown menu
consequence_labels <- c("No consequences" = "No", 
                        "Maybe consequences" = "Maybe", 
                        "Yes consequences" = "Yes")

# Define UI
ui <- fluidPage(
  titlePanel("Perceptions of Stigma and Willingness to Discuss Mental Health"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("mental_health_consequence", "Select Perceived Mental Health Consequence:",
                  choices = names(consequence_labels),
                  selected = names(consequence_labels)[1]),
      checkboxInput("show_all", "Show All Data", value = TRUE)
    ),
    
    mainPanel(
      plotOutput("stigmaPlot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  output$stigmaPlot <- renderPlot({
    selected_consequence <- consequence_labels[input$mental_health_consequence]
    plot_data <- data %>%
      filter(if(input$show_all) TRUE else mental_health_consequence == selected_consequence)
    
    ggplot(plot_data, aes(x = supervisor, fill = mental_health_consequence)) +
      geom_bar(position = "dodge") +
      labs(
        title = "Effect of Perceived Mental Health Consequence on Willingness to Discuss Issues",
        x = "Willingness to Discuss with Supervisor",
        y = "Count",
        fill = "Perceived Consequence"
      ) +
      theme_minimal()
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

