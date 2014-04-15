v<-'NLA_ChlaAnalysis20130820.r'

#read the raw NLA data
NLA<- read.csv('L:/Public/SSWR NEXUS-Concept/NPRatioManuscript/NLAdata20130812.csv')

#################################Data Definitions NLA n=2126 (NLA2007 n=1157; NLA2012  n=966) 
  #SITE_ID: NLA lake identifier
  #NTL: (ug/l) Total Nitrogen
  #PTL: (ug/l) Total Phosphorus
  #CHLA: (ug/l) Chlorophyll a
  #WSA_ECO9: Wadeable Streams Assessment Aggregated Ecoregion
        #CPL	Coastal Plains
        #NAP	Northern Appalachians
        #NPL	Northern Plains
        #SAP	Southern Appalachians
        #SPL	Southern Plains
        #TPL	Temporate Plains
        #UMW	Upper Midwest
        #WMT	Western Mountains
        #XER	Xeric
  #ALBERS_X: (m) x coordinate of lake location coordinate system=ESRI USA Contiguous Albers Equal Area Conic 
  #ALBERS_Y: (m) y coordinate of lake location coordinate system=ESRI USA Contiguous Albers Equal Area Conic 
        #ESRI USA Contiguous Albers Equal Area Conic 
        #AlbersContiguous<-CRS('+proj=aea +x_0=0 +y_0=0 +lon_0=-96 +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +units=m +datum=NAD83')
  #Year: Year of sample (2007 or 2012) 
  
#Separate NLA2007 and NLA2012
NLA2007<-subset(NLA,NLA$Year==2007)
NLA2012<-subset(NLA,NLA$Year==2012)
  
#build analysis data.frame
v2007<-with(NLA2007,data.frame(lnNTL=log(NTL),lnPTL=log(PTL),NPR=NTL/PTL,lnChla=log(CHLA),WSA_ECO9=WSA_ECO9))
v2012<-with(NLA2012,data.frame(lnNTL=log(NTL),lnPTL=log(PTL),NPR=NTL/PTL,lnChla=log(CHLA),WSA_ECO9=WSA_ECO9))

###############################Data Definitions v2007 and v2012 subsets of NLA2007 and NLA2012
  #lnNTL: (ug/l) log(NTL) Total Nitrogen
  #lnPTL: (ug/l) log(PTL) Total Phosphorus
  #lnCHLA: (ug/l) log(Chla) Chlorophyll a
  #NPR: ratio NTL/PTL (by weight)
  #WSA_ECO9: Wadeable Streams Assessment Aggregated Ecoregion
########################

########################
#Function to calculate Root Mean Squared Error
calcRMSE<-function(P,O)return(sqrt(mean((O-P)^2,na.rm=T)))

####function to plot obs vs. pred
plotOE<-function(P,O,Title,Color){
windows(3.75,3.75)   
par(mai=c(1.02,0.82,0.4,0.05))
  lim<-c(min(c(P,O),na.rm=TRUE),max(c(P,O),na.rm=TRUE))
  a<-summary(lm(P~O))
  plot(O,P,pch=16,col=Color,main=Title,xlab='Predicted Chla',ylab='Observed Chla',xlim=lim,ylim=lim)
      abline(0,1)
      legend('topleft',c(paste('adjR2 = ',round(a$adj.r.squared,4)),paste('RMSE = ',round(RMSE(P,O),4))),bty='n')
      mtext(v,side=1,line=4,cex=.7,adj=1)
      print(a)
}
####function to close all graphics windors
CloseAll<-function() for(i in c(1:length(dev.list())))dev.off()  #close all graphics windows
################
  
#Assign Colors by NTL, PTL, CHLA, & NPR
################Function to Assign color by threshold
assignColor<-function(X,Thresholds,Color){
TS<-rep(NA,length(X))
TS[X>Thresholds[1]]<-Color[1]
TS[X>Thresholds[2] & X<=Thresholds[1]]<-Color[2]
TS[X>Thresholds[3] & X<=Thresholds[2]]<-Color[3]
TS[X<=Thresholds[3]]<-Color[4]
return(TS)
}

