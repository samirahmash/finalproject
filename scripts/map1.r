
library(plotly)
library(dplyr)

# shows interactive map
WorldMap <- function(df) {
  return(plot_ly(df, type = 'choropleth', 
            locations = ~Country_Code,
            locationmode = "world",
            colors = "Purples",
            z = ~mean.observations,
            text = ~hover
            ) %>%
    colorbar(title = "Percentage of Workforce Unemployed") %>%
    layout(
      title = "Unemployment Rates Around the World",
      geo = list(scope = "world")
      )
  )
}
