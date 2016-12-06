# this returns a scatterplot for all countries in which 
# we can compare the urban and rural unemployment with plotly

# load in packages
library(dplyr)

source('./scripts/datafunctions.R')

# data to test out our function
data <- read.csv("./data/ilodata.csv")
data <- filter(data, !is.na(Obs_Value))

# pare down columns in dataframe to just country, sex, age, urban status, year, and unemployment
short.data <- select(data, Country_Label, Country_Code, Sex_Item_Label, 
                     Classif1_Item_Label, Classif2_Item_Label, Time, Obs_Value)

# create a plotly scatterplot that plots obs value for urban vs rural


# first things first let's join some tables!

table1 <- FilterMapData("Urban", "Total", 1990, 2015, "Total")
