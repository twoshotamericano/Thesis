# X1-ZWz1frh8seu8ln_8nu8h
# X1-ZWz198xlxzd2iz_1acr8
# X1-ZWz1frkyyihyx7_1brbp
# X1-ZWz1frl2wkq2vf_1ekgn
# X1-ZWz198xe1uwumj_1fz14
# X1-ZWz1frl6umy6tn_1hdll
# X1-ZWz1frlasp6arv_1k6qj
# X1-ZWz1frlyh2iyh7_211k7
# X1-ZWz198wejavv2j_2599m
# X1-ZWz1frm6d6z6dn_26nu3
# X1-ZWz198wal8nr4b_282ek
## X1-ZWz1frmab97abv_29gz1
## X1-ZWz198w2p47j7v_2doog
## X1-ZWz1frmi7dni8b_2f38x
## X1-ZWz198vyr1zf9n_2ghte
## X1-ZWz1frmm5fvm6j_2hwdv
## X1-ZWz198vuszrbbf_2jayc
## X1-ZWz1frmq3i3q4r_2kpit
## X1-ZWz198vquxj7d7_2m43a
# X1-ZWz198vmwvb3ez_2ox88
# X1-ZWz1frmxzmjy17_2qbsp
#

# Load the Packages
library(httr)
library(xml2)
library(XML)
library(ZillowR)

#Load the Data
##Address Data
data20<-read.table("C:/ThesisSource/Thesis/Analysis/Data/AddressData",sep=",")
##Complete Listing of Postcodes
data21<-read.table("C:/ThesisSource/Thesis/Analysis/Data/MainData",sep=",")
data21<-data21[!duplicated(data21[,1]),]
data21<-merge(data20,data21[,c("TransactionNo","ZipCode")],by="TransactionNo")


#Address Data
start<-18286
end<-18899
#Length=160

#ZillowDataSet<-data.frame(ResponseCode=rep("999",each=Length),
#                          zpid=rep("999",each=Length),
#                          AddressStreet=rep("999",each=Length),
#                          AddressZipCode=rep("999",each=Length),
#                          AddressCity=rep("999",each=Length),
#                          AddressState=rep("999",each=Length),
#                          AddressLatitude=rep("999",each=Length),
#                          AddressLongitude=rep("999",each=Length),
#                          UseCode=rep("999",each=Length),
#                          YearBuilt=rep("999",each=Length),
#                          LotSizeSqFt=rep("999",each=Length),
#                          FinishedSizeSqFt=rep("999",each=Length),
#                          BathroomNo=rep("999",each=Length),
#                          BedroomNo=rep("999",each=Length),
#                          #LastSoldDate=rep("999",each=21436),
#                          #LastSoldPrice=rep("999",each=21436),
#                          ZestimateAmount=rep("999",each=Length),
#                          ZestimateLastUpdated=rep("999",each=Length),
#                          ZestimateOneWeekChange=rep("999",each=Length),
#                          ZestimateValueChange=rep("999",each=Length),
#                          ZestimateValueChangeDuration=rep("999",each=Length),
#                          ZestimateLowValueRange=rep("999",each=Length),
#                          ZestimateHighValueRange=rep("999",each=Length),
#                          ZestimateValuePercentile=rep("999",each=Length),
#                          RZestimateAmount=rep("999",each=Length),
#                          RZestimateLastUpdated=rep("999",each=Length),
#                          RZestimateOneWeekChange=rep("999",each=Length),
#                          RZestimateValueChange=rep("999",each=Length),
#                          RZestimateValueChangeDuration=rep("999",each=Length),
#                          RZestimateLowValueRange=rep("999",each=Length),
#                          RZestimateHighValueRange=rep("999",each=Length),
#                          RegionIndexValue=rep("999",each=Length),
#                          RegionAttributeName=rep("999",each=Length),
#                          RegionAttributeNeighbourhood=rep("999",each=Length),
#                          RegionAttributeID=rep("999",each=Length),
#                          stringsAsFactors = FALSE)

#KeyInfo
ZWSID<-"X1-ZWz198vquxj7d7_2m43a"

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



  if (ZillowDataSet[i,1]!="508" & class(APIResult$response[["results"]])[[1]]!="NULL" )
    {if (!is.null(row.names(xmlToList(APIResult$response[["results"]]))))

    #Parse the data
    {

      for (j in 1:32) {
      resultdata <- xmlToList(APIResult$response[["results"]])

      ZillowDataSet[i,j+1]<-Zillowf(resultdata)[[j]]
                      }


      Sys.sleep(0.5)
    }
  }
  }


