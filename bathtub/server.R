# Must be executed BEFORE rgl is loaded on headless devices.
options(rgl.useNULL=TRUE)

library(shiny)
library(rgl)
library(reshape2)
library(shinyRGL)
rates_14_all <- read.csv("data/rates_14_all.csv")


shinyServer(function(input, output) {
  
#  Expression that generates a rgl scene with a number of points corresponding
#  to the value currently set in the slider.
  output$bathtub <- renderWebGL({
    
    # inputs
    gender <- input$gender
    minage <- input$age[1]
    maxage <- input$age[2]
    minyear <- input$year[1]
    maxyear <- input$year[2]
    log = input$log

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
    
    rgl.surface( ylabs, xlabs, heights,
                 specular = "#FFFFFF",
                 zlim=range(log(ssc)),
                 ambient = "#222222",
                 color="yellow",
                 aspect=c(1,1,1))
    rgl.bg(sphere=FALSE, color=c("black","green"), lit=FALSE, back="lines" )
    aspect3d(1,1,1)
    if (input$axes == TRUE) {axes3d(edges = "bbox", labels = TRUE, tick = TRUE, nticks = 5, 
           box=FALSE, expand = 1.03, xlabs=xlabs, size         = 1)}
    
    
  })
})