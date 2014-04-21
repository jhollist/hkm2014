v<-'HMK2014data.r'

#merge data from lakeNLCD and bioV (cayanBioVolData) for data analysis; select fields to keep; output to CSV file
	#get lakeNLCD data
		#data definitions
			browseURL('https://github.com/jhollist/cyanoLakes/blob/master/bryan/calcNLCD_ByLakeBuffer.md')
					https://raw.githubusercontent.com/jhollist/cyanoLakes/master/bryan/calcNLCD_ByLakeBuffer.md
		#load data
			load(url('https://github.com/jhollist/cyanoLakes/raw/master/bryan/calcNLCD_ByLakeBuffer.RDA'))

		#get bioV data
			#data definitions
				browseURL('https://github.com/jhollist/cyanoLakes/blob/master/bryan/cyanoBioVolData.md')
			#load data
				load(url('https://raw.github.com/jhollist/cyanoLakes/master/bryan/cyanoBioVolData.rda'))

#############
unique(lakeNLCD$BufType)
unique(lakeNLCD$BufWidthM[lakeNLCD$BufType=='fixed'])
  a300a<-lakeNLCD[lakeNLCD$BufWidthM==300,]     #n=1162
	a300<-lakeNLCD[lakeNLCD$BufWidthM==300 & lakeNLCD$BufType=='fixed',]     #n=1156
	a1500<-lakeNLCD[lakeNLCD$BufWidthM==1500,]   #n=1156
	a3000<-lakeNLCD[lakeNLCD$BufWidthM==3000,]   #n=1156

		b<-data.frame(table(a300$NLA_ID))
		b<-b[b$Freq>1,]

lakeNLCD[lakeNLCD$NLA_ID%in%b[,1],1:8]




nrow(bioV)
nrow(lakeNLCD)

a<-lakeNLCD[lakeNLCD$BufWidthM==300,]
nrow(a)
names(a)

length(unique(a$NLA_ID))

length(unique(a$NLA_ID))
b<-table(a$NLA_ID)
head(b)
head(a$NLA_ID)
str(a)
