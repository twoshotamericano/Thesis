###############
# R source File created to extract information from Google API
# Created by Ed Anderson
# 08/04/2017
###############

#Open the existing data-set
data3<-read.table("Analysis/Data/MainData",sep=",")

#Load the functions
source("Analysis/UsefulFunctions.R")

#Convert info into format for inputting into search
data4<-data.frame(Lat=data3$Lat,
                  Long=data3$Long,
                  Dist=500,
                  Type=rep("movie_theater|bar|night_club",21613))


#Create the data set to hold the output
start<-1
end<-2

data15<-rep(21,end-start+1)

#Run the function on each record

for (i in start:end) {
  data15[i]<-geo(i,data4)

}


# Write the data to a datatable
#APIData$SupermarketGrocery750m<-data8
#APIData$Library750m<-data9
#APIData$LiquorStore250m<-data10
#APIData$DoctorDentist500m<-data11
#APIData$DepartmentStoreShoppingMall750m<-data12
#APIData$BusTrainTransitStation100m<-data13
#APIData$BarNightclubMovie500m<-data14

#APIData<-data.frame(Restaurants250m=data5,
#                    Schools1000m=data6,
#                    PoliceStation1000m=data7,
#                    SupermarketGrocery750m=data8)

#write.table(APIData,file="Analysis/Data/APIData",sep=",")

#Data 5 was restaurants within 250m
#Data 6 was schools withing 1000m
#Data 7 was police station within 1000m
#Data 8 was supermarket or grocery store within 750m
#Data 9 was a library within 750m
#data10 wa a liquor store within 250m
#data 11 is a doctor or dentist within 500m
#data 12 is a department store or shopping mall within 750m
#data 13 is a bus station, train station, transit station within 100m
#data 14 is a bar or nightclub or movie theatre within 500m
#data5<-c(0)
