# Final Project Team 4
library(shiny)
library(dplyr)
library(plotly)
require(plotly)
# data from International Labor Organization on unemployment from 1990 to 2015, 
# broken down by country, gender, age group, urban/rural, year
# NOTE: Can't figure out how to make a general and shortened file path for some reason...
source('./map1.r')
source('./datafunctions.R')
shinyServer(function(input, output) { 
  # Render a plotly object that returns your scatter on the UI's radio button and select indicator
  output$WorldMap <- renderPlotly({
    return(WorldMap(
      FilterMapData(input$radio1, 
                    input$radio2, 
                    input$slider2[1],
                    input$slider2[2])
      )
      )
  })
})