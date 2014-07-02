#' iterVarSelRF
#' 
#' This function iterates the `varselRF` function to capture variability in the
#' possibly selected variables.  This process forms the basis of the analysis 
#' conducted in Hollister, Kreakie, and Milsted (2014).  We us the  proportion 
#' of iterations that a given variable is selected as a variable selection 
#' metric. A parallel implementation is possible using `snow`.
#' 
#' @param indVar independent variables
#' @param depVar dependent variable
#' @param numRun number of iterations.  default is 10
#' @param numCore number of cores to split runs across. defualt is 1
#' @param outStr string to append to output files. Defaults to a tmp file
#' @param ... variables from varselRF  

iterVarSelRF<-function(indVar,depVar,numRun=10,numCore=1,outStr=tempfile(),...){
	
	#Add parallell
	#Add saving intermediate
	#Add summary
	#Add return list of output all selected, summary, and params
	Out<-vector("list",numRun)
	for(i in 1:numRun){
		rfGIS<-varSelRF(indVar,depVar,...)
		Out[[i]]<-rfGIS$selected.vars
	
		lapply(Out,write,"gis_selected_variables_ts.csv",append=T,ncolumns=1000)
		print(i)
	}
	
}