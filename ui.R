library(shiny)
source('./scripts/datafunctions.R')
source('./datafunctions.R')
source('./Scripts/buildScatter.R')

shinyUI(fluidPage(
  titlePanel("International Labor Organization - Visualized"),
  sidebarLayout(
    sidebarPanel(
      radioButtons("radio1","Gender", 
                   choices = list("Female" = 'Female',
                                  "Male" = 'Male',
                                  "Total" = 'Total'),
                   selected = 'Total'),
      
      radioButtons("radio2", "Area",
                    choices = list("Rural",
                                   "Urban", 
                                   "Total"),
                    selected = "Total"),
    
      sliderInput("slider2", "Slider Range", 
                  min = min(short.data$Time), 
                  max = max(short.data$Time), 
                  value = c(1995,2000)
                  ),
      
      selectInput("select", label = h3("Select an Age Range"),
                  choices = only.ages, selected = only.ages[1])
    ),
    titlePanel('Countries'),
    sidebarLayout(
      sidebarPanel(
        
        selectInput("select", label = "Country", choices = list(only.countries), selected = 'Afghanistan')
      ),
    mainPanel(
      tabsetPanel(
        tabPanel("Map", plotlyOutput("worldMap")),
        tabPanel("Country", plotlyOutput("BuildCountryChart"))
      )
    )
  )
)
)
)
