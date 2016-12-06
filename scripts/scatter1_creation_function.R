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
                    color = 'Red',
                    line = list(width = 2,
                                color = "Black"))) %>% 
      layout(title = "Comparing Urban and Rural Unemployment",
             yaxis = list(title = "Rural Unemployment",
                          zeroline = FALSE),
             xaxis = list(title = "Urban Unemployement",
                          zeroline = FALSE))
    )
  
}


