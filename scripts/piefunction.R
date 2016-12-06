library(dplyr)

# create function
PieUnemployment <- function(df, country, geo.loc) {
  abridged.data <- filter(df, geo.loc == Classif2_Item_Label,
                          country == Country_Label) %>%
  group_by(Time) 
  
  female.data <- abridged.data %>%
    filter(Sex_Item_Label == "Female") %>%
    summarize(female.mean = mean(Obs_Value))
  
  male.data <- abridged.data %>%
    filter(Sex_Item_Label == "Male") %>%
    summarize(male.mean = mean(Obs_Value))
  
  total.data <- abridged.data %>%
    filter(Sex_Item_Label == "Total") %>%
    summarize(total.mean = mean(Obs_Value))
  
  joined.data <- left_join(female.data, male.data, by = "Time") %>%
    left_join(total.data, by = "Time")
  joined.data <- filter(joined.data, !is.na(total.mean)) %>%
    filter(!is.na(female.mean)) %>%
    filter(!is.na(male.mean))
  return(joined.data)
}