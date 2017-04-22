##########
# Created by: Ed Anderson
# Date: 22nd April 2017
# Purpose: Preliminary steps to data enrichment with Zillow API
##########

# These are the packages required

library(httr)
library(xml2)
library(XML)
library(ZillowR)

# Load the functions required

source("Analysis/UsefulFunctions.R")

# Load the Input Data and Perform Data Wrangling
## The Zillow API Needs has mandatory data
## This includes Street No, Street Name, State and Post Code

# This is the Street No, Street Name and State Info
data20<-read.table("C:/ThesisSource/Thesis/Analysis/Data/AddressData",sep=",")

# This is the zipcode data
data21<-read.table("C:/ThesisSource/Thesis/Analysis/Data/MainData",sep=",")

# I removed duplicate addresses to save time
data21<-data21[!duplicated(data21[,1]),]

# I enriched data20 with the postcode data
data21<-merge(data20,data21[,c("TransactionNo","ZipCode")],by="TransactionNo")

# Create the data frame for storing the output results

Length<-length(data21[,1])

ZillowDataSet<-data.frame(ResponseCode=rep("999",each=Length),
                          zpid=rep("999",each=Length),
                          AddressStreet=rep("999",each=Length),
                          AddressZipCode=rep("999",each=Length),
                          AddressCity=rep("999",each=Length),
                          AddressState=rep("999",each=Length),
                          AddressLatitude=rep("999",each=Length),
                          AddressLongitude=rep("999",each=Length),
                          UseCode=rep("999",each=Length),
                          YearBuilt=rep("999",each=Length),
                          LotSizeSqFt=rep("999",each=Length),
                          FinishedSizeSqFt=rep("999",each=Length),
                          BathroomNo=rep("999",each=Length),
                          BedroomNo=rep("999",each=Length),
                          #LastSoldDate=rep("999",each=21436),
                          #LastSoldPrice=rep("999",each=21436),
                          ZestimateAmount=rep("999",each=Length),
                          ZestimateLastUpdated=rep("999",each=Length),
                          ZestimateOneWeekChange=rep("999",each=Length),
                          ZestimateValueChange=rep("999",each=Length),
                          ZestimateValueChangeDuration=rep("999",each=Length),
                          ZestimateLowValueRange=rep("999",each=Length),
                          ZestimateHighValueRange=rep("999",each=Length),
                          ZestimateValuePercentile=rep("999",each=Length),
                          RZestimateAmount=rep("999",each=Length),
                          RZestimateLastUpdated=rep("999",each=Length),
                          RZestimateOneWeekChange=rep("999",each=Length),
                          RZestimateValueChange=rep("999",each=Length),
                          RZestimateValueChangeDuration=rep("999",each=Length),
                          RZestimateLowValueRange=rep("999",each=Length),
                          RZestimateHighValueRange=rep("999",each=Length),
                          RegionIndexValue=rep("999",each=Length),
                          RegionAttributeName=rep("999",each=Length),
                          RegionAttributeNeighbourhood=rep("999",each=Length),
                          RegionAttributeID=rep("999",each=Length),
                          stringsAsFactors = FALSE)

# Select an API key

# This is the key used

ZWSID<-"X1-ZWz198vquxj7d7_2m43a"

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

