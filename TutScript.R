##### HSDAR Tutorial from Patrick Schratz 2017#####


#Installing required packages
install.packages("pacman")
pacman::p_load(raster, mapview, rasterVis, devtools)
install.packages("backports")
install.packages("ModelMetrics")
install.packages("caret")
devtools::install_github("krlmlr/here")
devtools::install_github("pat-s/hsdar")

#Loading required packages
library(raster)
library(rasterVis)
library(mapview)
library(hsdar)
require(here)

#-------------- Input ----------------------

#Set WD
setwd("C:/Users/Ken Mauser/Desktop/Studium Landau/Projekt Umweltwissenschaften/Tutorial Hsdar")
datadir <- "C:/Users/Ken Mauser/Desktop/Studium Landau/Projekt Umweltwissenschaften/Tutorial Hsdar"
file <- list.files(file.path(datadir, "Daten"), pattern = ".tif", full.names = TRUE)
# list files
#file <- here("Daten") %>% list.files(pattern = ".tif$", full.names = TRUE)
file

#read the files in R, nlayers shows the number of bands
rapid <- raster::brick(file[1])
rapid

#-------------- Visualization -----------------

#Quick look at the image, Number from 1 to 5 can be chosen (5 bands sample)
rasterVis::levelplot(rapid[[4]], margin = FALSE, pretty = TRUE)
mapview(rapid[[4]], na.color = "transparent", map.types = "Esri.WorldImagery")


#-----------Transforming the Rasterclass so hsdar can use it------------

#apply the wavelengthborders from the metadata ????
#Vector with corresponding wavelength for each band. 
#A matrix or data.frame may be passed giving the upper and lower limit 
#of each band. In this case, the first column is used as lower band 
#limit and the second as upper limit, respectively.

#get.sensor.characteristics

wavelength <- c(440, 520, 630, 690, 760)
wavelength

#optional hyperspecs for performance
#hyperspecs <- hsdar::HyperSpecRaster(raster, wavelength)
#class(hyperspecs)

#speclip for further steps
rapidclass <- hsdar::speclib(rapid, wavelength)
class(rapidclass)


#-------------------- Vegetation Indices --------------------

#required packages
devtools::install_github("pat-s/rasterFunctions")
require(rasterFunctions)

#NDVI Calculation Option 1
time <- Sys.time()
ndvi_speclib <- vegindex(rapidclass, index = "NDVI2")
Sys.time() - time

#writeRaster
