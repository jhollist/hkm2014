---
title: "Analysis for Hollister, Kreakie, Milstead"
author: "Jeff Hollister, Betty Kreakie, Bryan Milstead"
date: "Monday, April 28, 2014"
output: pdf_document
---




## Main Question: Given that we have a unique combination of novel data, increased computational facilities, and an expanded geographic scope, what can we add to the classic understanding of the processes that are predictive of chlorophyll *a* and trophic state in lakes. 

### Initital variable selection (Jeff)
1.mean temp
2.DD45 
3.Select scale(s) - local - 300m and regional - 3000m
 *ANALYSIS*- as a check look at centroid distance matrix 
4.Turbidity, not secchi - because turb is an instrument measure and not limited by depth of lake.  If need be Turb could be converted to and estimated secchi.







### Analysis 1. Compare classic linear models to random forest models?

1.Chl a ~ TP (converted to TS)
2.Chl a ~ TN (converted to TS)
3.Chl a ~ TN + TP (converted to TS)
4.Chl a ~ Linear Mod with varSelRF variables (converted to TS)

use varSelRF to select the variables for linear model 4













