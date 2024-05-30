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
  titlePanel("TechMind: Insights on Mental Health in Tech"),
  
  # Define tabs
  tabsetPanel(
    tabPanel("Introduction", 
             fluidRow(
               column(
                 width = 10,
                 offset = 1,
                 style = "margin-left: 10px;", 
                 h2("Introduction"),
                 # Introduction content
                 p("Our project investigates mental health in the tech workplace, analyzing the impact of remote work, access to mental health benefits, stigma, and wellness programs. We aim to uncover how these factors influence employee well-being and organizational dynamics, offering insights to inform strategies for promoting a supportive and inclusive work environment."),
                 p(tags$strong("Keywords:"), " Mental health, human resources, company productivity, worker well-being, tech industry"),
                 p(tags$strong("Date:"), " Spring 2024"),
                 p(tags$strong("Authors:"), " Yoonseo Nam - ynam04@uw.edu, Eric Chou - choueri2@uw.edu"),
                 p(tags$strong("Abstract:"), "Our project explores the critical issue of mental health within the tech workplace in the United States. The tech industry, known for its high-pressure environment, has seen a significant shift towards remote work, especially following the COVID-19 pandemic. This new dynamic presents both opportunities and challenges for employee mental health."),
                 p(tags$strong("Questions:")),
                 tags$ul(
                   tags$li("What is the effect of remote work on mental health interferences?"),
                   tags$li("How does perceptions of the stigma on mental health affect workers’ willingness to discuss problems with supervisors?"),
                   tags$li("Does the existence of a wellness program correlate with better employee perceptions of employer support for mental health issues?")
                 ),
                 p("The dataset used in this project was obtained from the Open Sourcing Mental Illness (OSMI), a non-profit organization dedicated to promoting mental wellness within the tech and open-source communities. The data was collected from a survey conducted in 2014, which investigated the frequency of mental health issues and attitudes towards mental well-being among tech workers."),
                 p(tags$strong("Ethical Considerations:")),
                 p("When working with sensitive data related to mental health, it's essential to consider ethical questions and limitations. Confidentiality is vital, as the data includes sensitive personal information that could harm individuals if improperly disclosed. Strict measures should be taken to anonymize and secure the data, ensuring individuals' identities remain protected. Additionally, care must be taken not to inadvertently reinforce stigmas surrounding mental health."),
                 p(tags$strong("Data Source: "), a("Kaggle - Mental Health in Tech Survey", href = "https://www.kaggle.com/datasets/osmi/mental-health-in-tech-survey/data")),
                 p(tags$strong("Open Sourcing Mental Illness (OSMI):"), a("OSMI Website", href = "https://osmihelp.org/")),
                 img(src='TechMind.png', height="50%", width="50%", align = "center")
               )
             )
    ),
    tabPanel("Remote Work & Mental Health", 
             sidebarLayout(
               sidebarPanel(
                 selectInput("work_interfere", "Select Mental Health Interference Level:",
                             choices = c("Never", "Rarely", "Sometimes", "Often"),
                             selected = "Sometimes"),
                 checkboxInput("show_all_interference", "Show All Interference Levels", value = TRUE),
                 selectInput("remote_work", "Select Remote Work Option:",
                             choices = unique(data$remote_work),
                             selected = unique(data$remote_work)[1]),
                 checkboxInput("show_all_remote", "Show All Remote Work Options", value = TRUE)
               ),
               mainPanel(
                 plotOutput("remoteInterferencePlot")
               )
             )
    ),
    tabPanel("Stigma & Discussion", 
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
    ),
    tabPanel("Wellness Programs & Employee Perceptions", 
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
    ),
    tabPanel("Takeaways",
             fluidRow(
               column(
                 width = 10,
                 offset = 1,
                 class = "tab-content", 
                 titlePanel("Summary Takeaways"),
                 h4("Major Takeaways:"),
                 p("1. Remote work options correlate with less frequent mental health interferences at work, highlighting the importance of flexible work arrangements for employee well-being."),
                 p("2. Perceptions of stigma around mental health negatively impact workers' willingness to discuss these issues with supervisors, indicating the need for destigmatization efforts within organizations."),
                 p("3. The existence of wellness programs does not guarantee better employee perceptions of employer support for mental health issues, suggesting a need for comprehensive support beyond program implementation."),
                 p("In summary, addressing mental health in the tech workplace requires not only the implementation of supportive policies like remote work and wellness programs but also efforts to combat stigma and foster open communication."),
                 h4("Discussion of Insights:"),
                 p("The most important insight gained from this analysis is the significant impact of organizational culture and policies on employee mental health. While remote work and wellness programs offer potential benefits, they must be accompanied by a supportive company culture and destigmatization efforts to truly improve employee well-being."),
                 h4("Broader Implications:"),
                 p("These findings have broader implications for the tech industry and beyond. Companies need to prioritize mental health support and create inclusive environments to attract and retain top talent. Additionally, addressing mental health issues can lead to increased productivity, innovation, and overall employee satisfaction, benefiting both individuals and organizations in the long run."),
                 img(src='Chart.png', height="50%", width="50%", align = "center")
               )
             )
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

           