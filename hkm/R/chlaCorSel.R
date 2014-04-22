#' Function to calculate and select variables based on chl a 
#' 
#' This function calculates the pairwise correlation between chlorophyll a and 
#' all other variables and returns only those that are above a specified treshold
#' 
#' @param hkmData dataframe of initial data to be considered
#' @param threshold The correlation coefficient thrshold to be considered for 
#'                  inclusion.  The defualt value is a correlation coefficient
#'                  that equals 5% of varience expalaine (i.e. sqrt(0.05)).
#' @export
chlaCorSel<-function(hkmData,threshold=0.2236){
	
}