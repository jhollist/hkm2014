all: PaperPimping.md bloggingTweeting.pdf 

PaperPimping.md: PaperPimping.Rmd
	Rscript -e "library(knitr); knit('PaperPimping.Rmd')"

bloggingTweeting.pdf: PaperPimping.md bloggingTweeting2.bib
	pandoc -H format.sty -V fontsize=12pt --bibliography bloggingTweeting2.bib PaperPimping.md -o bloggingTweeting.pdf