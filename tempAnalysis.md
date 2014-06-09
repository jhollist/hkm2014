---
title: "Analysis for Hollister, Kreakie, Milstead"
author: "Jeff Hollister, Betty Kreakie, Bryan Milstead"
date: "Monday, April 28, 2014"
output: pdf_document
---




## Main Question: Given that we have a unique combination of novel data, increased computational facilities, and an expanded geographic scope, what can we add to the classic understanding of the processes that are predictive of chlorophyll *a* and trophic state in lakes. 

### Initital Predictor variable selection 
We start by selecting the predictor variables. *A priori* we made the following decisions:

1.  There are three water temperature measure based on the profile data for the first 2m of the water column, the mean (TmeanW), the min (TminW) and the max (TmaxW).  We decided to use TmeanW arbitrarily.

2.  There are four estimates of growing degree days:  DDs40, DDs45, DDs50, and DDs55.  The number refers to the reference temperature used in the calculation.  It really shouldn't matter for our purposes so we arbitrarily chose DD45.

3. The NLCD landcover was calculated as a percent and as total area in buffers of 300m, 1500m, and 3000m.  A fourth buffer scaled to the maximum inlake distance was also used.  We decided to use the percent landcover in the 300m (homeowner) and the 3000m buffers for the analysis.  *ANALYSIS*- as a check look at centroid distance matrix.

4. Turbidity and Secchi provide similar information and either one can be estimated from the other.  Secchi is not accurate in lakes that are clear to the bottom so we choose to use Turbidity only.

5.  We also decided to add a new variable for the NP ratio.  This is just a straight weight ratio and not the molecular weight ratio.  

6.  If the WSA_ECO9 is a categorical variable with the names of the nine "Wadeable Stream Assessment" aggregated ecoregions.  If this variable is selected it will need to be converted to dummy variable for the linear analysis.  A new data.frame call "WSA9dummies" is created for this.

This give us two data.frames:

1.  "Pall" contains the predictor variables (including the categorical variable "WSA_ECO9")
2. "WSA9dummies" contains the ecoregion dummy variables.  NOTE: to use this with Pall you need to remove Pall$WSA_ECO9.  For example a data.frame with response variables and the WSA dummies is created with the following code:  Pall1<-data.frame(Pall[,-grep("WSA_ECO9",names(Pall))],WSA9dummies)




### Initital GIS Predictor variable selection 
The Predictor variables in Pall contains a mixture of variables that can be assessed with GIS and  measured water quality variables.  To see if the GIS variables alone can be used we create a new data.frame with just the GIS predictors.

1.  This creates one df named "Pgis" that includes the location, lake morphmetrics, growing degreee days (DDs45), and the NLCD percents in buffers of 300m and 3000m.
2.  You can subset this to use buffers of 300m only with this code: Pgis300<-Pgis[,-grep("3000m",names(Pgis))]   
3.  You can subset this to use buffers of 3000m only with this code: Pgis3k<-Pgis[,-grep("300m",names(Pgis))]





### response variable selection 
For the Random Forest analysis we create the  categorical response variable "chlaCat".  This variable has three categories:

1. Low=lakes with Chla concentrations in the first quartile of the Chla distribution
2. Med=lakes with Chla concentrations in the second and third quartiles of the Chla distribution
3. High=lakes with Chla concentrations in the fourth quartile of the Chla distribution

```
## chlaCat
##  LOW  MED HIGH <NA> 
##  286  570  287    5
```


