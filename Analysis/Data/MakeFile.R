################
# R source file created to complete the data gathering process
# Created by Ed Anderson
# 19/03/2017
################


################
# Extract information from kaggle
# Input File is kc_house_data.csv
# Output File is data2
################

source("Analysis/Data/Gather1.R")

################
# Relabel are re-order the columns
# Input Files is data2
# Output File is MainData
################

source("Analysis/Data/Gather2.R")

################
# Enrich the data-set with GoogleData
# Input File is MainData
# Output file is API Data
################

##source("Analysis/Data/Gather3.R")

################
# Enrich the data-set with ZillowData
# Input File are Address Data and Main Data
# Output File is ZillowDataX
################

source("Analysis/Data/ZillowAPICalls.R")
source("Analysis/Data/ZillowAPICalls2.R")

################
# Impute values for the gaps in the Zillow Data
# Input file is ZillowDataX
# Output file is ZillowDataX
################

source("Analysis/Data/ZillowAPICalls3.R")


