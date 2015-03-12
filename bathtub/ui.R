# Must be executed BEFORE rgl is loaded on headless devices.
options(rgl.useNULL=TRUE)
library(shiny)
library(shinyRGL)
rates_14_all <- read.csv("data/rates_14_all.csv")

shinyUI(fluidPage(theme = "bootstrap.css",                  
                  titlePanel("First attempt at bathtub"),

  # Sidebar with a slider input for number of points
  sidebarLayout(
  sidebarPanel(
    sliderInput("year", "Select time range", 1750, 2010, c(1750,2010), step = NULL, round = TRUE,
                format = "#,##0.#####", locale = "us", ticks = TRUE, animate = FALSE,
                width = NULL) ,  
    sliderInput("age", "Select age range", 0, 100, c(0,80), step = NULL, round = TRUE,
                format = "#,##0.#####", locale = "us", ticks = TRUE, animate = FALSE,
                width = NULL) ,  
    selectInput("gender", "Select gender group", choices=c("total", "male", "female") ),
    checkboxInput("log", 
                  "Logged death rates?", 
                  FALSE),
    checkboxInput("axes", 
                "Do you want to see the horrible axes?", 
               TRUE)   
    ), 
  # Show the generated 3d bivar plot
  mainPanel(
    webGLOutput("bathtub", width = "600px", height = "600px")
  ))
))


