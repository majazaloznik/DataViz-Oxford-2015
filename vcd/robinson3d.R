########################
## load packages (install if haven't yet)
#########################
if(!require("vcd")){install.packages("vcd")
                    if (require("vcd")){"vcd installed correctly"} 
                    else {print("could not install vcd")}}

if(!require("rgl")){install.packages("rgl")
                    if (require("rgl")){"rgl installed correctly"} 
                    else {print("could not install rgl")}}

if(!require("vcdExtra")){install.packages("vcdExtra")
                    if (require("vcdExtra")){"vcdExtra installed correctly"} 
                    else {print("could not install vcdExtra")}}

## load and look at data
load("vcd/robinson.RData")
robinson

## plot rgl object
mosaic3d(robinson, color=c("gray"))

mosaic3d(robinson,  color=c("red","gray"))