#Function to Parse the Zillow Data


Zillowf<-function(property) {

  #Create a local variable to strore the search results
  Output<-list(zpid=character(999),
               AddressStreet=character(999),
               AddressZipCode=character(999),
               AddressCity=character(999),
               AddressState=character(999),
               AddressLatitude=character(999),
               AddressLongitude=character(999),
               UseCode=as.character(999),
               YearBuilt=as.character(999),
               LotSizeSqFt=as.character(999),
               FinishedSizeSqFt=as.character(999),
               BathroomNo=as.character(999),
               BedroomNo=as.character(999),
               #LastSoldDate=character(999),
               #LastSoldPrice=character(999),
               ZestimateAmount=as.character(999),
               ZestimateLastUpdated=as.character(999),
               ZestimateOneWeekChange=as.character(999),
               ZestimateValueChange=as.character(999),
               ZestimateValueChangeDuration=as.character(999),
               ZestimateLowValueRange=as.character(999),
               ZestimateHighValueRange=as.character(999),
               ZestimateValuePercentile=as.character(999),
               RZestimateAmount=as.character(999),
               RZestimateLastUpdated=as.character(999),
               RZestimateOneWeekChange=as.character(999),
               RZestimateValueChange=as.character(999),
               RZestimateValueChangeDuration=as.character(999),
               RZestimateLowValueRange=as.character(999),
               RZestimateHighValueRange=as.character(999),
               RegionIndexValue=as.character(999),
               RegionAttributeName=as.character(999),
               RegionAttributeNeighbourhood=as.character(999),
               RegionAttributeID=as.character(999))

  # Loop through the list of results and place the data in appropriate place

  for (k in 1:length(row.names(property))){

    if (row.names(property)[k]=="zpid")
    {Output$zpid=property[[k]]}

    else if (row.names(property)[k]=="address")
    {Output$AddressStreet=property[[k]]$street
    Output$AddressZipCode=property[[k]]$zipcode
    Output$AddressCity=property[[k]]$city
    Output$AddressState=property[[k]]$state
    Output$AddressLatitude=property[[k]]$latitude
    Output$AddressLongitude=property[[k]]$longitude}

    else if (row.names(property)[k]=="useCode")
    {
      Output$UseCode=property[[k]]
    }

    else if (row.names(property)[k]=="finishedSqFt")
    {
      Output$FinishedSizeSqFt=property[[k]]
    }
    else if (row.names(property)[k]=="bathrooms")
    {
      Output$BathroomNo=property[[k]]
    }
    else if (row.names(property)[k]=="bedrooms")
    {
      Output$BedroomNo=property[[k]]
    }

    else if (row.names(property)[k]=="zestimate")
    {

      if(length(property[[k]]$amount)!=1){Output$ZestimateAmount=property[[k]]$amount$text} else {Output$ZestimateAmount="999"}
      Output$ZestimateLastUpdated=property[[k]]$`last-updated`
      Output$ZestimateOneWeekChange=property[[k]]$oneWeekChange[[1]]
      if(!is.null(property[[k]]$valueChange$text)) {Output$ZestimateValueChange=property[[k]]$valueChange$text}
      if (!is.null(property[[k]]$valueChange$.attrs[[1]])) {Output$ZestimateValueChangeDuration=property[[k]]$valueChange$.attrs[[1]]}
      Output$ZestimateLowValueRange=property[[k]]$valuationRange[[1]]
      if (length(property[[k]]$valuationRange)>2) {Output$ZestimateHighValueRange=property[[k]]$valuationRange[[3]]} else {Output$ZestimateHighValueRange="999"}
      Output$ZestimateValuePercentile=property[[k]]$percentile[[1]]
    }
    else if (row.names(property)[k]=="rentzestimate")
    {
      Output$RZestimateAmount=property[[k]]$amount$text
      Output$RZestimateLastUpdated=property[[k]]$`last-updated`
      Output$RZestimateOneWeekChange=property[[k]]$oneWeekChange[[1]]
      Output$RZestimateValueChange=property[[k]]$valueChange$text
      Output$RZestimateValueChangeDuration=property[[k]]$valueChange$.attrs[[1]]
      Output$RZestimateLowValueRange=property[[k]]$valuationRange[[1]]
      Output$RZestimateHighValueRange=property[[k]]$valuationRange[[3]]
    }

    else if (row.names(property)[k]=="localRealEstate")
    {
      Output$RegionIndexValue="999" #property[[k]][[1]]
      Output$RegionAttributeName="999" #property[[k]][[3]][[1]]
      Output$RegionAttributeNeighbourhood="999" #property[[k]][[3]][[3]]
      Output$RegionAttributeID="999" #property[[k]][[3]][[2]]
    }

  }

  Output



}

