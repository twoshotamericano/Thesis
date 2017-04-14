#################
# Useful Functions
# Created by: Ed Anderson
# Date: 09/04/2017
##################

# Radar Search With Google API
# Function contacts the Google API and returns local area information
# Example Query:
#
# RadarSearch(1,data2[,c("Lat","Long")],100,"AIzaSyC5dvHAt1QbcWtdIaDWHnLLUaAARJSSSPs","School")
#
# A key value needs to be obtained from here:
# Here is my key "AIzaSyC5dvHAt1QbcWtdIaDWHnLLUaAARJSSSPs"
# https://developers.google.com/maps/documentation/geocoding/get-api-key

## Load Packages

library(httr)

#Input1 is an integer value, it identifies the row in the data-frame
#Input2 is a data-frame, it contains the lat-long information of the properties
#Input3 is a numeric value. It is used for the radius of the search
#Input4 is the Google API key
#Input5 is the Place of Interest (eg. Restaurants)

RadarSearch<-function(Input1,Input2,Input3,Input4,Input5){

  #Declare some variables
  i<-c(0)
  LatLon<-c(0)
  Radius<-c(0)
  Type<-c(0)
  Key<-c(0)

  #Populate the variables
  i<-Input1
  LatLong<-paste(Input2[i,1],",",Input2[i,2],sep="")
  Radius<- paste(Input3)
  Type<- Input5
  Key<-Input4


  #Build an API query and store the results
  sample2<-GET("https://maps.googleapis.com/maps/api/place/nearbysearch/json",
               query=list(location=LatLong,
                          radius=Radius,
                          #type=typ,
                          types=Type,
                          #keyword=keyw,
                          key=Key))

  #Output the number of successful search results
  length(content(sample2)$results)

}


######################################

# Reverse Geocoding function with Google API
# This function takes lat,long location information and returns address information

# Input1 is an integer and is used to select a row of data
# Input2 a data-frame containing three columns: TransNo (pkey) latitude, longitude
# Input3 is the value of the google API key

# The keys which I used are given at the end of the function:

ReverseGeo<-function(Input1,Input2,Input3){


  #initialise some variables
  j<-c(0)
  k<-c(0)
  LatLng<-c(0)
  KeyVal<-c(0)
  Output<-c(0)
  Output2<-rep(NA,each=7)

  #Put the inputs into dummy variables
  j<-Input1
  LatLng<-paste(Input2[j,2],",",Input2[j,3],sep="")
  KeyVal<-Input3

  #Use HTTR to query google and store the results
  sample2<-GET("https://maps.googleapis.com/maps/api/geocode/json",
               query=list(latlng=LatLng,
                          key=KeyVal))

  #Parse the results using httr
  Output<-content(sample2)

  #Parse the response again
  #Ensures the information is placed in the correct order

  for (k in 1:(min(7,length(Output$results[[1]]$address_components))))

    {

      if (Output$results[[1]]$address_components[[k]]$types[[1]]=="street_number")
          {Output2[1]<-strsplit(
                          Output$results[[1]]$address_components[[k]]$long_name,
                          "-")[[1]][1]}

      if (Output$results[[1]]$address_components[[k]]$types[[1]]=="route")
          {Output2[2]<-Output$results[[1]]$address_components[[k]]$long_name}

      if (Output$results[[1]]$address_components[[k]]$types[[1]]=="locality")
          {Output2[3]<-Output$results[[1]]$address_components[[k]]$long_name}

      if (Output$results[[1]]$address_components[[k]]$types[[1]]=="administrative_area_level_2")
          {Output2[4]<-Output$results[[1]]$address_components[[k]]$long_name}

      if (Output$results[[1]]$address_components[[k]]$types[[1]]=="administrative_area_level_1")
          {Output2[5]<-Output$results[[1]]$address_components[[k]]$long_name}

      if (Output$results[[1]]$address_components[[k]]$types[[1]]=="country")
          {Output2[6]<-Output$results[[1]]$address_components[[k]]$long_name}

      if (Output$results[[1]]$address_components[[k]]$types[[1]]=="postal_code")
          {Output2[7]<-Output$results[[1]]$address_components[[k]]$long_name}
  }

  #Return the parsed address details
  Output2

}

# Keys

# "AIzaSyADJ1pDacwBp_gfNO91-iriGOpSVXEiZEc"
# "AIzaSyDM4RczKIBMu6jA5lJFlDyi5SnF2ptmvxw"
#"AIzaSyDyhJhgRaWD3Db7xfPguQRck9eURUbz3T0"
#"AIzaSyBx6CMYUuXGmqEocmwaxK9cQEIlD_4il8I"
# "AIzaSyDmEFZ0CkgjL0fNY7cvBZRE7A79Sx4_AD0"
# "AIzaSyBlcnMdtqCfSf5f5zl-rNn6JLcQxwItjgU"
#"AIzaSyAvsfxbx_SKT5t-vDnYJmYyxDG4_TammHs"
#"AIzaSyCMBxCXXaU2-W7u2L3KigfT7cuzEviIFyQ"
#"AIzaSyD1jLcZDwCZmHl4z4oNX1Noois0oiylBbA"
#"AIzaSyAlYIxtZhLPkF7P8Rv9Tl1yZehh4BgoZuA"


