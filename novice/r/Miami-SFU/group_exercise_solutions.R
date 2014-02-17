### First step (exploratory)

read.delim('medals_2000.txt', header=F)
medals <- read.delim('medals_2000.txt', header=F, col.names=c('year','country','gold','silver','bronze'))
mean(medals$gold)


### Next Attempt
#!/bin/usr/Rscript
args <- commandArgs(TRUE)
medals <- read.delim(args[1], header=F, col.names=c('year','country','gold','silver','bronze'))
mean(medals$gold)