Color<-c("red","orange","cyan","blue")
ThreshN<-c(1400,750,350)
ThreshC<-c(30,7,2)
ThreshP<-c(50,25,10)
NPR<-NLA2012$NTL/NLA2012$PTL
ThreshNPR<-rev(quantile(NPR)[2:4])

TS_NTL<-assignColor(NLA2012$NTL,ThreshN,Color)
TS_PTL<-assignColor(NLA2012$PTL,ThreshP,Color)
TS_CHLA<-assignColor(NLA2012$CHLA,ThreshC,Color)
Grp_NPR<-assignColor(NPR,ThreshNPR,Color)

##############
windows(10,7.5)
par(mfrow=c(2,2))

dfPCA<-'v2012'            #1.  We have decided to use the 2 factor PCA (TN and TP without NPratio).  The reason for this is that based on the linear algebra this has all the information we need.  The first PCA component will give information on the levels of nutrients and the second will give information on their ratio.  In the first factor both variable load either positive or both load negative.  For the second factor one loads positive and the other negative.  Since we are using log transformed data lnTN/lnTP = lnTN-lnTP.  So the signs are correct.
Cor<-F                    #2.  Using the correlation or the covariance matrix does not affect the result.  The rsq and rmse are identical.  Therefore we should use the covariance matrix because it involves less manipulation of the data and will therefore be easier to explain.  Also, both TN and TP are of similar magnitude so it is appropriate to use the covariance matrix.
Vars<-c('lnNTL','lnPTL')  #3.  We will build the model with the 2012 data and test it with the 2007 data.  The plots look better and the rsq is little higher  this way.

PCA1<-princomp(get(dfPCA)[,Vars],cor=Cor) 
summary(PCA1)
loadings(PCA1)

windows(10,5)
par(mfrow=c(1,2))

#PCA2 is essentially the NPratio.  Note the signs are opposite for the loadings of lnNTL and lnPTL
#So this is essentially lnNTL-lnPTL or log(NPR)
#Note:  PCA2 inversely related to NPR-high loading on PCA2=low NPR
plot(PCA1$scores[,2],log(v2012$NPR),pch=19,col='blue',ylab='ln(N:P ratio)',xlab='PCA Component 2')
plot(PCA1$scores[,2],v2012$lnNTL-v2012$lnPTL,pch=19,col='blue',ylab='lnNTL-lnPTL',xlab='PCA Component 2')

#PCA1 explains 88% of the variation and is clearly associated with nutrient levels
#PCA2 only explains 12% and is the NPR. 
#Positive relationship between PTL and PCA2 indicates that NPR decreases (PCA2 increases) with increasing PTL
#Negative relationship between NTL and PCA2 indicates that NPR increases (PCA2 decreases) with increasing NTL
par(mfrow=c(2,2))
plot(PCA1$scores[,1],v2012$lnNTL,pch=19,col='green',xlab='PCA Component 1')
plot(PCA1$scores[,1],v2012$lnPTL,pch=19,col='blue',xlab='PCA Component 1')
plot(PCA1$scores[,2],v2012$lnNTL,pch=19,col='green',xlab='PCA Component 2')
plot(PCA1$scores[,2],v2012$lnPTL,pch=19,col='blue',xlab='PCA Component 2')


windows()
#Leg<-'bottomleft'
#Leg<-'topleft'
Leg<-'bottomright'
x<-1
y<-2  
w<-3.5  #scale for the arrows
X <- PCA1$loadings*w  # Extract & scale loadings
plot(PCA1$scores[,x],PCA1$scores[,y],col=TS_CHLA,pch=16, xlab=paste('PCA Component ',x,sep=''),
      ylab=paste('PCA Component ',y,sep=''),
    main='Color Coded by Trophic State (Chla)')
  arrows(0, 0, X[,x], X[,y], len=0.1, col="black",lwd=2)  # Plot arrows
    text(1.1*X, rownames(X), col="black", xpd=T)  # Label the arrows
  arrows(-3, -1, -3, X[1,y], len=0.1, col="green",lwd=2)  # Plot inferred NPR arrow
    text(-3,1.1*X[1,y], 'NPR', col="green", xpd=T)  # Label the arrows
  legend(Leg,c('Hypereutrophic','Eutrophic','Mesotrophic','Oligotrophic'),col=Color,pch=16)
  
 
