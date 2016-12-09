# Returns a plotly visualize that takes in a filtered dataframe and attaches a hover column for display later
# The visualization is a scatter that displays a deviance from countries that have equal urban and rural unemployment

library(plotly)
library(dplyr)


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
                    # Selects a color that deviates from black depending the difference between urban and rural unemployment.
                    color = paste0('rgba(',abs(df$color.diff * 50),', 0, 0, 1)'),
                    #color = ~color.diff,
                    line = list(width = 2,
                                color = "Black"))) %>% 
      layout(title = "Comparing Urban and Rural Unemployment",
             yaxis = list(title = "Rural Unemployment",
                          zeroline = FALSE),
             xaxis = list(title = "Urban Unemployment",
                          zeroline = FALSE))
    )
}


