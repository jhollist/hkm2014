################################################################
#  HollisterMilsteadKreakieMoore.R                             #
#  Code used in TN/TP/Chl a Manuscript                         #
#  Written by W.B. Milstead, B. J. Kreakie, and J.W. Hollister #  
#  July 2013                                                   #
################################################################                

################################################################
# Get datasets                                                 #
################################################################
setwd("L:\\Public\\SSWR NEXUS-Concept\\NPRatioManuscript")            
nlaData<-read.csv("NLAdata20130812.csv")
NLA2007<-nlaData[nlaData$Year==2007,]
NLA2012<-nlaData[nlaData$Year==2012,]
################################################################
# Figure 1. TN/TP Scatterplot                                  #
################################################################
tiff("Figure1.tif",units="in",height=11.5,width=4.25,pointsize=8,res=600,compression="lzw")
par(mfrow=c(2,1))
with(NLA2007, plot(log(NTL), log(PTL), main = "2007 National Lake Assessment Nitrogen and Phosphorus",
                  xlab = "ln(Total Nitrogen)",
                  ylab = "ln(Total Phosphorus)", pch = 19, xlim = c(0,10),
                  ylim = c(0,10))) 
with(NLA2007,text(2.5,9,paste("Pearson Correlation = ",round(cor(log(NTL),log(PTL)),2))))  
with(NLA2012, plot(log(NTL), log(PTL),main = "2012 National Lake Assessment Nitrogen and Phosphorus",
                  xlab = "ln(Total Nitrogen)",
                  ylab = "ln(Total Phosphorus)", pch = 19, xlim = c(0,10),
                  ylim = c(0,10))) 
with(NLA2012,text(2.5,9,paste("Pearson Correlation = ",round(cor(log(NTL),log(PTL)),2))))                 
par(mfrow=c(1,1))
dev.off()

################################################################
# Table 2. NLA Summary Stats                                   #
# This does not recreate the table exactly, but the stats      #
# should match                                                 #
################################################################
library(xtable)
sumStats<-function(x)
{
   n<-length(na.omit(x))
   mn<-mean(x,na.rm=T)
   std<-sd(x,na.rm=T)
   return(data.frame(n,mn,std))
}
by2007N<-by(NLA2007$NTL,list(NLA2007$WSA_ECO9),sumStats)
by2007P<-by(NLA2007$PTL,list(NLA2007$WSA_ECO9),sumStats)
by2007CHLA<-by(NLA2007$CHLA,list(NLA2007$WSA_ECO9),sumStats)
by2012N<-by(NLA2012$NTL,list(NLA2012$WSA_ECO9),sumStats)
by2012P<-by(NLA2012$PTL,list(NLA2012$WSA_ECO9),sumStats)
by2012CHLA<-by(NLA2012$CHLA,list(NLA2012$WSA_ECO9),sumStats)
df2007N<-data.frame(names(by2012N), matrix(unlist(by2007N), nrow=length(by2007N), byrow=T))
df2007P<-data.frame(names(by2012N), matrix(unlist(by2007P), nrow=length(by2007P), byrow=T))
df2007CHLA<-data.frame(names(by2012N), matrix(unlist(by2007CHLA), nrow=length(by2007CHLA), byrow=T))
df2012N<-data.frame(names(by2012N), matrix(unlist(by2012N), nrow=length(by2012N), byrow=T))
df2012P<-data.frame(names(by2012N), matrix(unlist(by2012P), nrow=length(by2012P), byrow=T))
df2012CHLA<-data.frame(names(by2012N), matrix(unlist(by2012CHLA), nrow=length(by2012CHLA), byrow=T))
names(df2007N)<-c("Ecoregion","N","Mean","Std.Dev")
names(df2007P)<-c("Ecoregion","N","Mean","Std.Dev")
names(df2007CHLA)<-c("Ecoregion","N","Mean","Std.Dev")
names(df2012N)<-c("Ecoregion","N","Mean","Std.Dev")
names(df2012P)<-c("Ecoregion","N","Mean","Std.Dev")
names(df2012CHLA)<-c("Ecoregion","N","Mean","Std.Dev")
write(print(xtable(df2007N,caption="Nitrogen - 2007"),type="html",include.rownames=F),"Table2.html",append=F)
write(print(xtable(df2007P,caption="Phosphorus - 2007"),type="html",include.rownames=F),"Table2.html",append=T)
write(print(xtable(df2007CHLA,caption="Chlorphyll a - 2007"),type="html",include.rownames=F),"Table2.html",append=T)
write(print(xtable(df2012N,caption="Nitrogen - 2012"),type="html",include.rownames=F),"Table2.html",append=T)
write(print(xtable(df2012P,caption="Phosphorus - 2012"),type="html",include.rownames=F),"Table2.html",append=T)
write(print(xtable(df2012CHLA,caption="Chlorphyll a - 2012"),type="html",include.rownames=F),"Table2.html",append=T)