#################plot observed vs predicted chla
###PCA method
Color<-'orange'  #color for points
a<-cbind(v2012,predict(PCA1,v2012))  #observed dataset
b<-cbind(v2007,predict(PCA1,v2007))  #predicted dataset
LM<-lm(lnChla~Comp.1+Comp.2,data=a)  #run Linear Model
predChla<-predict(LM,b)             #get predicted CHLA for 2007
Out<-data.frame(obsChla=b$lnChla,predChla)  #dataframe of observed and predicted Chla for 2007
LM1<-summary(lm(Out$predChla~Out$obsChla))    #summary of regression pred~obs)
Lim<-c(min(Out,na.rm=T),max(Out,na.rm=T))   #set equal axis limits
plot(Out,pch=19,col=Color,xlim=Lim,ylim=Lim,#asp=1,
        xlab='Observed lnChla',ylab='Predicted lnChla',
  main='lnChla ~ Comp.1 + Comp.2')
  abline(0,1,lwd=2,col='grey')  #one to one line
  abline(LM1,col='blue',lwd=2)  #regresson line
  adjRsq<-round(LM1$adj.r.squared,4)
  RMSE<-round(calcRMSE(Out[,2],Out[,1]),4)
  legend('topleft',c(paste('adjRsq =',adjRsq),paste('RMSE =',RMSE)),bty='n')
  mtext(v,side=1,line=4,cex=.7,adj=1) 
###NTL method
Color<-'green'  #color for points
LM<-lm(lnChla~lnNTL,data=v2012)  #run Linear Model
predChla<-predict(LM,v2007)             #get predicted CHLA for 2007
Out<-data.frame(obsChla=b$lnChla,predChla)  #dataframe of observed and predicted Chla for 2007
LM1<-summary(lm(Out$predChla~Out$obsChla))    #summary of regression pred~obs)
Lim<-c(min(Out,na.rm=T),max(Out,na.rm=T))   #set equal axis limits
plot(Out,pch=19,col=Color,xlim=Lim,ylim=Lim,#asp=1,
        xlab='Observed lnChla',ylab='Predicted lnChla',
  main='lnChla ~ lnNTL')
  abline(0,1,lwd=2,col='grey')  #one to one line
  abline(LM1,col='blue',lwd=2)  #regresson line
  adjRsq<-round(LM1$adj.r.squared,4)
  RMSE<-round(calcRMSE(Out[,2],Out[,1]),4)
  legend('topleft',c(paste('adjRsq =',adjRsq),paste('RMSE =',RMSE)),bty='n')
  mtext(v,side=1,line=4,cex=.7,adj=1) 
  
###PTL method
Color<-'blue'  #color for points
LM<-lm(lnChla~lnPTL,data=v2012)  #run Linear Model
predChla<-predict(LM,v2007)             #get predicted CHLA for 2007
Out<-data.frame(obsChla=b$lnChla,predChla)  #dataframe of observed and predicted Chla for 2007
LM1<-summary(lm(Out$predChla~Out$obsChla))    #summary of regression pred~obs)
Lim<-c(min(Out,na.rm=T),max(Out,na.rm=T))   #set equal axis limits
plot(Out,pch=19,col=Color,xlim=Lim,ylim=Lim,#asp=1,
        xlab='Observed lnChla',ylab='Predicted lnChla',
  main='lnChla ~ lnPTL')
  abline(0,1,lwd=2,col='grey')  #one to one line
  abline(LM1,col='green',lwd=2)  #regresson line
  adjRsq<-round(LM1$adj.r.squared,4)
  RMSE<-round(calcRMSE(Out[,2],Out[,1]),4)
  legend('topleft',c(paste('adjRsq =',adjRsq),paste('RMSE =',RMSE)),bty='n')
  mtext(v,side=1,line=4,cex=.7,adj=1) 
  
