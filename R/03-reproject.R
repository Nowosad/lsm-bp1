library(gdalUtils) 
library(sf)
# unzip the file
unzip("data/cci_lc_australia.zip", "data/cci_lc_australia.tif")
# reprojecting the raster data to a local projected coordinate reference system
# read more at http://spatialreference.org/ref/sr-org/7564/
gdalwarp(srcfile = "data/cci_lc_australia.tif",
         dstfile = "data/cci_lc_australia_aea.vrt",
         of = "VRT",
         t_srs = "+proj=aea +lat_1=-18 +lat_2=-36 +lat_0=0 +lon_0=132 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")
# compressing the output file
gdal_translate(src_dataset = "data/cci_lc_australia_aea.vrt",
               dst_dataset = "data/cci_lc_australia_aea.tif",
               co = "COMPRESS=LZW")

# reading the vector data and reprojecting it
points = read.csv("data/sample_points.csv") %>% 
  st_as_sf(coords = c("longitude", "latitude")) %>% 
  st_set_crs(4326) %>% 
  st_transform("+proj=aea +lat_1=-18 +lat_2=-36 +lat_0=0 +lon_0=132 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs ")

# saving the new object to a spatial data format GPKG
st_write(points, "data/sample_points.gpkg")
