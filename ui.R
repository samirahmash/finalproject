library(shiny)
source('./datafunctions.R')
source('./Scripts/buildScatter.R')

shinyUI(fluidPage(
  titlePanel("International Labor Organization - Visualized"),
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("checkGroup","Gender", 
                   choices = list("Female" = 'Female',
                                  "Male" = 'Male',
                                  "Total" = 'Total'),
                   selected = 'Total'),
      
      checkboxGroupInput("checkGroup2", "Area",
                    choices = list("Rural" = 'Rural',
                                   "Urban" = 'Urban', 
                                   "Total" = 'Total'),
                    selected = 'Total'),
    
      sliderInput("slider2", "Slider Range", 
                  min = min(short.data$Time), 
                  max = max(short.data$Time), 
                  value = c(1995,2000)
                  )
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