###NTL PTL method
Color<-'pink'  #color for points
LM<-lm(lnChla~lnNTL + lnPTL,data=v2012)  #run Linear Model
predChla<-predict(LM,v2007)             #get predicted CHLA for 2007
Out<-data.frame(obsChla=b$lnChla,predChla)  #dataframe of observed and predicted Chla for 2007
LM1<-summary(lm(Out$predChla~Out$obsChla))    #summary of regression pred~obs)
Lim<-c(min(Out,na.rm=T),max(Out,na.rm=T))   #set equal axis limits
plot(Out,pch=19,col=Color,xlim=Lim,ylim=Lim,#asp=1,
        xlab='Observed lnChla',ylab='Predicted lnChla',
  main='lnChla ~ lnNTL + lnPTL')
  abline(0,1,lwd=2,col='grey')  #one to one line
  abline(LM1,col='green',lwd=2)  #regresson line
  adjRsq<-round(LM1$adj.r.squared,4)
  RMSE<-round(calcRMSE(Out[,2],Out[,1]),4)
  legend('topleft',c(paste('adjRsq =',adjRsq),paste('RMSE =',RMSE)),bty='n')
  mtext(v,side=1,line=4,cex=.7,adj=1) 
#########################PCA with 2 explanatory variables (lnNTL & lnPTL)
pcaLM2<-function(dfPCA,dfPredict,Cor,Color){
  Vars<-c('lnNTL','lnPTL')
  PCA<-princomp(dfPCA[,Vars],cor=Cor) 
  a<-cbind(dfPCA,predict(PCA,dfPCA))
  b<-cbind(dfPredict,predict(PCA,dfPredict))
  LM<-lm(lnChla~Comp.1+Comp.2,data=a)
  b$pcaChla<-predict(LM,b)
  Out<-data.frame(pcaChla=b$pcaChla,lnChla=b$lnChla)
  Lim<-c(min(Out,na.rm=T),max(Out,na.rm=T))
  plot(Out,pch=19,col=Color,asp=1,xlim=Lim,ylim=Lim,
    xlab='Predicted Chla',ylab='Observed Chla',
    main=paste('PCA=',deparse(substitute(dfPCA)),'    Predict=',deparse(substitute(dfPredict)),sep=""))
  abline(0,1)
  adjRsq<-round(summary(lm(Out[,1]~Out[,2]))$adj.r.squared,4)
  RMSE<-round(sqrt(mean((Out[,1]-Out[,2])^2,na.rm=T)),4)
  legend('topleft',c(paste('adjRsq =',adjRsq),paste('RMSE =',RMSE),paste('Vars =',Vars),paste('Cor =',Cor)),bty='n')
  mtext(v,side=1,line=4,cex=.7,adj=1)
    results<-data.frame(adjRsq=adjRsq,RMSE=RMSE,Cor=Cor,V1=Vars[1],V2=Vars[2])
  Out<-list(PCA,LM,results,Out)
  return(Out)
}

########################
#use 2007 data for PCA and LM-predict Chla for 2012 N & P
w<-pcaLM3(dfPCA=v2007,dfPredict=v2012,Cor=F,Color='orange')
  summary(w[[1]]) #w[[1]] is the PCA
    w[[1]]$loadings
  summary(w[[2]]) #w[[2]] is the LM
  #w[[3]] #w[[3]] is a summary of the results
  w[[3]]  #compare obs and predicted
  


