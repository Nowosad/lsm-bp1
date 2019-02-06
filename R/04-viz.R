library(tmap)
library(dplyr)
library(raster)
library(sf)
lc = raster("data/cci_lc_australia_aea.tif")

lc_legend = read.csv2("data/ESACCI-LC-Legend.csv") %>% 
  rowwise() %>% 
  mutate(hex = rgb(R, G, B, maxColorValue = 255)) %>% 
  ungroup() %>% 
  filter(NB_LAB %in% unique(lc))

sample_points = st_read("data/sample_points.gpkg")

tmap_options(max.raster = c(plot = 150000, view = 200000))

tm_shape(lc) +
  tm_raster(palette = lc_legend$hex,
            breaks = lc_legend$NB_LAB,
            style = "cat",
            title = "Land cover categories") + 
  tm_shape(sample_points) + 
  tm_markers() +
  tm_layout(legend.outside = TRUE)

library(landscapemetrics)
x = sample_lsm(lc, what = "lsm_p_area", points = sample_points[1, ],
               size = 30000, return_plots = TRUE)
x

plot(x$raster_sample_plots[[1]])


tm_shape(lc) +
  tm_raster(palette = lc_legend$hex,
            breaks = lc_legend$NB_LAB,
            style = "cat",
            title = "Land cover categories") + 
  tm_shape(st_as_sfc(st_bbox(x$raster_sample_plots[[1]])), is.master = TRUE) +
  tm_borders() +
  tm_shape(sample_points[1, ]) + 
  tm_markers() +
  tm_layout(legend.outside = TRUE)

