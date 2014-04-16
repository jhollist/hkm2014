v<-'cyanoPCA.r'

####################Load the NLA Data and Biovolume Data
#Data Definitions:  
#
browseURL('https://github.com/jhollist/cyanoLakes/blob/master/bryan/cyanoBioVolData.md')
#Get the Data
load(url('https://raw.github.com/jhollist/cyanoLakes/master/bryan/cyanoBioVolData.rda'))

##Variables names to use in correlation 
#trans_var_cor<-c("DO2_2M","PH_FIELD","TminW","TmaxW","TmeanW","ANC","ANDEF2","NO3_NO2",
#					 "NO3","BALANCE2","Ln_LakeArea","Ln_LakePerim","Ln_BASINAREA","Ln_DEPTHMAX",
#					 "Ln_CHLA","Ln_COND","Ln_TURB","Ln_TOC","Ln_DOC","Ln_NH4","Ln_NTL","Ln_PTL",
#					 "Ln_CL","Ln_SO4","Ln_CA","Ln_MG","Ln_Na","Ln_K","Ln_SIO2","Ln_CATSUM","Ln_ANSUM2",
#					 "Ln_SOBC","Ln_ORGION","Ln_CONCAL2","Ln_CONDHO2","Ln_SECMEAN","Ln_DDs40","Ln_DDs45",
#					 "Ln_DDs50","Ln_DDs55","Ln_MeanWidth","Ln_FetchN","Ln_FetchNE","Ln_FetchE","Ln_FetchSE",
#					 "Ln_ShoreDevel","Ln_MaxLength","Ln_MaxWidth","Ln_MaxDepthCorrect","Ln1p_sumBioV",
#					 "Ln1p_ELEV_PT","Ln1p_COLOR","Ln1p_H","Ln1p_OH","Ln1p_NH4ION","Ln1p_VolumeCorrect",
#					 "Ln1p_Microcystin_ugl")

var_cor<-c("AlbersX","AlbersY","LakeArea","LakePerim","ShoreDevel","BASINAREA","DEPTHMAX","ELEV_PT",
					 "CHLA","DO2_2M","PH_FIELD","COND","ANC","TURB","TOC","DOC","NH4","NO3_NO2","NTL","PTL","CL",
					 "NO3","SO4","CA","MG","Na","K","COLOR","SIO2","H","OH","NH4ION","CATSUM","ANSUM2","ANDEF2","SOBC",
					 "BALANCE2","ORGION","CONCAL2","CONDHO2","SECMEAN","TminW","TmaxW","TmeanW","DDs40","DDs45","DDs50",
					 "DDs55","MaxLength","MaxWidth","MeanWidth","FetchN","FetchNE","FetchE","FetchSE","MaxDepthCorrect",
					 "VolumeCorrect","MeanDepthCorrect")


NLA.sub<-bioV[,var_cor]
NLA.sub$BALANCE2<-NLA.sub$BALANCE2+16.39


NLA.cor<-round(cor(log1p(NLA.sub[,3:58]),use="pairwise.complete.obs"),3)
write.csv(NLA.cor,file="NLACorrelation.csv")

