hkm2014Data.R Data Defintions
========================================================
**Last Update=April 21, 2014**
***************

**This data set contains one data.frame "hkm2014"

************
  #Data Definitions:
  
    browseURL('https://github.com/jhollist/hkm2014/blob/master/data/hkm2014Data.md')
************
The data can be loaded into R with the following code:
************
  #Get the Data
  
    load(url('https://raw.github.com/jhollist/hkm2014/master/data/hkm2014Data.rda'))


************
**lakeNLCD**: NLCD (2006) landcover area and percents by category and NLCD percent impervious cover for 4 buffer zones around NLA lakes

'data.frame':  4624 obs. of  59 variables:  NOTE: some missing lakes

**Field**  | **Definition**
------------- | ------------- 
NLA_ID | USEPA National Lake Assessment 2007 unique identifier
Comid | Comid for lake from NHDplus Version 2
MaxDist | Buffer width (m) for the "MaxDist" buffers; Fixed buffers are 300, 1500, or 3000 meters.
PercentImperv_BuffDist | PercentImperv:  (%) Percent impervious cover in buffer = ImpervAreaKm2/BufferAreaKm2Adj/100
ImpervAreaKm2_BuffDist | ImpervAreaKm2:  (Km2) total impervious cover in the buffer
PercentNA | PercentNA:  (%) (number of NA grid cells)/(total number of grid cells)*100; note this is for the MaxDist buffer only.  If we are concerned about this we need to look at other buffer widths as well.
WaterKm2_BuffDist | Area (Km2) of lake buffer categorized as NLCD(2006) code=11:  Open Water - All areas of open water, generally with less than 25% cover or vegetation or soil
IceSnowKm2_BuffDist | Area (Km2) of lake buffer categorized as NLCD(2006) code=12:  Perennial Ice/Snow - All areas characterized by a perennial cover of ice and/or snow, generally greater than 25% of total cover.
DevOpenKm2_BuffDist | Area (Km2) of lake buffer categorized as NLCD(2006) code=21:  Developed, Open Space - Includes areas with a mixture of some constructed materials, but mostly vegetation in the form of lawn grasses.  Impervious surfaces account for less than 20 percent of total cover.  These areas most commonly include large-lot single-family housing units, parks, golf courses, and vegetation planted in developed settings for recreation, erosion control, or aesthetic purposes.
DevLowKm2_BuffDist | Area (Km2) of lake buffer categorized as NLCD(2006) code=22:  Developed, Low Intensity -Includes areas with a mixture of constructed materials and vegetation.  Impervious surfaces account for 20-49 percent of total cover.  These areas most commonly include single-family housing units.
DevMedKm2_BuffDist | Area (Km2) of lake buffer categorized as NLCD(2006) code=23:  Developed, Medium Intensity - Includes areas with a mixture of constructed materials and vegetation. Impervious surfaces account for 50-79 percent of the total cover.  These areas most commonly include single-family housing units.
DevHighKm2_BuffDist | Area (Km2) of lake buffer categorized as NLCD(2006) code=24:  Developed, High Intensity - Includes highly developed areas where people reside or work in high numbers. Examples include apartment complexes, row houses and commercial/industrial.  Impervious surfaces account for 80 to 100 percent of the total cover.
BarrenKm2_BuffDist | Area (Km2) of lake buffer categorized as NLCD(2006) code=31:  Barren Land (Rock/Sand/Clay) - Barren areas of bedrock, desert pavement, scarps, talus, slides, volcanic material, glacial debris, sand dunes, strip mines, gravel pits and other accumulations of earthen material. Generally, vegetation accounts for less than 15% of total cover.
DeciduousKm2_BuffDist | Area (Km2) of lake buffer categorized as NLCD(2006) code=41:  Deciduous Forest - Areas dominated by trees generally greater than 5 meters tall, and greater than 20% of total vegetation cover. More than 75 percent of the tree species shed foliage simultaneously in response to seasonal change.
EvergreenKm2_BuffDist | Area (Km2) of lake buffer categorized as NLCD(2006) code=42:  Evergreen Forest - Areas dominated by trees generally greater than 5 meters tall, and greater than 20% of total vegetation cover. More than 75 percent of the tree species maintain their leaves all year. Canopy is never without green foliage.
MixedForKm2_BuffDist | Area (Km2) of lake buffer categorized as NLCD(2006) code=43:  Mixed Forest - Areas dominated by trees generally greater than 5 meters tall, and greater than 20% of total vegetation cover. Neither deciduous nor evergreen species are greater than 75 percent of total tree cover.
ShrubKm2_BuffDist | Area (Km2) of lake buffer categorized as NLCD(2006) code=52:  Shrub/Scrub - Areas dominated by shrubs; less than 5 meters tall with shrub canopy typically greater than 20% of total vegetation. This class includes true shrubs, young trees in an early successional stage or trees stunted from environmental conditions.
GrassKm2_BuffDist | Area (Km2) of lake buffer categorized as NLCD(2006) code=71:  Grassland/Herbaceous - Areas dominated by grammanoid or herbaceous vegetation, generally greater than 80% of total vegetation.  These areas are not subject to intensive management such as tilling, but can be utilized for grazing.
PastureKm2_BuffDist | Area (Km2) of lake buffer categorized as NLCD(2006) code=81:  Pasture/Hay - Areas of grasses, legumes, or grass-legume mixtures planted for livestock grazing or the production of seed or hay crops, typically on a perennial cycle. Pasture/hay vegetation accounts for greater than 20 percent of total vegetation.
CropsKm2_BuffDist | Area (Km2) of lake buffer categorized as NLCD(2006) code=82:  Cultivated Crops - Areas used for the production of annual crops, such as corn, soybeans, vegetables, tobacco, and cotton, and also perennial woody crops such as orchards and vineyards. Crop vegetation accounts for greater than 20 percent of total vegetation. This class also includes all land being actively tilled.
WoodyWetKm2_BuffDist | Area (Km2) of lake buffer categorized as NLCD(2006) code=90:  Woody Wetlands - Areas where forest or shrub land vegetation accounts for greater than 20 percent of vegetative cover and the soil or substrate is periodically saturated with or covered with water.
HerbWetKm2_BuffDist | Area (Km2) of lake buffer categorized as NLCD(2006) code=95:  Emergent Herbaceous Wetlands - Areas where perennial herbaceous vegetation accounts for greater than 80 percent of vegetative cover and the soil or substrate is periodically saturated with or covered with water.
NLCD_NA_Per_BuffDist | Percent (proportion*100) of lake buffer categorized as NLCD(2006) code=0:  Missing Value for Landcover
WaterPer_BuffDist | Percent (proportion*100) of lake buffer categorized as NLCD(2006) code=11:  Open Water - All areas of open water, generally with less than 25% cover or vegetation or soil
IceSnowPer_BuffDist | Percent (proportion*100) of lake buffer categorized as NLCD(2006) code=12:  Perennial Ice/Snow - All areas characterized by a perennial cover of ice and/or snow, generally greater than 25% of total cover.
DevOpenPer_BuffDist | Percent (proportion*100) of lake buffer categorized as NLCD(2006) code=21:  Developed, Open Space - Includes areas with a mixture of some constructed materials, but mostly vegetation in the form of lawn grasses.  Impervious surfaces account for less than 20 percent of total cover.  These areas most commonly include large-lot single-family housing units, parks, golf courses, and vegetation planted in developed settings for recreation, erosion control, or aesthetic purposes.
DevLowPer_BuffDist | Percent (proportion*100) of lake buffer categorized as NLCD(2006) code=22:  Developed, Low Intensity -Includes areas with a mixture of constructed materials and vegetation.  Impervious surfaces account for 20-49 percent of total cover.  These areas most commonly include single-family housing units.
DevMedPer_BuffDist | Percent (proportion*100) of lake buffer categorized as NLCD(2006) code=23:  Developed, Medium Intensity - Includes areas with a mixture of constructed materials and vegetation. Impervious surfaces account for 50-79 percent of the total cover.  These areas most commonly include single-family housing units.
DevHighPer_BuffDist | Percent (proportion*100) of lake buffer categorized as NLCD(2006) code=24:  Developed, High Intensity - Includes highly developed areas where people reside or work in high numbers. Examples include apartment complexes, row houses and commercial/industrial.  Impervious surfaces account for 80 to 100 percent of the total cover.
BarrenPer_BuffDist | Percent (proportion*100) of lake buffer categorized as NLCD(2006) code=31:  Barren Land (Rock/Sand/Clay) - Barren areas of bedrock, desert pavement, scarps, talus, slides, volcanic material, glacial debris, sand dunes, strip mines, gravel pits and other accumulations of earthen material. Generally, vegetation accounts for less than 15% of total cover.
DeciduousPer_BuffDist | Percent (proportion*100) of lake buffer categorized as NLCD(2006) code=41:  Deciduous Forest - Areas dominated by trees generally greater than 5 meters tall, and greater than 20% of total vegetation cover. More than 75 percent of the tree species shed foliage simultaneously in response to seasonal change.
EvergreenPer_BuffDist | Percent (proportion*100) of lake buffer categorized as NLCD(2006) code=42:  Evergreen Forest - Areas dominated by trees generally greater than 5 meters tall, and greater than 20% of total vegetation cover. More than 75 percent of the tree species maintain their leaves all year. Canopy is never without green foliage.
MixedForPer_BuffDist | Percent (proportion*100) of lake buffer categorized as NLCD(2006) code=43:  Mixed Forest - Areas dominated by trees generally greater than 5 meters tall, and greater than 20% of total vegetation cover. Neither deciduous nor evergreen species are greater than 75 percent of total tree cover.
ShrubPer_BuffDist | Percent (proportion*100) of lake buffer categorized as NLCD(2006) code=52:  Shrub/Scrub - Areas dominated by shrubs; less than 5 meters tall with shrub canopy typically greater than 20% of total vegetation. This class includes true shrubs, young trees in an early successional stage or trees stunted from environmental conditions.
GrassPer_BuffDist | Percent (proportion*100) of lake buffer categorized as NLCD(2006) code=71:  Grassland/Herbaceous - Areas dominated by grammanoid or herbaceous vegetation, generally greater than 80% of total vegetation.  These areas are not subject to intensive management such as tilling, but can be utilized for grazing.
PasturePer_BuffDist | Percent (proportion*100) of lake buffer categorized as NLCD(2006) code=81:  Pasture/Hay - Areas of grasses, legumes, or grass-legume mixtures planted for livestock grazing or the production of seed or hay crops, typically on a perennial cycle. Pasture/hay vegetation accounts for greater than 20 percent of total vegetation.
CropsPer_BuffDist | Percent (proportion*100) of lake buffer categorized as NLCD(2006) code=82:  Cultivated Crops - Areas used for the production of annual crops, such as corn, soybeans, vegetables, tobacco, and cotton, and also perennial woody crops such as orchards and vineyards. Crop vegetation accounts for greater than 20 percent of total vegetation. This class also includes all land being actively tilled.
WoodyWetPer_BuffDist | Percent (proportion*100) of lake buffer categorized as NLCD(2006) code=90:  Woody Wetlands - Areas where forest or shrub land vegetation accounts for greater than 20 percent of vegetative cover and the soil or substrate is periodically saturated with or covered with water.
HerbWetPer_BuffDist | Percent (proportion*100) of lake buffer categorized as NLCD(2006) code=95:  Emergent Herbaceous Wetlands - Areas where perennial herbaceous vegetation accounts for greater than 80 percent of vegetative cover and the soil or substrate is periodically saturated with or covered with water.
AlbersX|(m) ESRI USA Contiguous Albers Equal Area Conic X coordinate in from National_LakePoly.shp
AlbersY|(m) ESRI USA Contiguous Albers Equal Area Conic Y coordinate in from National_LakePoly.shp
LakeArea|(km2) Lake Area from attribute table of from National_LakePoly.shp
LakePerim|(km) Lake Perimeter from attribute table of from National_LakePoly.shp
ShoreDevel|Shoreline development index from attribute table of from National_LakePoly.shp
DATE_COL|Date of site visit
WSA_ECO9|Wadeable Streams Assessment Aggregated Ecoregion; see definitions below
BASINAREA|(km2) Area of lake basin (upstream area) from attribute table of from National_LakePoly.shp
DEPTHMAX|(m) Maximum Observed Lake Depth 
ELEV_PT|(m) Site elevation from the National Elevation Dataset
CHLA|Chlorophyll a concentration (µg/L).  
DO2_2M|MEAN DO2 CONC (mg/L) IN UPPER 2m (or UPPER 50% IF DEPTH < 4m)
PH_FIELD|Field pH from Profile DO data (pH measured at first non-zero depth unless only depth was zero)
COND|Conductivity (uS/cm @ 25 C)
ANC|Gran ANC (ueq/L)
TURB|Turbidity (NTU)
TOC|Total Organic Carbon (mg/L)
DOC|Dissolved Organic Carbon (mg/L)
NH4|Ammonium (ueq/L)
NO3_NO2|Nitrate + Nitrite by Flow Injection Analysis (mg N/L)
NTL|Total Nitrogen (ug/L)
PTL|Total Phosphorus (ug/L)
CL|Chloride (ueq/L)
NO3|Nitrate (ueq/L)
SO4|Sulfate (ueq/L)
CA|Calcium (ueq/L)
MG|Magnesium (ueq/L)
Na|Sodium (ueq/L)
K|Potassium (ueq/L)
COLOR|Color (PCU)
SIO2|Silica (mg/L SiO2)
H|H+ from PH_LAB (ueq/L)
OH|Hydroxide from PH_LAB (ueq/L)
NH4ION|Calculated NH4+ protolyte (ueq/L)
CATSUM|Sum of Cations (ueq/L)
ANSUM2|Sum of Anions using ANC (ueq/L)
ANDEF2|Anion Deficit using ANC (C - A) (ueq/L)
SOBC|Sum of Base Cations (ueq/L)
BALANCE2|Ion Balance using ANC (%)
ORGION|Est. Organic Anion (ueq/L)
CONCAL2|Calculated Conductivity w/ANC (uS/cm)
CONDHO2|D-H-O Calc. Cond. w/ANC (uS/cm)
SECMEAN|Secchi transparency (m)(=avg. of disk disappearance and reappearance depths)
TminW|(degrees C) minimum water temperature observed for depths <=1m  (8 missing values)
TmaxW|(degrees C) maximum water temperature observed for depths <=1m  (8 missing values)
TmeanW|(degrees C) mean water temperature for depths <=1m  (8 missing values)
DDs40|Single Sine Method used to Calculate Degree Days with a lower threshold of 40 degrees F
DDs45|Single Sine Method used to Calculate Degree Days with a lower threshold of 45 degrees F
DDs50|Single Sine Method used to Calculate Degree Days with a lower threshold of 50 degrees F
DDs55|Single Sine Method used to Calculate Degree Days with a lower threshold of 55 degrees F
MaxLength|(m) the maximum distance on the lake surface between any two points on the shore line.
MaxWidth|(m) The maximum distance between the shores perpendicular to the line of maximum length.
MeanWidth|(m) the surface area divided by the maximum length.
FetchN| (m) max N to S length of lake surface area without land interruption that wind can act on.
FetchNE|(m) max NE to SW length of lake surface area without land interruption that wind can act on.
FetchE|(m) max E to W length of lake surface area without land interruption that wind can act on.
FetchSE|(m) max SE to NW length of lake surface area without land interruption that wind can act on.
MaxDepthCorrect|(m) Max estimated depth-See Hollister et al 2011
VolumeCorrect|(m3) Estimated Volume
MeanDepthCorrect|(m) VolumeCorrect/SurfaceArea; based on corrected maximum depth
TS_NTL|Trophic State Based on NTL; Ordered Factor; Oligo <=350; Meso >350 & <=750;Eu >750 & <=1400;Hyper >1400
TS_PTL|Trophic State Based on PTL; Ordered Factor; Oligo <=10; Meso >10 & <=25;Eu >25 & <=50;Hyper >50
TS_CHLA|Trophic State Based on CHLA; Ordered Factor; Oligo <=2; Meso >2 & <=7;Eu >7 & <=30;Hyper >30

********
**WSA_ECO9 Ecoregions**

**WSA_ECO9**      | **Ecoregions**
------------- | ------------- 
CPL | Coastal Plains
NAP|	Northern Appalachians
NPL|	Northern Plains
SAP|	Southern Appalachians
SPL|	Southern Plains
TPL|	Temporate Plains
UMW|	Upper Midwest
WMT|	Western Mountains
XER|	Xeric

