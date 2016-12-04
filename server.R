# Final Project Team 4
library(shiny)
library(dplyr)
# data from International Labor Organization on unemployment from 1990 to 2015, 
# broken down by country, gender, age group, urban/rural, year
# NOTE: Can't figure out how to make a general and shortened file path for some reason...
source('./scripts/map1.r')
source('./scripts/datafunctions.R')
source('./scripts/scatterunemployment.R')
source('./scripts/scatterdata.R')
source('./scripts/piefunction.R')
source('./scripts/piechartunemployment.R')
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
  output$ComboUnemployment <- renderPlotly({
    return(
      UrbanRuralScatter(
        UnemployedScatter(df,
          input$slider2[1],
          input$slider2[2],
          input$radio1,
          input$select
        )
      )
    )
  })
  output$Bar1 <- renderPlotly({
    return(
      UnemploymentHist(
        PieUnemployment(df,
                        input$select2,
                        input$radio3
                         
        )
      )
   )
  })
})