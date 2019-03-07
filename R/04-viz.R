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

# tmap_options(max.raster = c(plot = 150000, view = 200000))
tmap_options(max.raster = c(plot = 211069758, view = 211069758))

p0 = tm_shape(lc) +
  tm_raster(palette = lc_legend$hex,
            breaks = lc_legend$NB_LAB,
            style = "cat",
            title = "Land cover categories") + 
  tm_shape(sample_points) + 
  tm_markers() +
  tm_layout(legend.outside = TRUE)

library(landscapemetrics)
x1 = sample_lsm(lc, what = "lsm_p_area", points = sample_points[1, ],
               size = 10000, return_raster = TRUE)
x1b = sample_lsm(lc, what = "lsm_p_area", points = sample_points[1, ],
                size = 3000, return_raster = TRUE)
x1c = sample_lsm(lc, what = "lsm_p_area", points = sample_points[1, ],
                 size = 6000, return_raster = TRUE)
x1d = sample_lsm(lc, what = "lsm_p_area", points = sample_points[1, ],
                 size = 3000, return_raster = TRUE, shape = "circle")
x2 = sample_lsm(lc, what = "lsm_p_area", points = sample_points[2, ],
                size = 10000, return_raster = TRUE)
x2b = sample_lsm(lc, what = "lsm_p_area", points = sample_points[2, ],
                size = 3000, return_raster = TRUE)
x2c = sample_lsm(lc, what = "lsm_p_area", points = sample_points[2, ],
                 size = 6000, return_raster = TRUE)
x2d = sample_lsm(lc, what = "lsm_p_area", points = sample_points[2, ],
                 size = 3000, return_raster = TRUE, shape = "circle")
x3 = sample_lsm(lc, what = "lsm_p_area", points = sample_points[3, ],
                size = 10000, return_raster = TRUE)
x3b = sample_lsm(lc, what = "lsm_p_area", points = sample_points[3, ],
                size = 3000, return_raster = TRUE)
x3c = sample_lsm(lc, what = "lsm_p_area", points = sample_points[3, ],
                 size = 6000, return_raster = TRUE)
x3d = sample_lsm(lc, what = "lsm_p_area", points = sample_points[3, ],
                 size = 3000, return_raster = TRUE, shape = "circle")


lc1 = crop(lc, x1$raster_sample_plots[[1]])
lc_legend1 = lc_legend %>% 
  filter(NB_LAB %in% unique(lc1))

p1 = tm_shape(lc1) +
  tm_raster(palette = lc_legend1$hex,
            breaks = lc_legend1$NB_LAB,
            style = "cat",
            title = "Land cover categories") + 
  tm_shape(st_as_sfc(st_bbox(x1$raster_sample_plots[[1]])), is.master = TRUE) +
  tm_borders() +  
  tm_shape(sample_points[1, ]) + 
  tm_markers() +
  tm_layout(legend.outside = TRUE) +
  tm_scale_bar(breaks = seq(0, 3, 1))

p1b = p1 + 
  tm_shape(st_as_sfc(st_bbox(x1b$raster_sample_plots[[1]]))) +
  tm_borders(lwd = 3)

p1c = p1 + 
  tm_shape(st_as_sfc(st_bbox(x1b$raster_sample_plots[[1]]))) +
  tm_borders(lwd = 3) + 
  tm_shape(st_as_sfc(st_bbox(x1c$raster_sample_plots[[1]]))) +
  tm_borders(lwd = 3)

p1circle = st_as_sf(rasterToPolygons(x1d$raster_sample_plots[[1]]))
p1circle = st_union(st_set_precision(p1circle, 5))

p1d = p1 + 
  tm_shape(p1circle) +
  tm_borders(lwd = 3)

lc2 = crop(lc, x2$raster_sample_plots[[1]])
lc_legend2 = lc_legend %>% 
  filter(NB_LAB %in% unique(lc2))

p2 = tm_shape(lc2) +
  tm_raster(palette = lc_legend2$hex,
            breaks = lc_legend2$NB_LAB,
            style = "cat",
            title = "Land cover categories") + 
  tm_shape(st_as_sfc(st_bbox(x2$raster_sample_plots[[1]])), is.master = TRUE) +
  tm_borders() +  
  tm_shape(sample_points[2, ]) + 
  tm_markers() +
  tm_layout(legend.outside = TRUE) +
  tm_scale_bar(breaks = seq(0, 3, 1))

