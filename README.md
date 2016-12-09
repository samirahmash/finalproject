## Project Description

1. We worked with data from the International Labor Organization. This data is about unemployment in urban versus rural areas around the world and also stratified across gender and age.

2. Our target audience is just about anybody who can read english. We are presenting very simple data that most people can understand.

3. Our audience will learn about global economic trends from this data. Some of their questions may include...
	* How is unemployment related to urban versus rural communities worldwide?
	* How has worldwide unemployment in urban versus rural communities changed over time?
	* Where is unemployment concentrated?

## Technical Description

1. Our format will be in shiny
2. We are reading our data from a .csv file
3. Some countries in our data set have many more rows because of the detail of data collected, so we'll have to use group_by and summarize to ensure that rows are averaged.
4. We will be using the Plotly and KnitR libraries
5. Averaging out unemployment across the stratafied groups from our initial table
6. Wrangling the data will be a challenge as not every single country has the same amount of rows due to asymmetrical data collection

## Aproximatly houw many hours did you spend on this assignment?
   We spent about 40 hours

## On a scale of 1 - 10 how challenging was this assignment?
   This project was about a 6.5 in difficulty. Our group workedd well together and was able to efficently tackle problems together making the project much easier.

## Information to know about using this web application
   While our data source is repuatable, the way each country obtained the data is questionable. Either becuacse there are years of missing data or large inconsistancies. 
   We chose to include these inconsistancies in our web app becuase it can be used to encourage these countries to be more transparent with there data and unemployment rates. 
   These inconsistancies can be seen in the choropleth map when using the slider. While observing the earlier years of data there is an error that shows up saying
   "This function only works with one colorbar" becuase there is no data from those years to report. In the international labor scatterplot there were certain countries that had 
   data for National but not Rural or Urban and so those graphs remain blank when clicked on. 