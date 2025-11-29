#This is a file to test out the ERA5 Data Cleaning for 2020 DewPoint
library(raster)
library(sf)
library(foreach)
library(doParallel)
library(stringr)

#Get the shapefile
us_shp <- read_sf("/home/kfc27/project/0.tl_2020_us_state/tl_2020_us_state.shp")
#Subset on the Connecticut state shapefile
ct_shp <- us_shp[us_shp$NAME == "Connecticut",]
#Get the lon-lat crs
lon_lat_crs <- st_crs(ct_shp)
#CRS of the shapefile
crsSH <- CRS("+init=epsg:4269")
#Data Processing Separation
#Define the directory and the pattern. We want day here so we will d$
raster_dir <- "0.3.ERA5"
#Define the pattern
pattern_temp <- "dp"
temp_files <- list.files(path = raster_dir, pattern = pattern_temp, full.names = TRUE)
#We need to load in a sample LST file for resampling
lst_sample <- "/home/kfc27/project/0.2.1.LST_MOD11A1/MOD11A1.061_LST_Day_1km_doy2019028_aid0001.tif"
lst_raster <- raster::brick(lst_sample)
lst_raster <- raster::projectRaster(lst_raster, crs = crsSH) #Project the raster
lst_raster <- raster::mask(lst_raster, mask = ct_shp) #Mask the raster


#Define a function to run on each hour in the parallel loop
process_era_5 <- function(raster_hour_data, year){
  #The hour is equivalent to the item
  hour <- item
  #Construct the data frame now
  raster_values <- raster::getValues(raster_hour_data)
  raster_coords <- raster::coordinates(raster_hour_data)
  #Get the raster data
  raster_data_df <- cbind(raster_coords, raster_values)
  raster_data_df <- as.data.frame(raster_data_df)
  #Rename the data
  names(raster_data_df) <- c("Longitude", "Latitude", "DewPoint")
  #Create a column for the hour
  raster_data_df$Hour <- hour
  #Calculate the date
  start_of_year <- as.POSIXct(paste0(year, "-01-01 00:00:00"))
  date_time <- start_of_year + as.difftime(hour - 1, units = "hours")
  raster_data_df$Date <- as.Date(date_time)
  return(raster_data_df)
}

print(paste0("Currently processing: ", temp_files[2]))
raster_file <- temp_files[2]
#Load the data in and mask
raster_data <- raster::brick(raster_file)
raster_data <- raster::projectRaster(raster_data, crs = crsSH)
raster_data <- raster::mask(raster_data, mask = ct_shp)

#raster_data <- raster::resample(raster_data, lst_raster, method = "ngb")
raster_data <- raster::unstack(raster_data) #Now we unstack
date_string <- sub(".*/dp_(\\d+)\\.grib", "dp_\\1", raster_file)
year_string <- sub("dp_(\\d+)", "\\1", date_string)

#Now we want to run a for loop over the data, this will be parallel processed
cl <- makeCluster(12)
registerDoParallel(cl)

# name_string <- names(raster_hour_data)
# hour <- stringr::str_sub(name_string, -4, -1)
# hour <- as.numeric(gsub("[^0-9]", "", hour))

result <- foreach(item = 1:length(raster_data), .combine = rbind) %dopar% {
  process_era_5(raster_data[[item]], year_string)
}

stopCluster(cl)

unique(result$Hour)

string_dir <- paste0("/home/kfc27/project/ERAProcessingData/StepOneDPandTemp/ERA5Dewpoint/era5", date_string, ".csv")
write.csv(result, string_dir)






