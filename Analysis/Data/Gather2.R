################
# R source file created to rename the columns of the raw data
# Created by Ed Anderson
# 19/03/2017
################

#Create a Data-Frame with the final data
data2<-read.table("data2",sep=",")
MainData<-data2
write.table(MainData,file="MainData",sep=",")

#Remove the objects just added
rm(list=ls())
