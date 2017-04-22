##########
# Created by: Ed Anderson
# Date: 22nd April 2017
# Purpose: Data enrichment using Zillow API
##########

# This code follows

# This is used to select which rows of data to enrich in Data20 (see below)
# The API is limited to 1000 queries per key per day

start<-1
end<-1000

# Loop through and query the API

#Use the Zillow API
for (i in start:end) {

  #Populate Local variables with the address data
  Address<- paste(data21$StreetNumber[i],data21$Route[i],data21$Locality[i],sep=",")
  CityStateZip<-paste0(data21$ZipCode[i])
  RentZestimatezws<-TRUE

  #API Call
  APIResult<-GetDeepSearchResults(address =Address, citystatezip = CityStateZip,
                                  rentzestimate = TRUE,zws_id = ZWSID)

  ZillowDataSet[i,1]<-APIResult$message$code

  # Parse the data with error handling

  # a 508 response code means that no results were found
  # a 0 reponse code with a NULL result set also means no data

  if (ZillowDataSet[i,1]!="508" & class(APIResult$response[["results"]])[[1]]!="NULL" )
    {if (!is.null(row.names(xmlToList(APIResult$response[["results"]]))))


    {

  # I extract 32 columns of data and store the results in a dataframe
  # I define a new function Zillowf to parse the result data

      for (j in 1:32) {
      resultdata <- xmlToList(APIResult$response[["results"]])

      ZillowDataSet[i,j+1]<-Zillowf(resultdata)[[j]]
                      }

  # I pause the loop to avoid over working the zillow api

      Sys.sleep(0.5)
    }
  }
}

# Output the Results to File

write.table(ZillowDataSet,file="Analysis/Data/ZillowDataSetX",sep=",")

#Clear the environment

rm(list=ls())