p2b = p2 + 
  tm_shape(st_as_sfc(st_bbox(x2b$raster_sample_plots[[1]]))) +
  tm_borders(lwd = 3)

p2c = p2 + 
  tm_shape(st_as_sfc(st_bbox(x2b$raster_sample_plots[[1]]))) +
  tm_borders(lwd = 3) + 
  tm_shape(st_as_sfc(st_bbox(x2c$raster_sample_plots[[1]]))) +
  tm_borders(lwd = 3)

p2circle = st_as_sf(rasterToPolygons(x2d$raster_sample_plots[[1]]))
p2circle = st_union(st_set_precision(p2circle, 5))

p2d = p2 + 
  tm_shape(p2circle) +
  tm_borders(lwd = 3)

lc3 = crop(lc, x3$raster_sample_plots[[1]])
lc_legend3 = lc_legend %>% 
  filter(NB_LAB %in% unique(lc3))

p3 = tm_shape(lc3) +
  tm_raster(palette = lc_legend3$hex,
            breaks = lc_legend3$NB_LAB,
            style = "cat",
            title = "Land cover categories") + 
  tm_shape(st_as_sfc(st_bbox(x3$raster_sample_plots[[1]])), is.master = TRUE) +
  tm_borders() +  
  tm_shape(sample_points[3, ]) + 
  tm_markers() +
  tm_layout(legend.outside = TRUE) +
  tm_scale_bar(breaks = seq(0, 3, 1))

p3b = p3 + 
  tm_shape(st_as_sfc(st_bbox(x3b$raster_sample_plots[[1]]))) +
  tm_borders(lwd = 3)

p3c = p3 + 
  tm_shape(st_as_sfc(st_bbox(x3b$raster_sample_plots[[1]]))) +
  tm_borders(lwd = 3) + 
  tm_shape(st_as_sfc(st_bbox(x3c$raster_sample_plots[[1]]))) +
  tm_borders(lwd = 3)

p3circle = st_as_sf(rasterToPolygons(x3d$raster_sample_plots[[1]]))
p3circle = st_union(st_set_precision(p3circle, 5))

p3d = p3 + 
  tm_shape(p3circle) +
  tm_borders(lwd = 3)

# tmap_arrange(p1, p2, p3, nrow = 1)

dir.create("figs")
tmap_save(p0, "figs/01-map-all.png")
tmap_save(p1b, "figs/02-p1-map.png", width = 3.15, height = 8.75)
tmap_save(p2b, "figs/03-p2-map.png", width = 3.15, height = 8.75)
tmap_save(p3b, "figs/04-p3-map.png", width = 3.15, height = 8.75)

tmap_save(p1c, "figs/02-p1-map2.png", width = 3.15, height = 8.75)
tmap_save(p2c, "figs/03-p2-map2.png", width = 3.15, height = 8.75)
tmap_save(p3c, "figs/04-p3-map2.png", width = 3.15, height = 8.75)

tmap_save(p1d, "figs/02-p1-map3.png", width = 3.15, height = 8.75)
tmap_save(p2d, "figs/03-p2-map3.png", width = 3.15, height = 8.75)
tmap_save(p3d, "figs/04-p3-map3.png", width = 3.15, height = 8.75)

system("mogrify -trim figs/*.png")

# merge images
library(magick)

p1_names = dir("figs", pattern = "map.png", full.names = TRUE)
p2_names = dir("figs", pattern = "map2.png", full.names = TRUE)
p3_names = dir("figs", pattern = "map3.png", full.names = TRUE)

p1_names %>% 
  image_read() %>% 
  image_append(stack = FALSE) %>% 
  image_write("figs/p1.png")

p2_names %>% 
  image_read() %>% 
  image_append(stack = FALSE) %>% 
  image_write("figs/p2.png")

p3_names %>% 
  image_read() %>% 
  image_append(stack = FALSE) %>% 
  image_write("figs/p3.png")
