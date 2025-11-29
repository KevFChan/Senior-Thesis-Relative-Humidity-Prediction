#This is a script to generate the ERA5 relative humidity values
library(dplyr)
library(lubridate)

#CHANGE THESE TWO
eratemp <- readRDS("/home/kfc27/project/ERAProcessingData/StepTwoCleanedERAData/Temperature/temp_2021.RDS")
eradewpoint <- readRDS("/home/kfc27/project/ERAProcessingData/StepTwoCleanedERAData/Dewpoint/dp_2021.RDS")


#We can actually just cbind them
eramerged <- cbind(eratemp, eradewpoint)
eramerged <- eramerged[!is.na(eramerged$Temperature), ]

#Get the number of NAs
print(paste0("The number of NAs is: ", sum(is.na(eramerged))))

#Do the checks to make sure the cbind is valid
print(paste0("The longitudes have a correlation of: ", cor(eramerged[,1], eramerged[,6])))

print(paste0("The latitudes have a correlation of: ", cor(eramerged[,2], eramerged[,7])))

print(paste0("The hours have a correlation of: ", cor(eramerged[,4], eramerged[,9])))

print(paste0("The dates have this many non-equal entries: ", sum(eramerged[, 5] != eramerged[, 10])))

#Get rid of the extra columns after confirming equivalence
eramerged <- eramerged[, c(1:5, 8)]

#First we will convert the era5 temperature and dewpoint data from kelvin into celsius
eramerged$DewPoint <- eramerged$DewPoint - 273.15
eramerged$Temperature <- eramerged$Temperature - 273.15

#Calculate the relative humidity
#Get the numerator
numerator <- exp((17.625 * eramerged$DewPoint)/(243.04 + eramerged$DewPoint))

denominator <- exp((17.625 * eramerged$Temperature)/(243.04 + eramerged$Temperature))

#Now we calculate relative humidity
eramerged$RelativeHumidity <- 100 * (numerator/denominator)

#Let's get the summaries of the relative humidities
print("Before changing the bounds")
print(summary(eramerged$RelativeHumidity))

#We force all the values over 100 to be exactly 100, do the same for 0
eramerged$RelativeHumidity[eramerged$RelativeHumidity > 100] <- 100
eramerged$RelativeHumidity[eramerged$RelativeHumidity < 0] <- 0

print(head(eramerged))
#So we've fixed it
print(paste0("After changing the bounds"))
print(summary(eramerged$RelativeHumidity))


#Get the minimum and maximum relative humidities for the day
RHera <- eramerged %>%
  group_by(Longitude, Latitude, Date) %>%
  mutate(minRH = min(RelativeHumidity), maxRH = max(RelativeHumidity)) %>%
  ungroup()

#Get the day of year and the year
RHera$doy <- yday(RHera$Date)
RHera$year <- year(RHera$Date)

saveRDS(RHera, "/home/kfc27/project/ERAProcessingData/StepTwoCleanedERAData/RelativeHumidity/eraRH2021.RDS")



