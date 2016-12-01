# creates heat map of unemployment data around the world

# load libraries for use of functions
library(plotly)
library(dplyr)

# source data from data folder
ilo.data <- read.csv("~/Documents/GitHub/finalproject/data/ilodata.csv")

# source script from Nathan's to retrieve refined data table
source('~/Documents/GitHub/finalproject/datafunctions.R')

# create a more concise data table to use info for map


# shows interactive map
WorldMap <- function(urbvar, gender, age) {
  mapping.data <- FilterMapData(urbvar, gender, age)
  mapping.data$hover <- with(mapping.data, paste("Country:", Country_Label, '<br>', 
                                                 "Year:", Time, '<br>',
                                                 "Percentage Unemployed:", Obs_Value))
  #single.country.row <- filter(mapping.data, Country_Label == country.name)
  newly.created.map <- mapping.data %>% 
    plot_ly(type = 'choropleth', 
            locations = ~Country_Code,
            locationmode = "world",
            colors = "Purples",
            z = ~Obs_Value) %>%
    colorbar(title = "Percentage of Workforce Unemployed") %>%
    layout(
      title = "Unemployment Rates Around the World",
      geo = list(scope = "world")
      )
    
  return(newly.created.map)
}
