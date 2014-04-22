##4-21-2014: intial correlation test and random forest
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


MaxDist.cor<-round(cor(log1p(Data.play[,c(3:39,158)]),use="pairwise.complete.obs"),3)
Buffer300m.cor<-round(cor(log1p(Data.play[,c(40:75,158)]),use="pairwise.complete.obs"),3)
Buffer1500m.cor<-round(cor(log1p(Data.play[,c(76:111,158)]),use="pairwise.complete.obs"),3)
Buffer3000m.cor<-round(cor(log1p(Data.play[,c(112:147,158)]),use="pairwise.complete.obs"),3)
WQ.cor<-round(cor(log1p(Data.play[,WQ.var]),use="pairwise.complete.obs"),3)

write.csv(MaxDist.cor,file="MaxDistCor.csv")
write.csv(Buffer300m.cor,file="Buffer300mCor.csv")
write.csv(Buffer1500m.cor,file="Buffer1500mCor.csv")
write.csv(Buffer3000m.cor,file="Buffer3000mCor.csv")
write.csv(WQ.cor,file="WQCor.csv")
