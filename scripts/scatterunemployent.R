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
                          color = 'Gold',
                          line = list(width = 2,
                                      color = 'Purple'))) %>% 
      layout(title = 'Comparing Urban and Rural Unemployment',
             yaxis = list(title = "Rural Unemployment",
                          zeroline = FALSE),
             xaxis = list(title = "Urban Unemployement",
<<<<<<< HEAD
                          zeroline = FALSE))
  )
  
}
=======
                          zeroline = FALSE)) %>% 
    add_trace(x = df$urban.mean, y = df$urban.mean, mode = 'line')
  )
}

>>>>>>> 9ab8315ed151f52bf2e247bcc2e2b6bdbad1a67d
