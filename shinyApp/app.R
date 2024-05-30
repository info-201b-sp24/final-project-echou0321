# Load necessary libraries
library(shiny)
library(ggplot2)
library(dplyr)

# Define UI
ui <- fluidPage(
  titlePanel("TechMind: Insights on Mental Health in Tech"),
  
  # Define tabs
  tabsetPanel(
    tabPanel("Introduction", 
             p("Our project investigates mental health in the tech workplace, analyzing the impact of remote work, access to mental health benefits, stigma, and wellness programs. We aim to uncover how these factors influence employee well-being and organizational dynamics, offering insights to inform strategies for promoting a supportive and inclusive work environment."),
             p("Keywords: Mental health, human resources, company productivity, worker well-being, tech industry"),
             p("Date: Spring 2024"),
             p("Authors: Yoonseo Nam - ynam04@uw.edu, Eric Chou - choueri2@uw.edu"),
             p("Abstract: Our project explores the critical issue of mental health within the tech workplace in the United States. The tech industry, known for its high-pressure environment, has seen a significant shift towards remote work, especially following the COVID-19 pandemic. This new dynamic presents both opportunities and challenges for employee mental health."),
             p("Data Source: "),
             p("The dataset used in this project was obtained from the Open Sourcing Mental Illness (OSMI), a non-profit organization dedicated to promoting mental wellness within the tech and open-source communities. The data was collected from a survey conducted in 2014, which investigated the frequency of mental health issues and attitudes towards mental well-being among tech workers."),
             p("Ethical Considerations:"),
             p("When working with sensitive data related to mental health, it's essential to consider ethical questions and limitations. Confidentiality is vital, as the data includes sensitive personal information that could harm individuals if improperly disclosed. Strict measures should be taken to anonymize and secure the data, ensuring individuals' identities remain protected. Additionally, care must be taken not to inadvertently reinforce stigmas surrounding mental health."),
             
             # Data source link
             p("Data Source: ",
               a("Kaggle - Mental Health in Tech Survey", href = "https://www.kaggle.com/datasets/osmi/mental-health-in-tech-survey/data")
             ),
             p("Open Sourcing Mental Illness (OSMI):",
               a("OSMI Website", href = "https://osmihelp.org/")
             ),
             
             # Insert image
             img(src='TechMind.png', height="50%", width="50%", align = "center")
    ),
    tabPanel("Work Interference",
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
  )
)

# Define server logic
server <- function(input, output, session) {
  output$interferencePlot <- renderPlot({
    plot_data <- cleaned_survey %>%
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
