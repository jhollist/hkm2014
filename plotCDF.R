#NOTE: we should probably just add these variables to hkm2014Data


#get the hkm2014 data
	load('./data/hkm2014Data.rda')

#get the bioVolume data
	load(url('https://raw.github.com/jhollist/cyanoLakes/master/bryan/cyanoBioVolData.rda'))
	
#merge sumBioV to hkm2014:  Note this is the estimated cyano bioVolume for the lake-used to define bvCat
	hkm2014Data<-merge(hkm2014Data,bioV[,c('NLA_ID','sumBioV')],by='NLA_ID',all=TRUE) 
	
	
#rename TS_CHLA to TS_CHLA_4
	names(hkm2014Data)[names(hkm2014Data)=="TS_CHLA"]<-'TS_CHLA_4'
	table(hkm2014Data$TS_CHLA_4,useNA='ifany') #note there are five missing values

#create other TS categories	
	hkm2014Data$TS_CHLA_3<-hkm2014Data$TS_CHLA_4
		levels(hkm2014Data$TS_CHLA_3)<-c("Oligo","Meso/Eu","Meso/Eu","Hyper")
		table(hkm2014Data$TS_CHLA_3,useNA='ifany')
	hkm2014Data$TS_CHLA_2<-hkm2014Data$TS_CHLA_4
		levels(hkm2014Data$TS_CHLA_2)<-c("Oligo/Meso","Oligo/Meso","Eu/Hyper","Eu/Hyper")
		table(hkm2014Data$TS_CHLA_2,useNA='ifany')
  

################## function to draw CDF figures
#This functions produces CDF plots from the hkm2014Data
	#need to input
		#catVar: the categorical Variable such as-'bvCat', 'TS_CHLA_2', 'TS_CHLA_3', 'TS_CHLA_4' 
		#contVar: the continuous Variable such as-'sumBioV','CHLA', 'NTL', 'PTL', etc.
		#Color: colors for CDF plots-should equal # of categories in catVar

	
plotCDF<-function(catVar='bvCat',contVar='CHLA',Color=c('green','orange','red')) { 
                                                 
	options(scipen=5) #tell r not to use scientific notation on axis labels
	
	X<-hkm2014Data[,contVar]	#vector with the cont data
	if(min(X,na.rm=T)==0) X<-X+1  #this avoids log(X)=-Inf which causes axis problems.
	cat<-hkm2014Data[,catVar]
	Cats<-levels(cat) #list of categories
			#make an empty plot for the CDF
			plot(NA,xlim=c(min(X,na.rm=TRUE),max(X,na.rm=TRUE)),ylim=c(0,1),xlab=contVar,ylab='Percent',log='x',
					 main=paste('Cummulative Distribution Function for Category = ',catVar))
				abline(h=.5,col='blue')
			legend('topleft',rev(Cats),pch=16,col=rev(Color),bty='n')
	#loop to plot all levels of cat
			for (i in c(1:length(Cats))){
			keep<-cat==Cats[i] & !is.na(cat)  #select cat variable for level=i and is.na=F
			plot(ecdf(X[keep]),col=Color[i],add=T)
		}
}
	################## end function to draw CDF figures



#examples
	plotCDF()  #defaults: cat=hkm2014Data$bvCat,cont='CHLA',Color=c('green','orange','red','pink')
	plotCDF('TS_CHLA_3') #change cat
	plotCDF(cont='NTL') #change cont
	plotCDF('TS_CHLA_2','sumBioV',c('blue','orange')) # change all
	

############eof