windows(10,7.5)
par(mfrow=c(2,2))  
w<-pcaLM3(dfPCA=v2007,dfPredict=v2012,Cor=T,Color='orange')             
w<-pcaLM3(dfPCA=v2012,dfPredict=v2007,Cor=T,Color='orange')
w<-pcaLM3(dfPCA=v2007,dfPredict=v2012,Cor=F,Color='pink')             
w<-pcaLM3(dfPCA=v2012,dfPredict=v2007,Cor=F,Color='pink') 
################### 
windows(10,7.5)
par(mfrow=c(2,2))  
w<-pcaLM2(dfPCA=v2007,dfPredict=v2012,Cor=T,Color='orange')             
w<-pcaLM2(dfPCA=v2012,dfPredict=v2007,Cor=T,Color='orange')
w<-pcaLM2(dfPCA=v2007,dfPredict=v2012,Cor=F,Color='pink')             
w<-pcaLM2(dfPCA=v2012,dfPredict=v2007,Cor=F,Color='pink') 
################### 
################compare predictions by Ecoregion, PCA by region or full dataset; PCA by NLA2007 or NLA2012
##LM2  NTL and PTL
Cor=T
LM2<-c()
for(i in c(1:10)){
windows(10,7.5)
par(mfrow=c(2,2)) 
  b<-as.character(unique(NLA2007$WSA_ECO9))
  b<-c('ALL',b)
  a<-b[i]
  a2007<-paste(a,'2007',sep="")
  a2012<-paste(a,'2012',sep="")
  temp<-ifelse(a=='ALL',assign(a2007,v2007),assign(a2007,subset(v2007,v2007$WSA_ECO9==a)))
  temp<-ifelse(a=='ALL',assign(a2012,v2012),assign(a2012,subset(v2012,v2012$WSA_ECO9==a)))
  w<-pcaLM2(dfPCA=v2007,dfPredict=get(a2012),Cor,Color='orange');legend('topright',c(a,'PCA=All'),,bty='n') 
    LM2<-rbind(LM2,cbind(data.frame(PCA='ALL2007',Predict=a2012),w[[3]]))
  w<-pcaLM2(dfPCA=get(a2007),dfPredict=get(a2012),Cor,Color='orange');legend('topright',c(a,'PCA=EcoR'),,bty='n') 
    LM2<-rbind(LM2,cbind(data.frame(PCA=a2007,Predict=a2012),w[[3]]))
  w<-pcaLM2(dfPCA=v2012,dfPredict=get(a2007),Cor,Color='orange');legend('topright',c(a,'PCA=All'),,bty='n') 
    LM2<-rbind(LM2,cbind(data.frame(PCA='ALL2012',Predict=a2007),w[[3]]))
  w<-pcaLM2(dfPCA=get(a2012),dfPredict=get(a2007),Cor,Color='orange');legend('topright',c(a,'PCA=EcoR'),,bty='n')
    LM2<-rbind(LM2,cbind(data.frame(PCA=a2012,Predict=a2007),w[[3]]))
}
LM2
CloseAll()
##LM3  NTL, PTL, & NPR
LM3<-c()
for(i in c(1:10)){
windows(10,7.5)
par(mfrow=c(2,2)) 
  b<-as.character(unique(NLA2007$WSA_ECO9))
  b<-c('ALL',b)
  a<-b[i]
  a2007<-paste(a,'2007',sep="")
  a2012<-paste(a,'2012',sep="")
  temp<-ifelse(a=='ALL',assign(a2007,v2007),assign(a2007,subset(v2007,v2007$WSA_ECO9==a)))
  temp<-ifelse(a=='ALL',assign(a2012,v2012),assign(a2012,subset(v2012,v2012$WSA_ECO9==a)))
  w<-pcaLM3(dfPCA=v2007,dfPredict=get(a2012),Cor,Color='orange');legend('topright',c(a,'PCA=All'),,bty='n') 
    LM3<-rbind(LM3,cbind(data.frame(PCA='ALL2007',Predict=a2012),w[[3]]))
  w<-pcaLM3(dfPCA=get(a2007),dfPredict=get(a2012),Cor,Color='orange');legend('topright',c(a,'PCA=EcoR'),,bty='n') 
    LM3<-rbind(LM3,cbind(data.frame(PCA=a2007,Predict=a2012),w[[3]]))
  w<-pcaLM3(dfPCA=v2012,dfPredict=get(a2007),Cor,Color='orange');legend('topright',c(a,'PCA=All'),,bty='n') 
    LM3<-rbind(LM3,cbind(data.frame(PCA='ALL2012',Predict=a2007),w[[3]]))
  w<-pcaLM3(dfPCA=get(a2012),dfPredict=get(a2007),Cor,Color='orange');legend('topright',c(a,'PCA=EcoR'),,bty='n')
    LM3<-rbind(LM3,cbind(data.frame(PCA=a2012,Predict=a2007),w[[3]]))
}
LM3
CloseAll()