Zillowf2<-function(property) {

  #Create a local variable to strore the search results
  Output<-list(zpid=character(999),
               AddressStreet=character(999),
               AddressZipCode=character(999),
               AddressCity=character(999),
               AddressState=character(999),
               AddressLatitude=character(999),
               AddressLongitude=character(999),
               UseCode=as.character(999),
               YearBuilt=as.character(999),
               LotSizeSqFt=as.character(999),
               FinishedSizeSqFt=as.character(999),
               BathroomNo=as.character(999),
               BedroomNo=as.character(999),
               #LastSoldDate=character(999),
               #LastSoldPrice=character(999),
               ZestimateAmount=as.character(999),
               ZestimateLastUpdated=as.character(999),
               ZestimateOneWeekChange=as.character(999),
               ZestimateValueChange=as.character(999),
               ZestimateValueChangeDuration=as.character(999),
               ZestimateLowValueRange=as.character(999),
               ZestimateHighValueRange=as.character(999),
               ZestimateValuePercentile=as.character(999),
               RZestimateAmount=as.character(999),
               RZestimateLastUpdated=as.character(999),
               RZestimateOneWeekChange=as.character(999),
               RZestimateValueChange=as.character(999),
               RZestimateValueChangeDuration=as.character(999),
               RZestimateLowValueRange=as.character(999),
               RZestimateHighValueRange=as.character(999),
               RegionIndexValue=as.character(999),
               RegionAttributeName=as.character(999),
               RegionAttributeNeighbourhood=as.character(999),
               RegionAttributeID=as.character(999))

  # Loop through the list of results and place the data in appropriate place

  for (k in 1:length(row.names(property))){

    if (row.names(property)[k]=="zpid")
    {Output$zpid=property[[k]]}

    else if (row.names(property)[k]=="address")
    {Output$AddressStreet=property[[k]]$street
    Output$AddressZipCode=property[[k]]$zipcode
    Output$AddressCity=property[[k]]$city
    Output$AddressState=property[[k]]$state
    Output$AddressLatitude=property[[k]]$latitude
    Output$AddressLongitude=property[[k]]$longitude}

    else if (row.names(property)[k]=="useCode")
    {
      Output$UseCode=property[[k]]
    }

    else if (row.names(property)[k]=="finishedSqFt")
    {
      Output$FinishedSizeSqFt=property[[k]]
    }
    else if (row.names(property)[k]=="bathrooms")
    {
      Output$BathroomNo=property[[k]]
    }
    else if (row.names(property)[k]=="bedrooms")
    {
      Output$BedroomNo=property[[k]]
    }

    else if (row.names(property)[k]=="zestimate")
    {
      Output$ZestimateAmount=property[[k]]$amount$text
      Output$ZestimateLastUpdated=property[[k]]$`last-updated`
      Output$ZestimateOneWeekChange=property[[k]]$oneWeekChange[[1]]
      Output$ZestimateValueChange=property[[k]]$valueChange$text
      Output$ZestimateValueChangeDuration=property[[k]]$valueChange$.attrs[[1]]
      Output$ZestimateLowValueRange=property[[k]]$valuationRange[[1]]
      Output$ZestimateHighValueRange=property[[k]]$valuationRange[[3]]
      Output$ZestimateValuePercentile=property[[k]]$percentile[[1]]
    }
    else if (row.names(property)[k]=="rentzestimate")
    {
      Output$RZestimateAmount=property[[k]]$amount$text
      Output$RZestimateLastUpdated=property[[k]]$`last-updated`
      Output$RZestimateOneWeekChange=property[[k]]$oneWeekChange[[1]]
      Output$RZestimateValueChange=property[[k]]$valueChange$text
      Output$RZestimateValueChangeDuration=property[[k]]$valueChange$.attrs[[1]]
      Output$RZestimateLowValueRange=property[[k]]$valuationRange[[1]]
      Output$RZestimateHighValueRange=property[[k]]$valuationRange[[3]]
    }

    else if (row.names(property)[k]=="localRealEstate")
    {
      Output$RegionIndexValue="999" #property[[k]][[1]]
      Output$RegionAttributeName="999" #property[[k]][[3]][[1]]
      Output$RegionAttributeNeighbourhood="999" #property[[k]][[3]][[3]]
      Output$RegionAttributeID="999" #property[[k]][[3]][[2]]
    }

  }

  Output



}

