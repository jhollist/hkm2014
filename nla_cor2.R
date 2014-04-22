##4-21-2014: intial correlation test for variable selection
**This data set contains one data.frame "hkm2014"

************
#Data Definitions:
browseURL('https://github.com/jhollist/hkm2014/blob/master/data/hkm2014Data.md')

#The data can be loaded into R with the following code:
	
#Get the Data
load(url('https://raw.github.com/jhollist/hkm2014/master/data/hkm2014Data.rda'))


WQ.var<-c("AlbersX","AlbersY","LakeArea","LakePerim","ShoreDevel","BASINAREA","DEPTHMAX","ELEV_PT",
					 "CHLA","DO2_2M","PH_FIELD","COND","ANC","TURB","TOC","DOC","NH4","NO3_NO2","NTL","PTL","CL",
					 "NO3","SO4","CA","MG","Na","K","COLOR","SIO2","H","OH","NH4ION","CATSUM","ANSUM2","ANDEF2","SOBC",
					 "BALANCE2","ORGION","CONCAL2","CONDHO2","SECMEAN","TminW","TmaxW","TmeanW","DDs40","DDs45","DDs50",
					 "DDs55","MaxLength","MaxWidth","MeanWidth","FetchN","FetchNE","FetchE","FetchSE","MaxDepthCorrect",
					 "VolumeCorrect","MeanDepthCorrect")


Data.play<-hkm2014Data
Data.play$BALANCE2<-Data.play$BALANCE2+16.39


###Creating transformed percent data sets
MaxDistPerTrans.data<-asin(sqrt((Data.play[,c(4,23:39)])/100))
MaxDistPerTrans.data<-cbind(MaxDistPerTrans.data,log1p(Data.play[,158]))


Buffer300PerTrans.data<-asin(sqrt((Data.play[,c(40,59:75)])/100))
Buffer300PerTrans.data<-cbind(Buffer300PerTrans.data,log1p(Data.play[,158]))

Buffer1500PerTrans.data<-asin(sqrt((Data.play[,c(76,95:111)])/100))
Buffer1500PerTrans.data<-cbind(Buffer1500PerTrans.data,log1p(Data.play[,158]))

Buffer3000PerTrans.data<-asin(sqrt((Data.play[,c(112,131:147)])/100))
Buffer3000PerTrans.data<-cbind(Buffer1500PerTrans.data,log1p(Data.play[,158]))

##Running correlations
MaxDistKM2.cor<-round(cor(log1p(Data.play[,c(5,7:22,158)]),use="pairwise.complete.obs"),3)
MaxDistPer.cor<-round(cor(MaxDistPerTrans.data,use="pairwise.complete.obs"),3)

Buffer300KM2.cor<-round(cor(log1p(Data.play[,c(41,43:58,158)]),use="pairwise.complete.obs"),3)
Buffer300Per.cor<-round(cor(Buffer300PerTrans.data,use="pairwise.complete.obs"),3)

Buffer1500KM2.cor<-round(cor(log1p(Data.play[,c(77,79:94,158)]),use="pairwise.complete.obs"),3)
Buffer1500Per.cor<-round(cor(Buffer1500PerTrans.data,use="pairwise.complete.obs"),3)

Buffer3000KM2.cor<-round(cor(log1p(Data.play[,c(113,115:130)]),use="pairwise.complete.obs"),3)
Buffer3000Per.cor<-round(cor(Buffer3000PerTrans.data,use="pairwise.complete.obs"),3)





write.csv(MaxDistKM2.cor,file="MaxDistKM2Cor.csv")
write.csv(Buffer300KM2.cor,file="Buffer300KM2Cor.csv")
write.csv(Buffer1500KM2.cor,file="Buffer1500KM2Cor.csv")
write.csv(Buffer300KM2.cor,file="Buffer3000KM2Cor.csv")

write.csv(MaxDistPer.cor,file="MaxDistPerCor.csv")
write.csv(Buffer300Per.cor,file="Buffer300PerCor.csv")
write.csv(Buffer1500Per.cor,file="Buffer1500PerCor.csv")
write.csv(Buffer300Per.cor,file="Buffer3000PerCor.csv")

