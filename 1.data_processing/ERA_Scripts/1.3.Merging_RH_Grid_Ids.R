data_2019 <- readRDS("/home/kfc27/project/ERAProcessingData/StepTwoCleanedERAData/RelativeHumidity/eraRH2019.RDS")
#Create two other latitude and longitude columns rounded to the tenths place for merging
data_2019$lon <- round(data_2019$Longitude, 1)
data_2019$lat <- round(data_2019$Latitude, 1)

#Get the grid_ids
grid_ids <- readRDS("/home/kfc27/project/ERAProcessingData/8.2.ERA_grid_resample_MODIS_grids_withLonLat.rds")
#We just want the era.id so we'll take columns 5 to 9
grid_ids <- grid_ids[, 5:9]
#Deduplicate
grid_ids <- unique(grid_ids)

data_2019 <- merge(data_2019, grid_ids, by = c("lon", "lat"))
print(paste0("The year 2019 has: ", sum(is.na(data_2019)), " many-NAs"))
saveRDS(data_2019, "/home/kfc27/project/ERAProcessingData/StepThreeRHWithIDs/RHDataIds2019.RDS")
data_2019 <- 0

#Now for 2020
data_2020 <- readRDS("/home/kfc27/project/ERAProcessingData/StepTwoCleanedERAData/RelativeHumidity/eraRH2020.RDS")
#Create two other latitude and longitude columns rounded to the tenths place for merging
data_2020$lon <- round(data_2020$Longitude, 1)
data_2020$lat <- round(data_2020$Latitude, 1)
data_2020 <- merge(data_2020, grid_ids, by = c("lon", "lat"))
print(paste0("The year 2020 has: ", sum(is.na(data_2020)), " many-NAs"))
saveRDS(data_2020, "/home/kfc27/project/ERAProcessingData/StepThreeRHWithIDs/RHDataIds2020.RDS")
data_2020 <- 0

#Now for 2021
data_2021 <- readRDS("/home/kfc27/project/ERAProcessingData/StepTwoCleanedERAData/RelativeHumidity/eraRH2021.RDS")
#Create two other latitude and longitude columns rounded to the tenths place for merging
data_2021$lon <- round(data_2021$Longitude, 1)
data_2021$lat <- round(data_2021$Latitude, 1)
data_2021 <- merge(data_2021, grid_ids, by = c("lon", "lat"))
print(paste0("The year 2021 has: ", sum(is.na(data_2021)), " many-NAs"))
saveRDS(data_2021, "/home/kfc27/project/ERAProcessingData/StepThreeRHWithIDs/RHDataIds2021.RDS")
data_2021 <- 0

#Now for 2022
data_2022 <- readRDS("/home/kfc27/project/ERAProcessingData/StepTwoCleanedERAData/RelativeHumidity/eraRH2022.RDS")
#Create two other latitude and longitude columns rounded to the tenths place for merging
data_2022$lon <- round(data_2022$Longitude, 1)
data_2022$lat <- round(data_2022$Latitude, 1)
data_2022 <- merge(data_2022, grid_ids, by = c("lon", "lat"))
print(paste0("The year 2022 has: ", sum(is.na(data_2022)), " many-NAs"))
saveRDS(data_2022, "/home/kfc27/project/ERAProcessingData/StepThreeRHWithIDs/RHDataIds2022.RDS")
data_2022 <- 0

#Now for 2023
data_2023 <- readRDS("/home/kfc27/project/ERAProcessingData/StepTwoCleanedERAData/RelativeHumidity/eraRH2023.RDS")
#Create two other latitude and longitude columns rounded to the tenths place for merging
data_2023$lon <- round(data_2023$Longitude, 1)
data_2023$lat <- round(data_2023$Latitude, 1)
data_2023 <- merge(data_2023, grid_ids, by = c("lon", "lat"))
print(paste0("The year 2023 has: ", sum(is.na(data_2023)), " many-NAs"))
saveRDS(data_2023, "/home/kfc27/project/ERAProcessingData/StepThreeRHWithIDs/RHDataIds2023.RDS")
data_2023 <- 0



