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

#apply the wavelengthborders from the metadata
#Vector with corresponding wavelength for each band. 
#A matrix or data.frame may be passed giving the upper and lower limit 
#of each band. In this case, the first column is used as lower band 
#limit and the second as upper limit, respectively.

wavelength <- matrix(c(440, 520, 630, 690, 760, 510, 590, 685, 730, 850), nrow = 2, ncol = 5, byrow = TRUE)
wavelength

#optional hyperspecs for performance
#hyperspecs <- hsdar::HyperSpecRaster(raster, wavelength)
#class(hyperspecs)

#speclip for further steps
speclib <- hsdar::speclib(raster, wavelength)
class(speclib)


#-------------------- Vegetation Indices --------------------

#required packages
devtools::install_github("pat-s/rasterFunctions")

#NDVI Calculation Option 1
time <- Sys.time()
range <- 70
ndvi_speclib <- vegindex(speclib, index = "NDVI3")
