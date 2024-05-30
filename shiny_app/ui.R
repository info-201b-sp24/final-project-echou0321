library(shiny)

ui <- fluidPage(
  titlePanel("TechMind: Insights on Mental Health in Tech"),
  
  sidebarLayout(
    sidebarPanel(
      # Sidebar content can go here
    ),
    
    mainPanel(
      h2("Project Overview"),
      p("Our project investigates mental health in the tech workplace, analyzing the impact of remote work, access to mental health benefits, stigma, and wellness programs."),
      h3("Major Research Questions"),
      tags$ul(
        tags$li("Does working remotely correlate with lower levels of reported mental health interference at work?"),
        tags$li("What proportion of tech employees have access to employer-provided mental health benefits, and how does this correlate with seeking treatment?"),
        tags$li("How do perceptions of stigma associated with mental health in the workplace affect employees’ willingness to discuss mental health issues with supervisors or coworkers?"),
        tags$li("Does the existence of a wellness program correlate with better employee perceptions of employer support for mental health issues?")
      ),
      h3("Data Source"),
      p("The dataset used in this project is sourced from Open Sourcing Mental Illness (OSMI). You can find the data on Kaggle:"),
      a(href = "https://www.kaggle.com/osmi/mental-health-in-tech-survey", "Mental Health in Tech Survey"),
      h3("Ethical Considerations"),
      p("When working with this data, we must consider the confidentiality of respondents' personal information. It's crucial to anonymize the data to protect individuals' identities. Additionally, the data may not fully represent the diversity of the tech industry, and we must be cautious about overgeneralizing findings."),
      # Including an image for visual appeal
      img(src = "https://example.com/mental_health_image.jpg", height = "300px")
    )
  )
)