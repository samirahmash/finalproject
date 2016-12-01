# Final Project Team 4

# data from International Labor Organization on unemployment from 1990 to 2015, 
# broken down by country, gender, age group, urban/rural, year
# NOTE: Can't figure out how to make a general and shortened file path for some reason...
library(dplyr)
library(rsconnect)



data <- read.csv("./data/ilodata.csv")

shinyServer(function(input, output) { 
  # Render a plotly object that returns your scatter on the UI's radio button and select indicator
  output$scatter <- renderPlotly({
    return(WorldMap(a,b,c))
  })
})