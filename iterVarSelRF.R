#' iterVarSelRF
#' 
#' This function iterates the `varselRF` function to capture variability in the
#' possibly selected variables.  This process forms the basis of the analysis 
#' conducted in Hollister, Kreakie, and Milsted (2014).  We us the  proportion 
#' of iterations that a given variable is selected as a variable selection 
#' metric. A parallel implementation is possible using `snowfall`.  User only need 
#' specify the number of cores to use.  Function relies on knitr,snowfall,parallel,
#' and varSelRF
#' 
#' @param indVar independent variables
#' @param depVar dependent variable
#' @param numRun number of iterations.  default is 10
#' @param numCore number of cores to split runs across. defualt is 1
#' @param outStr string to append to output files. Defaults to a tmp file
#' @param ... variables from varselRF  
#' 
#' @examples
#' system.time(iterVarSelRF(Pgis[keep,],TS_CHLA[keep],10,ntree=10,ntreeIterat=5,
#' vars.drop.frac=NULL,vars.drop.num=1))
#' system.time(iterVarSelRF(Pgis[keep,],TS_CHLA[keep],10,4,ntree=10,ntreeIterat=5,
#' vars.drop.frac=NULL,vars.drop.num=1))
#' @export

iterVarSelRF<-function(indVar,depVar,numRun=10,numCore=1,outStr=tempfile(tmpdir=getwd()),
											 ntree=10,ntreeIterat=5,vars.drop.frac=NULL,vars.drop.num=1){
	
	#validate number of cores
	if(numCore>parallel::detectCores()){
		return(stop(paste("Your system only has",detectCores(),"cores available")))
	}
	
	#Set up single core/sequential
	if(numCore==1){
		sfInit(parallel=FALSE)
	}
	
	#Set up multiple cores/parallel
	if(numCore>1){
		sfInit(parallel=TRUE,cpus=numCore)
		sfExport(list=c("indVar","depVar","ntree","ntreeIterat","vars.drop.frac",
										"vars.drop.num"), local=TRUE)
		sfLibrary(varSelRF)
	}
	
	#varSelRF Function to pass to sfLapply
	sfVarSelRF<-function(x){
		outVarSel<-varSelRF(indVar,depVar,ntree=ntree,ntreeIterat=ntreeIterat,
												vars.drop.frac=vars.drop.frac,
												vars.drop.num=vars.drop.num)
  	return(outVarSel$selected.vars)
	}
	
	#Run it
	result <- sfLapply(1:numRun,sfVarSelRF)
	
	#summarize variables
	summDF<-data.frame()
	uniqueVar<-unique(unlist(result))
	for(i in uniqueVar){
		summDF<-rbind(summDF,data.frame(Variable=i,Percent=sum(unlist(result)%in%i)/numRun))
	}
	summDF<-summDF[order(summDF$Percent,decreasing=T),]
	write(kable(summDF),paste(outStr,"_variable_summary.md",sep=""))
	#Add return list of output all selected, summary, and params
	lapply(result,write,paste(outStr,"_selected_variables_ts.csv",sep=""),append=T,ncolumns=1000)
	sfStop()
  return(result)
}