library(shiny)

# Define UI for application that plots random distributions
shinyUI(pageWithSidebar(
  # Application title
  headerPanel("Elicit Expert Based Forecasts of UK Net Migration"),
  # Sidebar with a slider input for number of observations
  sidebarPanel(
    radioButtons("cp", h5("Number of Future Change Points:"),
                       c("0" = 0, "1" = 1, "2" = 2,  "3" = 3), selected=0),
#     numericInput("cp", "Number of Future Change Points:", 0, min=0, max=3),
#     sliderInput("cp",
#                 "Number of Future Change Points:",
#                 min = 0,
#                 max = 3,
#                 value = 0, 
#                 step = 1),
    uiOutput("year1"),
    uiOutput("mean1"),
    uiOutput("sd1"),
    uiOutput("skew1"),
    uiOutput("year2"),
    uiOutput("mean2"),
    uiOutput("sd2"),
    uiOutput("skew2"),
    uiOutput("year3"),
    uiOutput("mean3"),
    uiOutput("sd3"),
    uiOutput("skew3"),
    h5("End Values:"),
    sliderInput("mean0",
                paste0("2030: Central Prediction"),
                min = -1000,
                max = 1000,
                value = 163.9,
                step= 1),
    sliderInput("sd0",
                paste0("2030: Uncertinty"),
                min = 0.001,
                max = 1000,
                value = 100,
                step= 1),
    sliderInput("skew0",
                paste0("2030: Skewness"),
                min = -0.99,
                max = 0.99,
                value = 0,
                step=0.01),
    br(),
    helpText("Download Data:"),
    downloadButton('downloaddf', 'Data')
  ),
  # Show a plot of the generated distribution
  mainPanel(
    tabsetPanel(
      tabPanel("Plot", 
               checkboxInput('past', 'Show IPS Back Series', FALSE), 
               checkboxInput('ipsci', 'Show IPS Back Series 95% Confidence Intervals', FALSE), 
               plotOutput("plot")),
      # tabPanel("output", verbatimTextOutput("value")),
      tabPanel("Data", 
               dataTableOutput("df"))
    )
  )
))

#     checkboxInput("showfan", "Interpolate Fan", FALSE),
#     helpText("Tweak the width of the fan in the base year:"),
#     sliderInput("uncert10",
#                 "Uncertainty in First Period:",
#                 min = 0,
#                 max = 0.25,
#                 value = 0.1,
#                 step= 0.001)