library(plotly)
library(stringr)

BuildCountryChart <- function(data) {
  #xaxis <- gsub(".", " ", scatter.x, fixed = TRUE) 
  #yaxis <- gsub(".", " ", scatter.y, fixed = TRUE)
  #Graphs the plotly scatter point graph with variables as the X and Y axis, allowing you to change what you compare.
  p <- plot_ly(data = data, x = ~Time, y = ~Obs_Value, type='scatter', mode = 'lines+markers') %>%
    layout(title = "Unemployment",
           
           #Sets the axis labels and range ( range = c(0, 8) )
           xaxis = list(title = 'xaxis'),
           yaxis = list(title = 'yaxis'))
  return(p)
}



