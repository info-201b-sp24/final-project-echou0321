#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application
shinyUI(fluidPage(
  
  # Application title
  titlePanel("TechMind: Insights on Mental Health in Tech"),
  
  # Introduction section
  mainPanel(
    h2("Introduction"),
    p("Our project investigates mental health in the tech workplace, analyzing the impact of remote work, access to mental health benefits, stigma, and wellness programs. We aim to uncover how these factors influence employee well-being and organizational dynamics, offering insights to inform strategies for promoting a supportive and inclusive work environment."),
    p("Keywords: Mental health, human resources, company productivity, worker well-being, tech industry"),
    p("Date: Spring 2024"),
    p("Authors: Yoonseo Nam - ynam04@uw.edu, Eric Chou - choueri2@uw.edu"),
    p("Abstract: Our project explores the critical issue of mental health within the tech workplace in the United States. The tech industry, known for its high-pressure environment, has seen a significant shift towards remote work, especially following the COVID-19 pandemic. This new dynamic presents both opportunities and challenges for employee mental health."),
    p("Data Source: "),
    p("The dataset used in this project was obtained from the Open Sourcing Mental Illness (OSMI), a non-profit organization dedicated to promoting mental wellness within the tech and open-source communities. The data was collected from a survey conducted in 2014, which investigated the frequency of mental health issues and attitudes towards mental well-being among tech workers."),
    p("Ethical Considerations:"),
    p("When working with sensitive data related to mental health, it's essential to consider ethical questions and limitations. Confidentiality is vital, as the data includes sensitive personal information that could harm individuals if improperly disclosed. Strict measures should be taken to anonymize and secure the data, ensuring individuals' identities remain protected. Additionally, care must be taken not to inadvertently reinforce stigmas surrounding mental health."),
    
    # Additional "flare" - you can add images, logos, etc. here
    img(src = "TechMind.png", width = 400),
    
    # Data source link
    p("Data Source: ",
      a("Open Sourcing Mental Illness (OSMI)", href = "https://osmihelp.org/")
    )
  )
))
