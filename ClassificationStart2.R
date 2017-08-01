library(RgoogleMaps)
library(sp)
library(RColorBrewer)

##################
#Create the Spatial Points Data Frame
#Read data file with geo data
#Add Predicted Values
##################

#######################
#Data Preparation
#######################

data6<-read.table(file="Analysis/Data/EnrichedData",header=TRUE,
                  sep=",",stringsAsFactors = TRUE)

#Get the Condition and Grade variables
origdata<-read.csv(file="Analysis/Data/HousePriceData.csv",header=TRUE,
                   sep=",",stringsAsFactors = TRUE)

origdata<-origdata[,c("TransactionNo","condition","grade")]

data6<-merge(data6,origdata,by.x="TransactionNo",by.y="TransactionNo")

data6$condition<-origdata$condition[data6$TransactionNo]

#Create a Spatial Points Data-frame
coordinates(data6)<-c("Long","Lat")

#Remove data-points assumed to be errors
errors<-which(coordinates(data6)[,1]> -121.7 |
                coordinates(data6)[,1]< -122.6)
data6<-data6[-errors,]

#Generate the Predictions from Fitted Model
data6$FlatFlag<-as.factor((data6$NumberOfFloors<2)*1)
data7<-slot(data6,"data")

#FIt a Linear Model
fit3<-lm(LogSalePrice ~
           condition+
           grade+
           SeattleFlag+
           RenovationYear+
           TotalArea+
           NumberOfBedrooms+
           NumberOfBathrooms+
           LivingSpace+
           NumberOfBedrooms+
           #NumberOfFloors+
           ConstructionYear+
           WaterfrontView+
           SeattleFlag+
           #Restaurants250m+
           Schools1000m+
           PoliceStation1000m+
           SupermarketGrocery750m+
           #Library750m+
           #LiquorStore250m+
           DoctorDentist500m+
           #DepartmentStoreShoppingMall750m+
           #BusTrainTransitStation100m+
           BarNightclubMovie500m+
           #RZestimateHighValueRange+
           #RZestimateAmount+
           NumberOfFloors+
           ConstructionYear+
           WaterfrontView+
           SeattleFlag+
           #Restaurants250m+
           Schools1000m+
           PoliceStation1000m+
           SupermarketGrocery750m+
           Library750m
         #LiquorStore250m+
         , data=data6)

data6$prediction<-predict(fit3)

#################################################
# Create the Map
#################################################

#Convert Map to Spatial Grid Object
#getmap
centre<-c(mean(bbox(data6)[2,])+0.02,mean(bbox(data6)[1,]))

MyMap <- GetMap(center=centre,
                zoom=10,destfile="TestMap",maptype="satellite", NEWMAP=TRUE)

#get bounding box
BB<-do.call("rbind",MyMap$BBOX)

#get difference in bounding box
dBB<-rev(diff(BB))

#get the number of cells in image
DIM12<-dim(MyMap$myTile)[1:2]

#cell size

cs<-dBB/DIM12

#Offset

cc<-c(BB[1,2]+cs[1]/2,BB[1,1]+cs[2]/2)

#Create the parameters of grid object

GT<-GridTopology(cc,cs,DIM12)

#Create Projection String

p4s<-CRS("+proj=longlat +datum=WGS84")

#Create the map

MyMap2<-SpatialGridDataFrame(GT,
                             proj4string = p4s,
                             data=data.frame(
                               r=c(t(MyMap$myTile[,,1])*255),
                               g=c(t(MyMap$myTile[,,2])*255),
                               b=c(t(MyMap$myTile[,,3])*255)))

###################################
#Plot the Map
##################################
par(mar=c(0,0,0,0)+0.1)
rw.colors<-colorRampPalette(c("white","red"))
image(MyMap2,red="r",green="g",blue="b")
plot(data6[c("LogSalePrice")],add=TRUE,pch=1,cex=0.1,col=rw.colors(500))
box()

