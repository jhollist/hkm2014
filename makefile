all: hkm2014.md hkm2014.pdf 

hkm2014.md: hkm2014.Rmd
	Rscript -e "library(knitr); knit('hkm2014.Rmd')"

hkm2014.pdf: hkm2014.md hkm2014.bib
	pandoc -H format.sty -V fontsize=12pt --bibliography hkm2014.bib hkm2014.md -o hkm2014.pdf