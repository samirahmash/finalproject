# creates heat map of unemployment data around the world

# load libraries for use of functions
library(plotly)
library(dplyr)

# source data from data folder
ilo.data <- read.csv("~/Documents/GitHub/finalproject/data/ilodata.csv")

# source script from Nathan's to retrieve refined data table
source('~/Documents/GitHub/finalproject/datafunctions.R')

# create a more concise data table to use info for map
mapping.data$hover <- with(mapping.data, paste("Country:", Country_Label, '<br>', 
                                             "Year:", Time, '<br>',
                                             "Percentage Unemployed:", Obs_Value))

# shows interactive map
WorldMap <- function(country.name) {
  single.country.row <- filter(mapping.data, Country_Label == country.name)
  newly.created.map <- plot_ly(single.country.row, locationmode = "world", type = "choropleth") %>%
    add_trace(
      z = ~Obs_Value,
      text = ~single.country.row$hover,
      locations = ~Country_Label,
      color = ~Obs_Value, 
      colors = 'Reds'
      ) %>% 
    layout(
      title = 'Unemployment Rates Around the World',
           geo = list(scope = 'world')
      )
    
  return(newly.created.map)
}