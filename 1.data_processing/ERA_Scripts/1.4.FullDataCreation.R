#Script to finish cleaning and binding all of the dataframes together

data_2019 <- readRDS("/home/kfc27/project/ERAProcessingData/StepThreeRHWithIDs/RHDataIds2019.RDS")
#Get rid of the unncessary columns, lon, lat, Longitude, Latitude, Temperature, DewPoint
data_2019 <- data_2019[, -c(1:5,8)]

#Take the modulus of 24 for hour
data_2019$Hour <- data_2019$Hour %% 24

#Turn Hour into a factor
data_2019$Hour <- as.factor(data_2019$Hour)

#Turn the day into a categorical variable
data_2019$doy <- as.factor(data_2019$doy)

#Now for 2020
data_2020 <- readRDS("/home/kfc27/project/ERAProcessingData/StepThreeRHWithIDs/RHDataIds2020.RDS")
data_2020 <- data_2020[, -c(1:5,8)]
data_2020$Hour <- data_2020$Hour %% 24
data_2020$Hour <- as.factor(data_2020$Hour)
data_2020$doy <- as.factor(data_2020$doy)

#Now we rbind them all together into one data frame
final_era <- rbind(data_2019, data_2020)
data_2019 <- 0
data_2020 <- 0
gc()

data_2021 <- readRDS("/home/kfc27/project/ERAProcessingData/StepThreeRHWithIDs/RHDataIds2021.RDS")
data_2021 <- data_2021[, -c(1:5,8)]
data_2021$Hour <- data_2021$Hour %% 24
data_2021$Hour <- as.factor(data_2021$Hour)
data_2021$doy <- as.factor(data_2021$doy)

final_era <- rbind(final_era, data_2021)
data_2021 <- 0
gc()

data_2022 <- readRDS("/home/kfc27/project/ERAProcessingData/StepThreeRHWithIDs/RHDataIds2022.RDS")
data_2022 <- data_2022[, -c(1:5,8)]
data_2022$Hour <- data_2022$Hour %% 24
data_2022$Hour <- as.factor(data_2022$Hour)
data_2022$doy <- as.factor(data_2022$doy)

#Rbind and free up memory
final_era <- rbind(final_era, data_2022)
data_2022 <- 0
gc()


data_2023 <- readRDS("/home/kfc27/project/ERAProcessingData/StepThreeRHWithIDs/RHDataIds2023.RDS")
data_2023 <- data_2023[, -c(1:5,8)]
data_2023$Hour <- data_2023$Hour %% 24
data_2023$Hour <- as.factor(data_2023$Hour)
data_2023$doy <- as.factor(data_2023$doy)

final_era <- rbind(final_era, data_2023)
data_2023 <- 0
gc()

saveRDS(final_era, "/home/kfc27/project/ERAProcessingData/StepFourCombineDataframes/FullERADataFrame.RDS")





