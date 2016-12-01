library(shiny)
source('./datafunctions.R')

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
                    choices = list("Rural" = 'Rural',
                                   "Urban" = 'Urban', 
                                   "Total" = 'Total'),
                    selected = 'Total'),
    
      sliderInput("slider2", "Slider Range", 
                  min = min(short.data$Time), 
                  max = max(short.data$Time), 
                  value = c(1995,2000)
                  ),
      
      selectInput("select", "Select an Age Range",
                  choices = as.list(only.ages),
                  select = "Total")
    ),
    mainPanel(
      plotlyOutput("WorldMap")
    )
  )
)
)
