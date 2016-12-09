# This files returns a scatter that takes in a data frame, year start and year end, as well as
# gender and age to filter as arguments. 

library(dplyr)
library(plotly)

UnemployedScatter <- function(df, year1, year2, gender, age) {
  # At the end will retrun mean observed values for the selected features and the
  # Urban and Rural statsitics associated 
  short.data <- select(df, Country_Label, Country_Code, Sex_Item_Label, 
                       Classif1_Item_Label, Classif2_Item_Label, Time, Obs_Value)
  short.data <- filter(short.data, 
                       Time >= year1,
                       Time >= year2,
                       Sex_Item_Label == gender, 
                       age == Classif1_Item_Label) %>%
    group_by(Country_Label)
  
  #Creates a second dataframe including urban mean data
  urban.data <- short.data %>%
    filter(Classif2_Item_Label == "Urban") %>%
    summarize(urban.mean = mean(Obs_Value))
  
  #Creates a second dataframe including rural mean data
  rural.data <- short.data %>%
    filter(Classif2_Item_Label == "Rural") %>%
    summarize(rural.mean = mean(Obs_Value))
  
  # Adds the mutated data frames together into a list which can then be visualized
  joined.data <- left_join(urban.data, rural.data, by = "Country_Label")
  joined.data <- joined.data %>% filter(!is.na(urban.mean)) %>%
    filter(!is.na(rural.mean)) %>% 
    mutate(color.diff = floor(urban.mean - rural.mean))
  
  return(joined.data)
}
