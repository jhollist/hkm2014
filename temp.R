devtools::install_github("hkm","jhollist") #install.packages("devtools")
library(hkm)
data(hkm2014Data)  

#Create a Chla Category with Low=first Quartile (Q1); Med=Q2 & Q3; High=Q4
	chlaCat<-rep('MED',nrow(hkm2014Data))
	chlaCat[hkm2014Data$CHLA<=quantile(hkm2014Data$CHLA,.25,na.rm=T)]<-'LOW'
	chlaCat[hkm2014Data$CHLA>=quantile(hkm2014Data$CHLA,.75,na.rm=T)]<-'HIGH'
	chlaCat[is.na(hkm2014Data$CHLA)]<-NA

table(chlaCat,useNA='ifany')



require('classInt')
	options(scipen=5) #tell r not to use scientific notation on axis labels
windows(10,7.5)
par(mfrow=c(2,2))
	Chla<-log(na.exclude(hkm2014Data$CHLA))
#breaks based on Q1,Q2&3,Q4
		Q1Q4<-classIntervals(Chla, n=3, style="fixed",
													fixedBreaks=c(min(Chla),quantile(Chla,.25),quantile(Chla,.75),max(Chla)))[[2]]
		plot(density(Chla),main='Q1, Q2&3, Q4');abline(v=Q1Q4)

#breaks based on quantile
quantile<-classIntervals(Chla, n=3, style="quantile")[[2]]
plot(density(Chla),main='quantile');abline(v=quantile)

#breaks based on sd
		sd<-classIntervals(Chla, n=3, style="sd")[[2]]
		plot(density(Chla),main='sd');abline(v=sd)

#breaks based on equal
equal<-classIntervals(Chla, n=3, style="equal")[[2]]
plot(density(Chla),main='equal');abline(v=equal)

############

#Create a Chla Category with Low=first Quartile (Q1); Med=Q2 & Q3; High=Q4
chlaCat<-rep('MED',nrow(hkm2014Data))
chlaCat[hkm2014Data$CHLA<=quantile(hkm2014Data$CHLA,.25,na.rm=T)]<-'LOW'
chlaCat[hkm2014Data$CHLA>=quantile(hkm2014Data$CHLA,.75,na.rm=T)]<-'HIGH'
chlaCat[is.na(hkm2014Data$CHLA)]<-NA


table(chlaCat,useNA='ifany')
hkm2014Data$chlaCat<-chlaCat
hkm2014Data$chlaCat<-factor(hkm2014Data$chlaCat,ordered=T,levels=c("LOW","MED","HIGH"))



plot(density(Chla),type='p',pch=16)


#############
#random forest on only varSel variables
varSelAll.var<-c('NPratio','NTL','PTL','TOC','TURB','K','WSA_ECO9')

RF<-randomForest(hkm2014Data[keep,'chlaCat']~., data=Pall[keep,varSelAll.var],ntree =5000,
													 importance=TRUE,proximity=TRUE)

a<-unclass(hkm2014Data[keep,'chlaCat'])==unclass(RF$predicted)

head(a)

Color<-rep('red',length(a))
Color[a==T]<-'green'

plot(density(hkm2014Data[keep,'CHLA']),type='p',pch=16,log='x')

plot(density(log(hkm2014Data[keep,'CHLA'])),type='p',pch=16,log='x',col=Color,cex=1)
	abline(v=log(quantile(hkm2014Data$CHLA,.25,na.rm=T)))
	abline(v=log(quantile(hkm2014Data$CHLA,.75,na.rm=T)))









