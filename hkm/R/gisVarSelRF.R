#' Function to run GIS variables through varSelRF
#' @export
#' @examples
#' data(hkm2014Data)
#' gis_var<-names(hkm2014Data)[c(4:152,154,194:210)]
#' gis_var<-gis_var[-grep("NA",gis_var)]
#' gisData<-hkm2014Data[,gis_var][complete.cases(hkm2014Data[,gis_var]),]
#' gisvs<-gisVarSelRF(gisData[,1:164],gisData[,167],ntree = 100, ntreeIterat = 50,vars.drop.frac = 0.1)
#' gisvs
#' plot(gisvs)
gisVarSelRF<-function(gisData,...){
  return(varSelRF(gisData,...))
}