# Project Proposal

------------------

## Project Description

1. We will be working with data from the International Labor Organization. This data is about unemployment in urban versus rural areas around the world and also stratified across gender and age.

2. Our target audience is just about anybody who can read english. We are presenting very simple data that most people can understand.

3. Our audience will learn about global economic trends from this data. Some of their questions may include...
	* How is unemployment related to urban versus rural communities worldwide?
	* How has worldwide unemployment in urban versus rural communities changed over time?
	* Where is unemployment concentrated?

## Technical Description

1. Our format will be an HTML page
2. We are reading our data from a .csv file
3. Some countries in our data set have many more rows because of the detail of data collected, so we'll have to use group_by and summarize to ensure that rows are averaged.
4. We will be using the Plotly and KnitR libraries
5. Averaging out unemployment across the stratafied groups from our initial table
6. Wrangling the data will be a challenge as not every single country has the same amount of rows due to asymmetrical data collection

