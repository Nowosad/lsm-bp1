library(sf)
library(dplyr)
library(gdalUtils)
library(rnaturalearth)

# australia shapefile -----------------------------------------------------
# http://spatialreference.org/ref/epsg/gda94-geoscience-australia-lambert/
dir.create("data")
ne_countries(country = "Australia", returnclass = "sf") %>% 
  select(admin) %>% 
  st_write("data/australia.gpkg", delete_dsn = TRUE)

# australia clip ----------------------------------------------------------
data_prep = function(input_name, output_name, crop_vector){
  l3 = st_read(crop_vector)
  gdalwarp(input_name,
           output_name,
           te = as.vector(st_bbox(l3)),
           multi = TRUE,
           wm = 2000)
}

dir.create("raw_data")
# https://storage.googleapis.com/cci-lc-v207/ESACCI-LC-L4-LCCS-Map-300m-P1Y-2015-v2.0.7.zip
input_name = "raw_data/ESACCI-LC-L4-LCCS-Map-300m-P1Y-2015-v2.0.7/product/ESACCI-LC-L4-LCCS-Map-300m-P1Y-2015-v2.0.7.tif"
data_prep(input_name, "data/cci_lc_australia.tif", "data/australia.gpkg")
