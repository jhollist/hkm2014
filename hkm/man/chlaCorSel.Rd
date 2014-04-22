\name{chlaCorSel}
\alias{chlaCorSel}
\title{Function to calculate and select variables based on chl a}
\usage{
chlaCorSel(hkmData, threshold = 0.2236)
}
\arguments{
  \item{hkmData}{dataframe of initial data to be
  considered}

  \item{threshold}{The correlation coefficient thrshold to
  be considered for inclusion.  The defualt value is a
  correlation coefficient that equals 5% of varience
  expalaine (i.e. sqrt(0.05)).}
}
\description{
This function calculates the pairwise correlation between
chlorophyll a and all other variables and returns only
those that are above a specified treshold
}

