# Loads packages to use plotly and dplyr functions.
library(plotly)
library(dplyr)

# Renders interactive world map to control with widgets.
WorldMap <- function(df) {
   if (nrow(df) == 0) {
    df[1, ] <- c("AFG", 0, 0)
    df[2, ] <- c("USA", 0, 0)
   }  
  
  # Markers with the country name, percentage unemployed, years, and gender.
  df$hover <- with(df, paste("Country:", Country_Code, '<br>', 
                             "Percentage Unemployed:", mean.observations, '<br>',
                             "Total Years and Genders:", occurrences)
                             )
  return(plot_ly(df, type = "choropleth", 
            locations = ~Country_Code,
            locationmode = "world",
            colors = "Purples",
            z = ~mean.observations ,
            text = ~hover
            ) %>%
    colorbar(title = "Percentage of Workforce Unemployed"
            ) %>%
    layout(
      title = "Unemployment Rates Around the World",
      geo = list(scope = "world")
      )
  )
}
