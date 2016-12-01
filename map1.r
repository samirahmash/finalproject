# creates heat map of unemployment data around the world

# load libraries for use of functions
library(plotly)
library(dplyr)

# source data from data folder

# source script from Nathan's to retrieve refined data table

# create a more concise data table to use info for map


# shows interactive map
WorldMap <- function(df) {
  df$hover <- with(df, paste("Country:", df$Country_Label, '<br>', 
                                                 "Year:", df$Time, '<br>',
                                                 "Percentage Unemployed:", df$Obs_Value))
  newly.created.map <- df %>% 
    plot_ly(type = 'choropleth', 
            locations = ~Country_Code,
            locationmode = "world",
            colors = "Purples",
            z = ~Obs_Value,
            text = ~hover) %>%
    colorbar(title = "Percentage of Workforce Unemployed") %>%
    layout(
      title = "Unemployment Rates Around the World",
      geo = list(scope = "world")
      )
    
  return(newly.created.map)
}
