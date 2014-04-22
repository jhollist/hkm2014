#' Function to calculate and select variables based on chl a 
#' 
#' This function calculates the pairwise correlation between chlorophyll a and 
#' all other variables and returns only those that are above a specified treshold
#' 
#' @param hkmData dataframe of initial data to be considered
#' @param corVar a vector of names of variables to include in corelation matrix
#' @param threshold The correlation coefficient threshold to be considered for 
#'                  inclusion.  The defualt value is a correlation coefficient
#'                  that equals 5% of varience expalaine (i.e. sqrt(0.05)).
#' @param log Boolean to transfomr the data or not.  log1p is used.
#' @return A dataframe with all variables to meet the correlation threshold
#' @export
#' @examples
#' data(hkm2014Data)
#' WQ.var<-c("AlbersX","AlbersY","LakeArea","LakePerim","ShoreDevel","BASINAREA","DEPTHMAX","ELEV_PT",
#' 					  "CHLA","DO2_2M","PH_FIELD","COND","ANC","TURB","TOC","DOC","NH4","NO3_NO2","NTL","PTL","CL",
#' 					  "NO3","SO4","CA","MG","Na","K","COLOR","SIO2","H","OH","NH4ION","CATSUM","ANSUM2","ANDEF2","SOBC",
#' 					  "BALANCE2","ORGION","CONCAL2","CONDHO2","SECMEAN","TminW","TmaxW","TmeanW","DDs40","DDs45","DDs50",
#' 					  "DDs55","MaxLength","MaxWidth","MeanWidth","FetchN","FetchNE","FetchE","FetchSE","MaxDepthCorrect",
#' 					  "VolumeCorrect","MeanDepthCorrect")
#' chlaCorSel(hkm2014Data,WQ.var)					  

chlaCorSel<-function(hkmData,corVar,threshold=0.2236,log=T){
	meetThresh<-c()
	#adjusts variables with negative values by adding the absolute value of the min
	for(name in as.character(names(hkmData[,corVar]))){
		if(min(hkmData[,name],na.rm=T)<0){
			hkmData[,name]<-hkmData[,name]+abs(min(hkmData[,name],na.rm=T))
		}
	
		if(log){
			if(cor(log1p(hkmData[,name]),log1p(hkmData[,"CHLA"]),use="pairwise.complete.obs")>=threshold){
				meetThresh<-c(meetThresh,name)
			}
		} else {
			if(cor(hkmData[,name],hkmData[,"CHLA"],use="pairwise.complete.obs")>=threshold){
				meetThresh<-c(meetThresh,name)
			}
		}
	}
	return(hkmData[,meetThresh])
}