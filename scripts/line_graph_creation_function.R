library(plotly)
library(stringr)

BuildCountryChart <- function(data) {
  
  # Creates a line graph for a selected country over time in a selected region
  p <- plot_ly(data = data, x = ~Time, y = ~Obs_Value, type='scatter', mode = 'lines+markers') %>%
   
     # Labels the title of the plot and the X and Y axis
    layout(title = "Country Unemployment Over Time",
           xaxis = list(title = 'Year'),
           yaxis = list(title = 'Percent Unemployment'))
  return(p)
}



