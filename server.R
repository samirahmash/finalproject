# Final Project Team 4
# This is our shiny app, it works in tandem with our ui.r file to take in user input and
# output visual displays such as maps and graphs

# load in libraries
library(shiny)
library(dplyr)
library(rsconnect)
library(knitr)

# load in scripts
source('./scripts/buildScatter.r')
source('./scripts/line_graph_data_filter.R')
source('./scripts/choro_map_creation_function.R')
source('./scripts/choro_map_data_function.R')
source('./scripts/scatter1_creation_function.R')
source('./scripts/scatter1_data_function.R')
source('./scripts/bar_creation_function.R')
source('./scripts/bar_data_function.R')

# data from International Labor Organization on unemployment from 1990 to 2015, 
# broken down by country, gender, age group, urban/rural, year
df <- read.csv("./data/ilodata.csv", stringsAsFactors = FALSE)

# our shiny app
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
  
  # Plots a scatter that compares urban and rural unemployment rates
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
  # and region and shows the gender distribution
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
  
  # renders a knit .rmd file
  output$markdown <- renderUI({
    HTML(markdown::markdownToHTML(knit('Summary.Rmd', quiet = TRUE)))
  })
})


