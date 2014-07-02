v<-'varSelRF.r'


#http://cran.r-project.org/web/packages/varSelRF/varSelRF.pdf

#install packages
libs<-c("varSelRF") #list of packages to load
installLoad<-function(pck)#user defined function
{
	if(!pck%in%installed.packages()){install.packages(pck,repos="http://rweb.quant.ku.edu/cran/")}
	require(pck, character.only = TRUE)
}
lapply(libs,function(x) installLoad(x))  #Load/Install require packages

####################Load the hkm2014Data
	#Data Definitions:
		browseURL('https://github.com/jhollist/hkm2014/blob/master/data/hkm2014Data.md')
	#Get the hkm2014Data
		load(url('https://raw.github.com/jhollist/hkm2014/master/data/hkm2014Data.rda'))



#select variables for TS_CHLA RF
	#complete cases
		keep<-complete.cases(hkm2014Data)
	#all predictors
		pChla_all<-hkm2014Data[keep,-c(1,2,3,6,23,42,59,78,95,114,131,148,159,209,210,211)]
	#GIS predictors only
		pChla_gis<-hkm2014Data[keep,-c(1,2,3,6,23,42,59,78,95,114,131,148,154,159:194,209:211)]
	#Identify class variable
		Chla<-hkm2014Data[keep,'TS_CHLA']

#use varSelRF to prune the predictors	
				NTREE<-10000
				NTREEi<-5000
				FRAC<-.1
   #TS_CHLA all variables
				vsChla_all<- varSelRF(pChla_all, Chla, ntree=NTREE, ntreeIterat=NTREEi,vars.drop.frac=FRAC)
					save(vsChla_all,file='./data/vsChla_all.rda') 
					vsChla_all  #results
					#plot(vsChla_all) #plots
		
#TS_CHLA GIS variables
				vsChla_gis<- varSelRF(pChla_gis, Chla, ntree=NTREE, ntreeIterat=NTREEi,vars.drop.frac=FRAC)
					save(vsChla_gis,file='./data/vsChla_gis.rda') 
					vsChla_gis  #results
					#plot(vsChla_gis) #plots

#select variables for bvCat RF
	#complete cases
		keep<-complete.cases(hkm2014Data)
	#all predictors
		pbvCat_all<-hkm2014Data[keep,-c(1,2,3,6,23,42,59,78,95,114,131,148,209,210,211)]
	#GIS predictors only
		pbvCat_gis<-hkm2014Data[keep,-c(1,2,3,6,23,42,59,78,95,114,131,148,154,160:194,209:211)]
	#Identify class variable
		bvCat<-hkm2014Data[keep,'bvCat']

#use varSelRF to prune the predictors	
				NTREE<-10000
				NTREEi<-5000
				FRAC<-.1
#bvCat all variables
	vsbvCat_all<- varSelRF(pbvCat_all, bvCat, ntree=NTREE, ntreeIterat=NTREEi,vars.drop.frac=FRAC)
		save(vsbvCat_all,file='./data/vsbvCat_all.rda') 
		vsbvCat_all  #results
		#plot(vsbvCat_all) #plots

#bvCat GIS variables
	vsbvCat_gis<- varSelRF(pbvCat_gis, bvCat, ntree=NTREE, ntreeIterat=NTREEi,vars.drop.frac=FRAC)
		save(vsbvCat_gis,file='./data/vsbvCat_gis.rda') 
		vsbvCat_gis  #results
		#plot(vsbvCat_gis) #plots


######save the data
save(vsChla_all,vsChla_gis,vsbvCat_all,vsbvCat_gis,file='./data/varSelRF.rda') 


				
				