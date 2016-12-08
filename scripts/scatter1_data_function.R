# Loads packages for function use to manipulate data.
library(dplyr)
library(plotly)

# Pares down data for unemployment percentage scatterplot.
UnemployedScatter <- function(df, year1, year2, gender, age) {
  short.data <- select(df, Country_Label, Country_Code, Sex_Item_Label, 
                       Classif1_Item_Label, Classif2_Item_Label, Time, Obs_Value)
  short.data <- filter(short.data, 
                       Time >= year1,
                       Time >= year2,
                       Sex_Item_Label == gender, 
                       age == Classif1_Item_Label) %>%
    group_by(Country_Label)
  urban.data <- short.data %>%
    filter(Classif2_Item_Label == "Urban") %>%
           summarize(urban.mean = mean(Obs_Value))
  rural.data <- short.data %>%
    filter(Classif2_Item_Label == "Rural") %>%
    summarize(rural.mean = mean(Obs_Value))
  
  # Joins rural and urban pared down datasets to plot together.
  joined.data <- left_join(urban.data, rural.data, by = "Country_Label")
  joined.data <- joined.data %>% filter(!is.na(urban.mean)) %>%
    filter(!is.na(rural.mean))
  
  return(joined.data)
}
