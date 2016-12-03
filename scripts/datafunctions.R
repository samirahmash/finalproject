# data from International Labor Organization on unemployment from 1990 to 2015, 
# broken down by country, gender, age group, urban/rural, year
# NOTE: Can't figure out how to make a general and shortened file path for some reason...
data <- read.csv("./data/ilodata.csv")


# load packages
library(dplyr)

# filter down our data, excluding rows where there is no observed value
data <- filter(data, !is.na(Obs_Value)) 

# pare down columns in dataframe to just country, sex, age, urban status, year, and unemployment
short.data <- select(data, Country_Label, Country_Code, Sex_Item_Label, 
                     Classif1_Item_Label, Classif2_Item_Label, Time, Obs_Value)
only.countries <- select(data, Country_Label) %>% unique()
only.ages <- select(data, Classif1_Item_Label) %>% unique()

# filter down results to both sexes, urban and rural, all ages, and latest year data was collected
FilterMapData <- function(urbvar, gender, start.year, end.year, age) {

  mapping.data <- short.data %>% subset(Classif2_Item_Label %in% urbvar) %>% 
    subset(Sex_Item_Label %in% gender) %>%
    group_by(Country_Code) %>% 
    filter(age == Clasif1_Item_Label) %>%
    filter(Time > start.year - 1) %>%
    filter(Time < end.year + 1) %>%
    summarise(occurrences = n(),
           mean.observations = mean(Obs_Value))
  mapping.data <- mapping.data[!duplicated(mapping.data), ]
  mapping.data$hover <- with(mapping.data, paste("Country:", Country_Code, '<br>', 
                             "Percentage Unemployed:", mean.observations, '<br>',
                             "Total Years and Genders:", occurrences, '<br',
                             "Age Range:", Classif1_Item_Label))
  return (mapping.data)
}

#mapping.data <- FilterMapData("National", "Total", "Total")
# for some reason there are duplicates, this deals with that

