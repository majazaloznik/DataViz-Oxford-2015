##################################
## test of creating movies with rgl rotations!
## see resulting pdf in pics/animation.pdf
## (.tex file is there as well)
##################################

library(rgl)
library(reshape2)
library(latticeExtra)

# read data
rates_14_all <- read.csv("data/rates_14_all.csv")

# inputs
gender <- "total"
minage <- 0
maxage <- 80
minyear <- 1751
maxyear <- 2012
log = TRUE

# prep data
ss <- subset(rates_14_all, subset= 
               sex==gender  &
               age >= minage &
               age <= maxage & 
               year >= minyear &
               year <= maxyear)
ss <- ss[,c(2,3,7)]
xlabs <- unique(ss[,1])
ylabs <- unique(ss[,2])
ssc <- dcast(ss, age ~ year, value.var="death_rate")
ssc <- ssc[,-1]
if (log == TRUE){heights <-  as.matrix(log(ssc))} else{
  heights <-  as.matrix(ssc)}


# plot chart
rgl.clear()
rgl.clear("lights")
rgl.light(theta = 45, phi = 45, viewpoint.rel=TRUE)

rgl.surface( ylabs, xlabs, as.matrix(ssc),
            specular = "#FFFFFF",
            zlim=range(log(ssc)),
            ambient = "#222222",
            color="yellow")
aspect3d(1,1,1)
axes3d(edges = "bbox", labels = TRUE, tick = TRUE, nticks = 5, 
       box=FALSE, expand = 1.03, xlabs=xlabs)

for(i in seq(0, 3 * 360, by = 1)) {
  rgl.viewpoint(theta = i, phi = 0)
}


## Record rotating rgl object as "movie"
M <- par3d("userMatrix")              
M1 <- rotate3d(M, .9*pi/2, 1, 0, 0)
M2 <- rotate3d(M1, pi/2, 0, 0, 1)
movie3d(par3dinterp(userMatrix=list(M, M1, M2, M1, M),method="linear"), 
        duration=4, convert=F,clean=F, dir="pics")


