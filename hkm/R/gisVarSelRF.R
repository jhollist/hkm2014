#' Function to run GIS variables through varSelRF
#' @export
#' @examples
#' data(hkm2014Data)
#' gis_var<-names(hkm2014Data)[c(4:153,155,195:211)]
#' gis_var<-gis_var[-grep("NA",gis_var)]
#' gisData<-hkm2014Data[,gis_var][complete.cases(hkm2014Data[,gis_var]),]
#' twoCat<-as.character(gisData[,160])
#' twoCat[twoCat=="Oligo"]<-"Low Trophic"
#' twoCat[twoCat=="Meso"]<-"Low Trophic"
#' twoCat[twoCat=="Eu"]<-"High Trophic"
#' twoCat[twoCat=="Hyper"]<-"High Trophic"
#' twoCat<-factor(twoCat,levels=c("Low Trophic","High Trophic"),ordered=T)
#' gisvs<-gisVarSelRF(gisData[,c(1:136,138:157)],gisData[,160],ntree = 10000, ntreeIterat = 5000,vars.drop.frac = 0.2)
#' gisvs
#' plot(gisvs)
#' gisvs2<-gisVarSelRF(gisData[,c(1:136,138:157)],twoCat,ntree = 10000, ntreeIterat = 5000,vars.drop.frac = 0.2)
#' gisvs2
#' plot(gisvs2)


gisVarSelRF<-function(gisData,...){
  return(varSelRF(gisData,...))
}