# Loads package to use dplyr functions.
library(dplyr)

# Pares down data, then creates a function, taking in parameters for a country and urban/rural area to make
# more easily accesible information for the gender bar chart.
BarData <- function(df, country, geo.loc) {
  abridged.data <- filter(df, geo.loc == Classif2_Item_Label,
                          country == Country_Label) %>%
  group_by(Time) 
  
  # Pares down data to include an average unemployment percentage for women in each country.
  female.data <- abridged.data %>%
    filter(Sex_Item_Label == "Female") %>%
    summarize(female.mean = mean(Obs_Value))
  
  # Pares down data to include an average unemployment percentage for men in each country.
  male.data <- abridged.data %>%
    filter(Sex_Item_Label == "Male") %>%
    summarize(male.mean = mean(Obs_Value))
  
  # Pares down data to include an average unemployment percentage for men and women in each country.
  total.data <- abridged.data %>%
    filter(Sex_Item_Label == "Total") %>%
    summarize(total.mean = mean(Obs_Value))
  
  # Joins female, male, and total pared down percentages for urban and rural areas.
  joined.data <- left_join(female.data, male.data, by = "Time") %>%
    left_join(total.data, by = "Time")
  joined.data <- filter(joined.data, !is.na(total.mean)) %>%
    filter(!is.na(female.mean)) %>%
    filter(!is.na(male.mean))
  return(joined.data)
}