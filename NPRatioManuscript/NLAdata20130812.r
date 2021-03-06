v<-'NLAdata20130812.r'
# get the NLA2007 data
require(RODBC)   #Package RODBC must be installed
con <- odbcConnectAccess("L:/Public/Milstead_Lakes/WaterbodyDatabase/WaterbodyDatabase.mdb")
NLA2007 <- sqlQuery(con, "
SELECT tblNLA_WaterQualityData.SITE_ID, tblNLA_WaterQualityData.NTL, tblNLA_WaterQualityData.PTL, tblNLA_WaterQualityData.CHLA, NLA2007Sites_DesignInfo.WSA_ECO9, NLA2007Sites_DesignInfo.ALBERS_X, NLA2007Sites_DesignInfo.ALBERS_Y
FROM tblNLA_WaterQualityData INNER JOIN NLA2007Sites_DesignInfo ON (tblNLA_WaterQualityData.VISIT_NO = NLA2007Sites_DesignInfo.VISIT_NO) AND (tblNLA_WaterQualityData.SITE_ID = NLA2007Sites_DesignInfo.SITE_ID);
")
close(con)
NLA2007$Year<-2007  #Add year
str(NLA2007) 

#get the NLA2012 data
con <- odbcConnectAccess("L:/Public/Milstead_Lakes/NLA_2012/NLA2012.mdb")
NLA2012 <- sqlQuery(con, "
SELECT NLA2012_TN_TP_CHLA.SITE_ID, NLA2012_TN_TP_CHLA.NTL, NLA2012_TN_TP_CHLA.PTL, NLA2012_TN_TP_CHLA.CHLA, Nla_siteinfo_all_20130709.WSA_ECO9, Nla_siteinfo_all_20130709.X_ALBERS AS ALBERS_X, Nla_siteinfo_all_20130709.Y_ALBERS AS ALBERS_Y
FROM NLA2012_TN_TP_CHLA LEFT JOIN Nla_siteinfo_all_20130709 ON (NLA2012_TN_TP_CHLA.SITE_ID = Nla_siteinfo_all_20130709.SITE_ID) AND (NLA2012_TN_TP_CHLA.VISIT_NO = Nla_siteinfo_all_20130709.VISIT_NO)
WHERE (((NLA2012_TN_TP_CHLA.VISIT_NO)=1) AND ((Nla_siteinfo_all_20130709.ST_NLA2012)<>'HI'));
")
close(con)
NLA2012$Year<-2012 #Add year
str(NLA2012)


#NTL & PTL precision different between years.  2007 all NTL & PTL are integer values and 2012 has some decimal values
#for consistency round NLA2012$NTL & NLA2012$PTL to integer values

NLA2012$NTL<-round(NLA2012$NTL)
NLA2012$PTL<-round(NLA2012$PTL)

#combine NLA2007 and NLA2012 into a single dataset
NLA<-rbind(NLA2007,NLA2012)

#write data to csv file
write.table(NLA, file='L:/Public/SSWR NEXUS-Concept/NPRatioManuscript/NLAdata20130812.csv',row.names=F,sep=',')
#NLA<- read.csv('L:/Public/SSWR NEXUS-Concept/NPRatioManuscript/NLAdata20130812.csv')

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
  
############eof