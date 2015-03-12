########################
## load packages and data
#########################
library(vcd)
library(rgl)
library(vcdExtra)
load("vcd/robinson.RData")
robinson

mosaic3d(robinson, color=c("gray"))

mosaic3d(robinson,  color=c("red","gray"))