T2<-LM2[c(-2,-3),1:4]
names(T2)[3:4]<-c('adjRsq_Lm2T','RMSE_Lm2T')
T3<-LM3[c(-2,-3),3:4]
names(T3)<-c('adjRsq_Lm3T','RMSE_Lm3T')
WSA9<-cbind(T2,T3)
write.table(WSA9, file="c:/temp/temp.csv",row.names=F,sep=',')
###########

#Why are predictions so bad for NPL?
windows(10,7.5)
par(mfrow=c(1,2))
WSA9<-'NPL'
with(v2007,plot(lnPTL,lnChla,pch=16,main=paste(WSA9,' shown in red')))
with(v2007[NLA2007$WSA_ECO9==WSA9,],points(lnPTL,lnChla,pch=19,col='red'))
with(v2007,plot(lnNTL,lnChla,pch=16,main=paste(WSA9,' shown in red')))
with(v2007[NLA2007$WSA_ECO9==WSA9,],points(lnNTL,lnChla,pch=19,col='red'))
  mtext(v,side=1,line=4,cex=.7,adj=1)
  
#Why are predictions Good for SAP?
windows(10,7.5)
par(mfrow=c(1,2))
WSA9<-'SAP'
with(v2007,plot(lnPTL,lnChla,pch=16,main=paste(WSA9,' shown in orange')))
with(v2007[NLA2007$WSA_ECO9==WSA9,],points(lnPTL,lnChla,pch=19,col='orange'))
with(v2007,plot(lnNTL,lnChla,pch=16,main=paste(WSA9,' shown in orange')))
with(v2007[NLA2007$WSA_ECO9==WSA9,],points(lnNTL,lnChla,pch=19,col='orange'))
  mtext(v,side=1,line=4,cex=.7,adj=1)


##################

#what happens when we remove  WSA_ECO9!='NPL'

NoNPL2007<-subset(v2007,v2007$WSA_ECO9!='NPL')
NoNPL2012<-subset(v2012,v2012$WSA_ECO9!='NPL')

windows(10,7.5)
par(mfrow=c(2,2)) 
w<-pcaLM3(dfPCA=v2007,dfPredict=v2012,Cor=T,Color='orange') 
w<-pcaLM3(dfPCA=NoNPL2007,dfPredict=NoNPL2007,Cor=T,Color='orange') 
w<-pcaLM3(dfPCA=v2012,dfPredict=v2012,Cor=T,Color='pink') 
w<-pcaLM3(dfPCA=NoNPL2012,dfPredict=NoNPL2007,Cor=T,Color='pink')   
    #w[[4]][order(w[[4]][,1]),]

#########################

fN<-lm(lnChla~lnNTL,data=v2007)
summary(fN)
predChla_fN<-predict(fN,v2012)
plotOE(v2012$lnChla,predChla_fN,'Method: lnChla~lnNTL 2012','green') 

fP<-lm(lnChla~lnPTL,data=v2007)
summary(fP)
predChla_fP<-predict(fP,v2012)
plotOE(v2012$lnChla,predChla_fP,'Method: lnChla~lnPTL 2012','blue') 

fNP<-lm(lnChla~lnPTL+lnNTL,data=v2007)
summary(fNP)
predChla_fNP<-predict(fNP,v2012)
plotOE(v2012$lnChla,predChla_fNP,'Method: lnChla~lnPTL+lnNTL 2012','violet') 

#####
fN<-lm(lnChla~lnNTL,data=NoNPL2007)
summary(fN)
predChla_fN<-predict(fN,NoNPL2012)
plotOE(NoNPL2012$lnChla,predChla_fN,'Method: lnChla~lnNTL 2012','green') 

fP<-lm(lnChla~lnPTL,data=NoNPL2007)
summary(fP)
predChla_fP<-predict(fP,NoNPL2012)
plotOE(NoNPL2012$lnChla,predChla_fP,'Method: lnChla~lnPTL 2012','blue') 

fNP<-lm(lnChla~lnPTL+lnNTL,data=NoNPL2007)
summary(fNP)
predChla_fNP<-predict(fNP,NoNPL2012)
plotOE(NoNPL2012$lnChla,predChla_fNP,'Method: lnChla~lnPTL+lnNTL 2012','violet') 

