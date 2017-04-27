##### HSDAR Tutorial from Patrick Schratz 2017#####


#Installing required packages
install.packages("pacman")
pacman::p_load(raster, mapview, rasterVis, devtools)
devtools::install_github("krlmlr/here")
devtools::install_github("cran/hsdar")

#Loading required packages
require(raster, mapview, rasterVis, here, hsdar)

#Set WD
setwd("C:/Users/Ken Mauser/Desktop/Studium Landau/Projekt Umweltwissenschaften/Tutorial Hsdar")
