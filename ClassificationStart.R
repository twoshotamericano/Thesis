library(RgoogleMaps)

lat = c(40.702147,40.718217,40.711614);
lon = c(-74.012318,-74.015794,-73.998284);
center = c(mean(lat), mean(lon));
zoom <- min(MaxZoom(range(lat), range(lon)));


#this overhead is taken care of implicitly by GetMap.bbox();
markers = paste0("&markers=color:blue|label:S|40.702147,-74.015794&markers=color:",


                 "green|label:G|40.711614,-74.012318&markers=color:red|color:red|",


                 "label:C|40.718217,-73.998284")


MyMap <- GetMap(center=center, zoom=zoom,markers=markers);

#Convert Map to Spatial Grid Object
#getmap
centre<-c(mean(bbox(data6)[2,])+0.02,mean(bbox(data6)[1,]))
MyMap <- GetMap(center=centre,
                zoom=10,destfile="TestMap",maptype="satellite")

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


par(mar=c(0,0,0,0)+0.1)
rw.colors<-colorRampPalette(c("white","red"))
image(MyMap2,red="r",green="g",blue="b")
plot(data6[c("LogSalePrice")],add=TRUE,pch=1,cex=0.1,col=rw.colors(500))
box()

plot(MyMap2[c("r")],legend=FALSE)
plot(MyMap2[c("g")],add=TRUE)
plot(MyMap2[c("b")],add=TRUE)
