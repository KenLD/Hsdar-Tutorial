##### HSDAR Tutorial from Patrick Schratz 2017#####


#Installing required packages
install.packages("pacman")
pacman::p_load(raster, mapview, rasterVis, devtools)
install.packages("backports")
install.packages("ModelMetrics")
install.packages("caret")
devtools::install_github("krlmlr/here")
devtools::install_github("cran/hsdar")

#Loading required packages
library(raster)
library(rasterVis)
library(mapview)
library(hsdar)
require(here)

#-------------- Input ----------------------

#Set WD
setwd("C:/Users/Ken Mauser/Desktop/Studium Landau/Projekt Umweltwissenschaften/Tutorial Hsdar")

# list files
file <- here("daten") %>% list.files(pattern = ".tif$", full.names = TRUE)
file

#read the files in R, nlayers shows the number of bands
raster <- raster::brick(file[1])
raster

#-------------- Visualization -----------------

#Quick look at the image, Number from 1 to 5 can be chosen (5 bands sample)
rasterVis::levelplot(raster[[4]], margin = FALSE, pretty = TRUE)
mapview(raster[[4]], na.color = "transparent", map.types = "Esri.WorldImagery")


#-----------Transforming the Rasterclass so hsdar can use it------------

#apply the wavelength from the metadata?????
wavelength <- c(404.08,

