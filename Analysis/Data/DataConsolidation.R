##################
# Created by Ed Anderson
# Date 22nd April 2017
# Purpose: Produce final files which can be used as input to data analysis
##################

# Import the key data sets
MainData<-read.table("Analysis/Data/MainData",sep=",",stringsAsFactors = FALSE)
APIData<-read.table("Analysis/Data/APIData",sep=",",stringsAsFactors = FALSE)
AddressData<-read.table("Analysis/Data/AddressData",sep=",",stringsAsFactors = FALSE)
ZillowDataSet6<-read.table("Analysis/Data/ZillowDataSet6",sep=",",stringsAsFactors = FALSE)

# Enrich with API Data from Google
MainData2<-data.frame(MainData,APIData)

#Remove duplicate transaction numbers
MainData2<-MainData2[!duplicated(MainData[,1]),]

# Enrich with Address Data
MainData3<-data.frame(MainData2,AddressData)

# Enrich with API Data from Zillow
MainData4<-data.frame(MainData3,ZillowDataSet6)

# Final Enriched Data

write.table(MainData4,file="Analysis/Data/EnrichedData",sep=",")
