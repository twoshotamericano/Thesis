library(plyr)

#Here is the Zillow Data
data<-read.table("Analysis/Data/ZillowDataSetX",sep=",",stringsAsFactors = FALSE)

##Data21 is the Location Data with zipcodes
source("Analysis/Data/ZillowAPICalls.R")

data$MergingCode<-data21$ZipCode

#Summary Statistics by ZipCode
a<-ddply(data,~MergingCode,summarise,
         MeanZestimateAmount=mean(ZestimateAmount,na.rm=TRUE),
         MeanZestimateLowValueRange=mean(ZestimateAmount,na.rm=TRUE)-
                  (mean(ZestimateHighValueRange,na.rm=TRUE)-mean(ZestimateAmount,na.rm=TRUE)),
         MeanZestimateHighValueRange=mean(ZestimateHighValueRange,na.rm=TRUE),
         MeanRZestimateAmount=mean(RZestimateAmount,na.rm=TRUE),
         MeanRZestimateLowValueRange=mean(RZestimateLowValueRange,na.rm=TRUE),
         MeanRZestimateHighValueRange=mean(RZestimateHighValueRange,na.rm=TRUE),
         Count=length(zpid))


data<-merge(data,a,by="MergingCode")

#Subset the Address Data to the problem cases
data[data$ResponseCode=="508"|is.na(data$zpid)==TRUE|data$AddressZipCode==999,
     c("ZestimateAmount","ZestimateLowValueRange","ZestimateHighValueRange",
        "RZestimateAmount","RZestimateLowValueRange","RZestimateHighValueRange")]<-
  data[data$ResponseCode=="508"|is.na(data$zpid)==TRUE|data$AddressZipCode==999,
       c("MeanZestimateAmount","MeanZestimateLowValueRange","MeanZestimateHighValueRange",
         "MeanRZestimateAmount","MeanRZestimateLowValueRange","MeanRZestimateHighValueRange")]

#Remove ExtraColumns

data<-subset(data,select=-c(MergingCode,
                            MeanZestimateAmount,
                            MeanZestimateLowValueRange,
                            MeanZestimateHighValueRange,
                            MeanRZestimateAmount,
                            MeanRZestimateLowValueRange,
                            MeanRZestimateHighValueRange,
                            Count) )

#Write results to table
write.table(ZillowDataSet,file="Analysis/Data/ZillowDataSetX",sep=",")
