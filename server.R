# Loads packages to use shiny and dplyr functions.
library(shiny)
library(dplyr)

# Sources scripts files to use their functions that manipulate the unemployment data.
source('./scripts/choro_map_creation_function.R')
source('./scripts/choro_map_data_function.R')
source('./scripts/scatter1_creation_function.R')
source('./scripts/scatter1_data_function.R')
source('./scripts/bar_creation_function.R')
source('./scripts/bar_data_function.R')

# Accesses data as a dataframe from the International Labor Organization on unemployment from 1990 to 2015, 
# broken down by country, gender, age group, urban/rural, and year.
df <- read.csv("./data/ilodata.csv", stringsAsFactors = FALSE)

# The Shiny server allows interactivity from user input, via widgets, to output corresponding data to the 
# respective output.
shinyServer(function(input, output) { 
  
  # Render a plotly object that returns your scatter on the UI's radio button and select indicator.
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
  
  # Renders a scatter plot, based on rural and urban unemployment percentages, worldwide. Returns scatter
  # on the UI's radio button and select indicator.
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
  
  # Renders a bar graph of unemployment data for a chosen country by gender, using input from UI Shiny selectors.
  output$Bar1 <- renderPlotly({
    return(
      UnemploymentBar(
        BarData(df,
                input$select2,
                input$radio3
        )
      )
    )
  })
})