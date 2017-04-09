#################
# Useful Functions
# Created by: Ed Anderson
# Date: 09/04/2017
##################

# Radar Search With Google API
# Function to contact the Google API
# Change Type input parameter to types if more than one place of interest is searched

library(httr)

geo<-function(ind,input){
  #Input1 is the latitude Information
  #Input2 is the longitude Information
  #Input3 is the radius of the search
  #Input4 is the type of place we are interested in

  #Put the inputs into dummy variables
  loc1<-paste(data4[ind,1],",",data4[ind,2],sep="")
  rad<- paste(data4[ind,3])
  typ<- data4[ind,4]
  keyval<-"AIzaSyC5dvHAt1QbcWtdIaDWHnLLUaAARJSSSPs"

  #QueryParameters
  sample2<-GET("https://maps.googleapis.com/maps/api/place/nearbysearch/json",
               query=list(location=loc1,
                          radius=rad,
                          #type=typ,
                          types=typ,
                          #keyword=keyw,
                          key=keyval))

  #Output the number of results
  length(content(sample2)$results)

                      }
