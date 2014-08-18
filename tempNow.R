require(varSelRF)
## Not run:
## This is a small example, but can take some time.
x <- matrix(rnorm(25 * 30), ncol = 30)
x[1:10, 1:2] <- x[1:10, 1:2] + 2
cl <- factor(c(rep("A", 10), rep("B", 15)))
rf.vs1 <- varSelRF(x, cl, ntree = 200, ntreeIterat = 100,vars.drop.frac=NULL,vars.drop.num = 1)
rf.vsb <- varSelRFBoot(x, cl,vars.drop.num = 1,
											 bootnumber = 10,
											 usingCluster = FALSE,
											 srf = rf.vs1)


sadfdfddfdf
add this
## End(Not run)