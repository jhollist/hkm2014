v<-'NLA_Chla_PCA20130620'
# Read data-****Make Sure the Path Is Correct****
require(RODBC)   #Package RODBC must be installed
con <- odbcConnectAccess("L:/Public/Milstead_Lakes/WaterbodyDatabase/WaterbodyDatabase.mdb")
NLA <- sqlQuery(con, "
SELECT tblNLA_WaterQualityData.SITE_ID, tblNLA_WaterQualityData.NTL, tblNLA_WaterQualityData.PTL, tblNLA_WaterQualityData.CHLA, NLA2007Sites_DesignInfo.WSA_ECO9, NLA2007Sites_DesignInfo.LAKEAREA, NLA2007Sites_DesignInfo.DEPTHMAX
FROM tblNLA_WaterQualityData INNER JOIN NLA2007Sites_DesignInfo ON (tblNLA_WaterQualityData.VISIT_NO = NLA2007Sites_DesignInfo.VISIT_NO) AND (tblNLA_WaterQualityData.SITE_ID = NLA2007Sites_DesignInfo.SITE_ID);
")
close(con)
str(NLA) 

#Lake Morphometry calculations
  NLA$ConicVol<-NLA$LAKEAREA*1000000*NLA$DEPTHMAX/3
  NLA$Zmean<-NLA$ConicVol/NLA$LAKEAREA
#calc NP ratio 
  NLA$NPR<-NLA$NTL/NLA$PTL
#add grouping variable
  NLA$group<-cut(NLA$CHLA, breaks=c(quantile(NLA$CHLA, probs = c(0,.25,.75,1),na.rm=T)),labels=c('Low','Med','High'),
    include.lowest=T,ordered_result=T,right=F)

NLA2012<-read.csv("NLA2012_TN_TP_Chla.csv")
#################################NLA Data Definitions N=1157
  #SITE_ID: NLA lake identifier
  #NTL: (ug/l) Total Nitrogen
  #PTL: (ug/l) Total Phosphorus
  #CHLA: (ug/l) Chlorophyll a
  #WSA_ECO9: Wadeable Streams Assessment Aggregated Ecoregion 
        #CPL              Coastal Plains
        #NAP            Northern Appalachians
        #NPL             Northern Plains
        #SAP             Southern Appalachians
        #SPL              Southern Plains
        #TPL              Temporate Plains
        #UMW         Upper Midwest
        #WMT          Western Mountains
        #XER              Xeric
  #LAKEAREA:  (Km2) NLA estimated of Lake polygon area from NHD
  #DEPTHMAX:  (m) Maximum Observed Lake Depth  (1 missing value)
  #ConicVol: (m3) Volume of a cone with area = LAKEAREA and Height=DEPTHMAX(1 missing value)
  #Zmean: (m) Mean Depth=ConicVol/DEPTHMAX
  #NPR: Ratio (by weight) of N to P 
  #group:  separate CHLA distribution into 1st quartile ("Low"), 2nd & 3rd Q ("Med") and 4th Q ("High)
  

#################################
#Jeff's quick MDS
install.packages("cluster")
library(cluster)

tnTpRatio<-data.frame(TN=log(NLA$NTL),TP=log(NLA$PTL),TNTP=NLA$NTL/NLA$PTL)
tnTpRatio_dissim<-daisy(tnTpRatio)
tnTpRatio_MDS<-cmdscale(tnTpRatio_dissim)
plot(tnTpRatio_MDS[,2],tnTpRatio_MDS[,1],col=NLA$group)

tnTpRatio_pca<-princomp(tnTpRatio,cor=TRUE)
str(tnTpRatio_pca)
plot(tnTpRatio_pca$scores[,1],tnTpRatio_pca$scores[,2],col=NLA$group)

plot(log(tnTpRatio$TN),log(tnTpRatio$TP),col=NLA$group)

###################################
#log(Chl a) = f(log(TP))
tpLogLogLinear <- lm(log(CHLA)~log(PTL),data=NLA)
summary(tpLogLogLinear)

#log(Chl a) = f(log(TN))
tnLogLogLinear <- lm(log(CHLA)~log(NTL),data=NLA)
summary(tnLogLogLinear)

#log(Chl a) = f(log(TP)+log(TN))
tptnLogLogLinear <- lm(log(CHLA)~log(PTL)+log(NTL),data=NLA)
summary(tptnLogLogLinear)

#log(Chl a) = f(pca1 + pca2)
NLA_pca_df<-data.frame(logNTL=log(NLA$NTL),logPTL=log(NLA$PTL),NPR=NLA$NPR)
NLA_pca<-princomp(NLA_pca_df,cor=TRUE)
NLA_scores<-data.frame(CHLA=NLA$CHLA,pc1=NLA_pca$scores[,1],pc2=NLA_pca$scores[,2],pc3=NLA_pca$scores[,3])
NLA2012_pca_df<-data.frame(logNTL=log(NLA2012$NTL),logPTL=log(NLA2012$PTL),NPR=NLA2012$NPR)
NLA2012_pca_scores<-predict(NLA_pca,newdata=NLA2012_pca_df)
NLA2012_scores<-data.frame(CHLA=NLA2012$CHLA,pc1=NLA2012_pca_scores[,1],pc2=NLA2012_pca_scores[,2],pc3=NLA2012_pca_scores[,3])
pca12LogLinear <- lm(log(CHLA) ~ pc1 + pc2,data=NLA_scores)
summary(pca12LogLinear)
pca123LogLinear <- lm(log(CHLA) ~ pc1 + pc2 + pc3,data=NLA_scores)
summary(pca123LogLinear)

pairs(~ log(CHLA) + log(PTL)+ log(NTL),data=NLA)

#################################
#read in 2012 NLA data and prep for predictions.

names(NLA2012)[6]<-"CHLA"
NLA2012$NPR<-NLA2012$NTL/NLA2012$PTL
NLA2012_CHLA_tppredict<-predict(tpLogLogLinear,newdata=NLA2012)
tp2012tppredict<-lm(log(CHLA)~NLA2012_CHLA_tppredict,data=NLA2012)
summary(tp2012tppredict)
NLA2012_CHLA_tnpredict<-predict(tnLogLogLinear,newdata=NLA2012)
tp2012tnpredict<-lm(log(CHLA)~NLA2012_CHLA_tnpredict,data=NLA2012)
summary(tp2012tnpredict)
NLA2012_CHLA_tptnpredict<-predict(tptnLogLogLinear,newdata=NLA2012)
tp2012tptnpredict<-lm(log(CHLA)~NLA2012_CHLA_tptnpredict,data=NLA2012)
summary(tp2012tptnpredict)
NLA2012_CHLA_pca12predict<-predict(pca12LogLinear,newdata=NLA2012_scores)
tp2012pca12predict<-lm(log(CHLA)~NLA2012_CHLA_pca12predict,data=NLA2012_scores)
summary(tp2012pca12predict)
NLA2012_CHLA_pca123predict<-predict(pca123LogLinear,newdata=NLA2012_scores)
tp2012pca123predict<-lm(log(CHLA)~NLA2012_CHLA_pca123predict,data=NLA2012_scores)
summary(tp2012pca123predict)

