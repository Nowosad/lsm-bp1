library(mapview)
library(mapedit)
library(raster)
r = raster("data/cci_lc_australia.tif")
my_map = mapview(r)
my_points = mapedit::drawFeatures(my_map)
# plot(r)
# plot(st_geometry(my_points), add = TRUE)
st_write(my_points, "raw-data/sample_points.gpkg")

# points to csv -----------------------------------------------------------
library(sf)
library(dplyr)
my_points = st_read("raw-data/sample_points.gpkg", quiet = TRUE) %>% 
  st_coordinates() %>% 
  as_tibble() %>% 
  mutate(siteID = 1:3) %>% 
  rename(longitude = X, latitude = Y) %>% 
  write.csv("data/sample_points.csv")
