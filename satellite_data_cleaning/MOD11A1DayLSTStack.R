#Parallel processing for the day temperature

library(raster)
library(sf)
library(doParallel)

#Import the shapefile
us_shp <- read_sf("tl_2022_us_state/tl_2022_us_state.shp")

#Subset on the Connecticut state shapefile
ct_shp <- us_shp[us_shp$NAME == "Connecticut",]

#Get the lon-lat crs
lon_lat_crs <- st_crs(ct_shp)

#CRS of the shapefile
crsSH <- CRS("+init=epsg:4269")

#DEFINE THE NUMBER OF CORES HERE
num_cores <- 4
cl <- makeCluster(num_cores)
registerDoParallel(cl)

#Define the directory 
raster_dir <- "0.2.1.LST_MOD11A1"

#Define the pattern, here we only want the files with days
pattern <- "Day"

#Get the tif files
tif_files <- list.files(path = raster_dir, pattern = pattern, full.names = TRUE)

#Define the function for transformation
transform_tif <- function(tif_file){
  #Load the tif files
  raster_data <- raster::brick(tif_file)
  
  #Project the data
  raster_data_trans <- raster::projectRaster(raster_data, crs = crsSH)
  
  #Now use the mask
  raster_data_trans <- raster::mask(raster_data_trans, mask = ct_shp)
  
  #Now we can extract the date and rename the data
  date_string <- sub(".+doy(\\d+)_aid.+\\.tif", "\\1", tif_file)
  
  #Format into the date
  date <- as.Date(date_string, format = "%Y%j")
  
  #Rename the data
  names(raster_data_trans) <- as.character(date)
  
  #Now we have the data we need
  return(raster_data_trans)
}

#Now execute the transformations
transformed_rasters <- foreach(tif_file = tif_files, .combine = 'c') %dopar% {
  transform_tif(tif_file)
}

#Now we convert the list into a raster stack
stacked_rasters <- stack(transformed_rasters)

#Stop the cluster
stopCluster(cl)

#Return the data
writeRaster(stacked_rasters, "MOD11A1StackedLST.tif")

