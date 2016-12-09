# Loads packages to use shiny, rsconnect, and dplyr functions.
library(shiny)
library(dplyr)
library(rsconnect)

# Sources scripts files to use their functions that manipulate the unemployment data.
source('./scripts/line_graph_creation_function.R')
source('./scripts/line_graph_data_filter.R')
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
 
  # Creates a choropleth map that looks at the unemployment rates in each country.
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

  # Creats a bar chart of unemployment over time for each selected country 
  # and region and shows the gender distribution.
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
  
  # Creates a line graph of unemployment over time for each selected country in each selected region.
  output$BuildScatter <- renderPlotly({
    return(BuildCountryChart(FilterScatterCountry(df, input$radioCountry, input$selectCountry)))
  })
})


