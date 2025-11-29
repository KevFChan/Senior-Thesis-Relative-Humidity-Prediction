#This script will clean the day time values of MYD11A1 and separate into year

library(raster)
library(sf)
library(foreach)
library(doParallel)
library(dplyr)

#Get the shapefile
us_shp <- read_sf("/Volumes/Seagate Portable Drive/Shapefiles/tl_2022_us_state/tl_2022_us_state.shp")
#Subset on the Connecticut state shapefile
ct_shp <- us_shp[us_shp$NAME == "Connecticut",]
#Get the lon-lat crs
lon_lat_crs <- st_crs(ct_shp)
#CRS of the shapefile
crsSH <- CRS("+init=epsg:4269")

#We need to load in a sample LST file for resampling
lst_sample <- "/Volumes/Seagate Portable Drive/0.raw_data/0.2.1.LST_MOD11A1/MOD11A1.061_LST_Day_1km_doy2019028_aid0001.tif"
lst_raster <- raster::brick(lst_sample)
lst_raster <- raster::projectRaster(lst_raster, crs = crsSH) #Project the raster
lst_raster <- raster::mask(lst_raster, mask = ct_shp) #Mask the raster

#Data Processing Separation
#Define the directory and the pattern. We want day here so we will define accordingly
raster_dir <- "/Volumes/Seagate Portable Drive/0.raw_data/0.2.2.LST_MYD11A1"
#Define the pattern, here we only want the files with days
pattern <- "Night"
#Get the Night tif_files
tif_files <- list.files(path = raster_dir, pattern = pattern, full.names = TRUE)

#Now we separate the Day files into different years to process them separately
data_2019 <- list()
data_2020 <- list()
data_2021 <- list()
data_2022 <- list()
data_2023 <- list()

for(file in tif_files){
  if(grepl("doy2019", file)){
    data_2019 <- append(data_2019, file)
  }else if(grepl("doy2020", file)){
    data_2020 <- append(data_2020, file)
  }else if(grepl("doy2021", file)){
    data_2021 <- append(data_2021, file)
  }else if(grepl("doy2022", file)){
    data_2022 <- append(data_2022, file)
  }else if(grepl("doy2023", file)){
    data_2023 <- append(data_2023, file)
  }
}

#Let us go over the processing for loop
process_tif <- function(file_name){
  raster_data <- raster::brick(file_name) #Load the tif file
  raster_data <- raster::projectRaster(raster_data, crs = crsSH) #Project the raster to lonlat
  raster_data <- raster::mask(raster_data, mask = ct_shp) #Mask the raster with the shapefile
  
  date_string <- sub(".+doy(\\d+)_aid.+\\.tif", "\\1", file_name) #Now extract the date and rename the data
  date_string <- as.Date(date_string, format = "%Y%j")
  
  #We should resample
  raster_data <- raster::resample(raster_data, lst_raster, method = "bilinear")
  
  #Now we want to extract the values and bound the results together
  raster_values <- data.frame(raster::values(raster_data) * 0.02)
  raster_coords <- data.frame(raster::coordinates(raster_data))
  
  raster_data <- cbind(raster_coords, raster_values)
  
  #Rename the data
  names(raster_data) <- c("Longitude", "Latitude", "Temp")
  #Get the date
  raster_data$Date <- date_string
  
  return(raster_data)
}


#Now we try to create the parallel processing loops
#Define the cores
numCores <- detectCores()
cl <- makeCluster(numCores - 1)
registerDoParallel(cl)

#Apply the foreach loop to each year
tif_2019 <- foreach(file = data_2019, .combine = "rbind") %dopar% {
  process_tif(file)
} 

tif_2020 <- foreach(file = data_2020, .combine = "rbind") %dopar% {
  process_tif(file)
} 

tif_2021 <- foreach(file = data_2021, .combine = "rbind") %dopar% {
  process_tif(file)
} 

tif_2022 <- foreach(file = data_2022, .combine = "rbind") %dopar% {
  process_tif(file)
} 

tif_2023 <- foreach(file = data_2023, .combine = "rbind") %dopar% {
  process_tif(file)
} 

stopCluster(cl)

#Rbind the values together
night_lst <- rbind(tif_2019, tif_2020, tif_2021, tif_2022, tif_2023)

#Get rid of any instances of zero 
summary(night_lst$Temp)
night_lst <- night_lst %>%
  mutate(Temp = ifelse(Temp == 0, NA, Temp))

#Save the dataframe
saveRDS(night_lst, "/Volumes/Seagate Portable Drive/3.clean_data/MYD11A1_Nighttime_Data.RDS")

# write.csv(tif_2019, "CleanedData/MYD11A1NightLST2019.csv")
# write.csv(tif_2020, "CleanedData/MYD11A1NightLST2020.csv")
# write.csv(tif_2021, "CleanedData/MYD11A1NightLST2021.csv")
# write.csv(tif_2022, "CleanedData/MYD11A1NightLST2022.csv")
# write.csv(tif_2023, "CleanedData/MYD11A1NightLST2023.csv")