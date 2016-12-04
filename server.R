# Final Project Team 4
library(shiny)
library(dplyr)
# data from International Labor Organization on unemployment from 1990 to 2015, 
# broken down by country, gender, age group, urban/rural, year
# NOTE: Can't figure out how to make a general and shortened file path for some reason...
library(rsconnect)



data <- read.csv("./data/ilodata.csv")

source('./map1.r')
source('./datafunctions.R')
source('./scripts/buildScatter.r')

source('./scripts/map1.r')
source('./scripts/datafunctions.R')
df <- read.csv("./data/ilodata.csv", stringsAsFactors = FALSE)

shinyServer(function(input, output) { 
  # Render a plotly object that returns your scatter on the UI's radio button and select indicator
  output$GlobalMap <- renderPlotly({
      return(
        WorldMap(
          FilterMapData(df,
                      input$radio2, 
                      input$radio1,
                      input$slider2[1],
                      input$slider2[2],
                      input$select
                      )
        )
      )
      
  })
  output$BuildScatter <- renderPlot({
    return(BuildScatter(FilterScatterCountry(input$country), input$xcol, input$ycol))
  })
})