v<-'HMK2014data.r'

#merge data from lakeNLCD and bioV (cayanBioVolData) for data analysis; select fields to keep; output to CSV file
	#get lakeNLCD data
		#data definitions
			browseURL('https://github.com/jhollist/cyanoLakes/blob/master/bryan/calcNLCD_ByLakeBuffer.md')

		#load data -df name is "lakeNLCD"
			load(url('https://github.com/jhollist/cyanoLakes/raw/master/bryan/calcNLCD_ByLakeBuffer.RDA'))

		#get bioV data
			#data definitions
				browseURL('https://github.com/jhollist/cyanoLakes/blob/master/bryan/cyanoBioVolData.md')
			#load data
				load(url('https://raw.github.com/jhollist/cyanoLakes/master/bryan/cyanoBioVolData.rda'))

#############
#separate lakeNLCD by width and type.  Buffer type can be 'MaxDist' (buffer width = max in lake distance) or
																			 #'fixed' (Width=300, 1500 or 3000m)

	#list of Varnames for lakeNLCD
			VarNames<-c('NLA_ID','Comid','BufWidthM','PercentImperv','ImpervAreaKm2','BufferAreaKm2','BufferAreaKm2Adj',
						'PercentNA','NLCD_NA_Km2','WaterKm2','IceSnowKm2','DevOpenKm2','DevLowKm2','DevMedKm2',
						'DevHighKm2','BarrenKm2','DeciduousKm2','EvergreenKm2','MixedForKm2','ShrubKm2','GrassKm2',
						'PastureKm2','CropsKm2','WoodyWetKm2','HerbWetKm2','NLCD_NA_Per','WaterPer','IceSnowPer',
						'DevOpenPer','DevLowPer','DevMedPer','DevHighPer','BarrenPer','DeciduousPer','EvergreenPer',
						'MixedForPer','ShrubPer','GrassPer','PasturePer','CropsPer','WoodyWetPer','HerbWetPer')
		#for fixed buffers keep all varnames except c(3,6,7,9)
		#for MaxDist buffers keep all varnames except c(6,7,9)
	#make a df for each buffer type/width
		aMaxDist<-lakeNLCD[lakeNLCD$BufType=='MaxDist',VarNames[-c(6,7,9)]]     #n=1156
			names(aMaxDist)[4:ncol(aMaxDist)]<-paste(names(aMaxDist)[4:ncol(aMaxDist)],'_MaxDist',sep='') #rename variables
				names(aMaxDist)[3]<-'MaxDist'
		a300<-lakeNLCD[lakeNLCD$BufWidthM==300 & lakeNLCD$BufType=='fixed',VarNames[-c(3,6,7,9)]]     #n=1156
			names(a300)[3:ncol(a300)]<-paste(names(a300)[3:ncol(a300)],'_300m',sep='') #rename variables
		a1500<-lakeNLCD[lakeNLCD$BufWidthM==1500,VarNames[-c(3,6,7,9)]]   #n=1156
			names(a1500)[3:ncol(a1500)]<-paste(names(a1500)[3:ncol(a1500)],'_1500m',sep='') #rename variables
		a3000<-lakeNLCD[lakeNLCD$BufWidthM==3000,VarNames[-c(3,6,7,9)]]   #n=1156
			names(a3000)[3:ncol(a3000)]<-paste(names(a3000)[3:ncol(a3000)],'_3000m',sep='') #rename variables


	#merge the new buffer dfs
		a<-merge(aMaxDist,a300,by=c('NLA_ID','Comid'))
		a<-merge(a,a1500,by=c('NLA_ID','Comid'))
		a<-merge(a,a3000,by=c('NLA_ID','Comid'))

	#Choose bioV fields to keep
		#list of Varnames for bioV
			VarNames1<-c('NLA_ID','sumBioV','bvCat','AlbersX','AlbersY','LakeArea','LakePerim',
									'ShoreDevel','DATE_COL','WSA_ECO9','BASINAREA','DEPTHMAX','ELEV_PT',
									'CHLA','DO2_2M','PH_FIELD','COND','ANC','TURB','TOC','DOC','NH4','NO3_NO2',
									'NTL','PTL','CL','NO3','SO4','CA','MG','Na','K','COLOR','SIO2','H','OH',
									'NH4ION','CATSUM','ANSUM2','ANDEF2','SOBC','BALANCE2','ORGION','CONCAL2',
									'CONDHO2','SECMEAN','TminW','TmaxW','TmeanW','DDs40','DDs45','DDs50','DDs55',
									'MaxLength','MaxWidth','MeanWidth','FetchN','FetchNE','FetchE','FetchSE',
									'MaxDepthCorrect','VolumeCorrect','MeanDepthCorrect','TS_NTL','TS_PTL',
									'TS_CHLA','Microcystin_ugl','WHO_Category')
			keep<-VarNames1[-c(2,67,68)]
	#merge bioV and the NLCD data
		hkm2014Data<-merge(a,bioV[,keep],all.x=T)

##################save the data
save(hkm2014Data,file='./data/hkm2014Data.rda')  


####################Load the hkm2014Data
#Data Definitions:  
browseURL('https://github.com/jhollist/hkm2014/blob/master/data/hkm2014Data.md')
#Get the hkm2014Data
load(url('https://raw.github.com/jhollist/hkm2014/master/data/hkm2014Data.rda'))


