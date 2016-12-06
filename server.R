# Final Project Team 4
library(shiny)
library(dplyr)
library(rsconnect)
# data from International Labor Organization on unemployment from 1990 to 2015, 
# broken down by country, gender, age group, urban/rural, year

source('./scripts/buildScatter.r')
source('./scripts/datafunctions.R')

df <- read.csv("./data/ilodata.csv", stringsAsFactors = FALSE)

# Creates a line graph of unemployment over time for each selected country in each selected region.
shinyServer(function(input, output) { 
 
  # Render a plotly object that returns your scatter on the UI's radio button and select indicator
  output$BuildScatter <- renderPlotly({
    return(BuildCountryChart(FilterScatterCountry(df, input$radioCountry, input$selectCountry)))
  })
})