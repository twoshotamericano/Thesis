###############
# R source File created to extract information from Google API
# Created by Ed Anderson
# 08/04/2017
###############

#Geocode
library(httr)

#Open the existing data-set
data3<-read.table("Analysis/Data/MainData",sep=",")

#Convert into an array
data4<-cbind(head(data3,1)$TransactionNo,head(data3,1)$Lat,head(data3,10)$Long)

#Function to contact the Google API
geo<-function(input1,input2,input3,input4){
  #Input1 is the latitude Information
  #Input2 is the longitude Information
  #Input3 is the radius of the search
  #Input4 is the type of place we are interested in

  #Put the inputs into dummy variables
  #Create a list
  loc1<-paste(input1,",",input2,sep="")
  rad<- paste(input3)
  typ<- input4

  keyval<-"AIzaSyD-XC20diWGV_La1n-LeWn5ZPZU2PAgKrk"

  list(location=loc1,
                        radius=rad1,
                        #type=typ1,
                        #keyword=keyw,
                        key=keyval)

  #sample2<-GET("https://maps.googleapis.com/maps/api/place/nearbysearch/json",
   #            query=Queryparameters)

}






loc1<-"-33.8670522,151.1957362"
rad1<-"500"
typ1<-"restaurant"
#keyw<-"cruise"




sample3<-content(sample2)
sample3$results[[12]]$types[[1]]
