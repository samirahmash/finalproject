library(shiny)
library(plotly)

source('./scripts/')

shinyUI(fluidPage(
  titlePanel("International Labor Organization - Visualized"),
  sidebarLayout(
    sidebarPanel(
      radioButtons("radio", label = h3("Gender"), 
                   choices = list("Females" = 'Female', "Males" = 'Male',
                                  "Total" = 'Total'),
                   selected = "total"),
      radioButtions("radio", label = h3("Area"),
                    choices = list("Rural" = 'Rural', "Urban" = 'Urban', "Total" = 'National'),
                    ),
      
      #  Adds the choice of color selection to the graph for aesthetic effect
      selectInput("select", label = h3("Select a Country"), 
                  choices = list(), 
                  selected = 'red'))
    ),
    mainPanel(
      plotlyOutput("WorldMap")
    )
  )
)
)