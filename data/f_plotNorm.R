################Transform data for analysis
#function to test for normality and skewness
testNorm<-function(x,Var){ 
	#install/load packages
	if (!"moments" %in% installed.packages()) install.packages("moments")
	require(moments)
	if (!"nortest" %in% installed.packages()) install.packages("nortest")
	require(nortest)
	#eliminate missing values
	x<-subset(x,!is.na(x) & x!=Inf & x!=-Inf)
	#sample size
	N<-length(x)  
	#Pearson Test of Normality
	P<-tryCatch(pearson.test(x),error = function(e) NA)  
	P<-round(P$p.value,3)
	P[P==0]<-.001
	#Angostino Test of Skewness
	S<-tryCatch(agostino.test(x),error = function(e) NA)
	S<-round(S$p.value,3)
	S[S==0]<-.001
	#Plots with test of Normality and Skewness
	hist(x,main=Var)
	qqnorm(x,main=paste("Obs =",N,"Normality =",P,"Skewness =",S))  
	#results  
	return(data.frame(N=N,Norm=P,Skew=S))
}

#function to try various transformation and test for normality
plotNorm<-function(df,Variable){
	par(mfrow=c(3,2)) 
	testNorm(df[,Variable],Variable) 
	testNorm(log(df[,Variable]),paste('log',Variable,sep='')) 
	testNorm(log1p(df[,Variable]),paste('log1p',Variable,sep='')) 
	testNorm(log(log(df[,Variable])),paste('loglog',Variable,sep='')) 
	testNorm(sqrt(df[,Variable]),paste('sqrt',Variable,sep='')) 
	testNorm(asin(sqrt(df[,Variable])),paste('asin',Variable,sep='')) 
}

plotNorm(hkm2014Data,'K')

plotNorm(hkm2014Data,'EvergreenPer_3000m')

plotNorm(hkm2014Data,'NPratio')

