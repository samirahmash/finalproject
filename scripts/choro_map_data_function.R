# data from International Labor Organization on unemployment from 1990 to 2015, 
# broken down by country, gender, age group, urban/rural, year
# NOTE: Can't figure out how to make a general and shortened file path for some reason...
data <- read.csv("./data/ilodata.csv")


# load packages
library(dplyr)

FilterMapData <- function(df, urbvar, gender, start.year, end.year, age) {
  data <- filter(df, !is.na(Obs_Value)) 
  short.data <- select(df, Country_Label, Country_Code, Sex_Item_Label, 
                       Classif1_Item_Label, Classif2_Item_Label, Time, Obs_Value)
  mapping.data <- short.data %>% 
    filter(Classif2_Item_Label == urbvar, 
           Sex_Item_Label == gender, 
           age == Classif1_Item_Label,
           Time >= start.year,
           Time <= end.year) %>% 
    group_by(Country_Code) %>%
    summarise(occurrences = n(),
           mean.observations = mean(Obs_Value))
  mapping.data <- mapping.data[!duplicated(mapping.data), ]
  return (mapping.data)
  
}
#mapping.data <- FilterMapData("National", "Total", "Total")
# for some reason there are duplicates, this deals with that

