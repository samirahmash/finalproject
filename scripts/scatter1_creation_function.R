# Loads plotly and dplyr packages to use their functions to manipulate data.
library(plotly)
library(dplyr)

# Creates function for with hovering markers for points on a scatter plot, representing urban and rural
# unemployment in different countries.
UrbanRuralScatter <- function(df) {
  df$hover = with(df, paste("Country:", Country_Label, '<br>', 
                            "Percentage of Urban Unemployment:", urban.mean, '<br>',
                            "Percentage of Rural Unemployment:", rural.mean, '<br>',
                            "Combined Unemployment:", urban.mean + rural.mean)
  )
  return(
    plot_ly(df, 
      x = ~urban.mean,
      y = ~rural.mean,
      text = ~hover,
      type = "scatter",
      mode = "markers",
      marker = list(size = 10,
                    color = 'Red',
                    line = list(width = 2,
                                color = "Black"))) %>% 
      layout(title = "Comparing Urban and Rural Unemployment",
             yaxis = list(title = "Rural Unemployment",
                          zeroline = FALSE),

             xaxis = list(title = "Urban Unemployement",
                          zeroline = FALSE)) %>% 
    add_trace(df, y = df$rural.mean, x = df$rural.mean, mode = 'lines')
    )
}


