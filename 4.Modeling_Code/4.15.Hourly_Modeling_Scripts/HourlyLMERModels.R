#This script will run the lmer model on the ERA5 data and save it
library(lme4)
library(fixest)

#Read in the full dataset
era_data <- readRDS("/home/kfc27/project/CleanedData/ERA5RHModel_Ready/FullERADataFrame.RDS")


#Convert the year and era.id into factors
era_data$year <- as.factor(era_data$year)
era_data$era.id <- as.factor(era_data$era.id)

#Now we create 24 models
hour0 <- era_data[era_data$Hour == 0, ]
hour1 <- era_data[era_data$Hour == 1, ]
hour2 <- era_data[era_data$Hour == 2, ]
hour3 <- era_data[era_data$Hour == 3, ]
hour4 <- era_data[era_data$Hour == 4, ]
hour5 <- era_data[era_data$Hour == 5, ]
hour6 <- era_data[era_data$Hour == 6, ]
hour7 <- era_data[era_data$Hour == 7, ]
hour8 <- era_data[era_data$Hour == 8, ]
hour9 <- era_data[era_data$Hour == 9, ]
hour10 <- era_data[era_data$Hour == 10, ]
hour11 <- era_data[era_data$Hour == 11, ]
hour12 <- era_data[era_data$Hour == 12, ]
hour13 <- era_data[era_data$Hour == 13, ]
hour14 <- era_data[era_data$Hour == 14, ]
hour15 <- era_data[era_data$Hour == 15, ]
hour16 <- era_data[era_data$Hour == 16, ]
hour17 <- era_data[era_data$Hour == 17, ]
hour18 <- era_data[era_data$Hour == 18, ]
hour19 <- era_data[era_data$Hour == 19, ]
hour20 <- era_data[era_data$Hour == 20, ]
hour21 <- era_data[era_data$Hour == 21, ]
hour22 <- era_data[era_data$Hour == 22, ]
hour23 <- era_data[era_data$Hour == 23, ]

#Now we create 24 models
lmer12AM <- lmer(RelativeHumidity ~ maxRH + (maxRH|doy) + (maxRH|year) + (maxRH|era.id) +
                minRH + (minRH|doy) + (minRH|year) + (minRH|era.id), data = hour0)

lmer1AM <- lmer(RelativeHumidity ~ maxRH + (maxRH|doy) + (maxRH|year) + (maxRH|era.id) +
                   minRH + (minRH|doy) + (minRH|year) + (minRH|era.id), data = hour1)

lmer2AM <- lmer(RelativeHumidity ~ maxRH + (maxRH|doy) + (maxRH|year) + (maxRH|era.id) +
                  minRH + (minRH|doy) + (minRH|year) + (minRH|era.id), data = hour2)

lmer3AM <- lmer(RelativeHumidity ~ maxRH + (maxRH|doy) + (maxRH|year) + (maxRH|era.id) +
                  minRH + (minRH|doy) + (minRH|year) + (minRH|era.id), data = hour3)

lmer4AM <- lmer(RelativeHumidity ~ maxRH + (maxRH|doy) + (maxRH|year) + (maxRH|era.id) +
                  minRH + (minRH|doy) + (minRH|year) + (minRH|era.id), data = hour4)

lmer5AM <- lmer(RelativeHumidity ~ maxRH + (maxRH|doy) + (maxRH|year) + (maxRH|era.id) +
                  minRH + (minRH|doy) + (minRH|year) + (minRH|era.id), data = hour5)

lmer6AM <- lmer(RelativeHumidity ~ maxRH + (maxRH|doy) + (maxRH|year) + (maxRH|era.id) +
                  minRH + (minRH|doy) + (minRH|year) + (minRH|era.id), data = hour6)

lmer7AM <- lmer(RelativeHumidity ~ maxRH + (maxRH|doy) + (maxRH|year) + (maxRH|era.id) +
                  minRH + (minRH|doy) + (minRH|year) + (minRH|era.id), data = hour7)

lmer8AM <- lmer(RelativeHumidity ~ maxRH + (maxRH|doy) + (maxRH|year) + (maxRH|era.id) +
                  minRH + (minRH|doy) + (minRH|year) + (minRH|era.id), data = hour8)

lmer9AM <- lmer(RelativeHumidity ~ maxRH + (maxRH|doy) + (maxRH|year) + (maxRH|era.id) +
                  minRH + (minRH|doy) + (minRH|year) + (minRH|era.id), data = hour9)

lmer10AM <- lmer(RelativeHumidity ~ maxRH + (maxRH|doy) + (maxRH|year) + (maxRH|era.id) +
                  minRH + (minRH|doy) + (minRH|year) + (minRH|era.id), data = hour10)

lmer11AM <- lmer(RelativeHumidity ~ maxRH + (maxRH|doy) + (maxRH|year) + (maxRH|era.id) +
                  minRH + (minRH|doy) + (minRH|year) + (minRH|era.id), data = hour11)

lmer12PM <- lmer(RelativeHumidity ~ maxRH + (maxRH|doy) + (maxRH|year) + (maxRH|era.id) +
                  minRH + (minRH|doy) + (minRH|year) + (minRH|era.id), data = hour12)

lmer1PM <- lmer(RelativeHumidity ~ maxRH + (maxRH|doy) + (maxRH|year) + (maxRH|era.id) +
                  minRH + (minRH|doy) + (minRH|year) + (minRH|era.id), data = hour13)

lmer2PM <- lmer(RelativeHumidity ~ maxRH + (maxRH|doy) + (maxRH|year) + (maxRH|era.id) +
                  minRH + (minRH|doy) + (minRH|year) + (minRH|era.id), data = hour14)

lmer3PM <- lmer(RelativeHumidity ~ maxRH + (maxRH|doy) + (maxRH|year) + (maxRH|era.id) +
                  minRH + (minRH|doy) + (minRH|year) + (minRH|era.id), data = hour15)

lmer4PM <- lmer(RelativeHumidity ~ maxRH + (maxRH|doy) + (maxRH|year) + (maxRH|era.id) +
                  minRH + (minRH|doy) + (minRH|year) + (minRH|era.id), data = hour16)

lmer5PM <- lmer(RelativeHumidity ~ maxRH + (maxRH|doy) + (maxRH|year) + (maxRH|era.id) +
                  minRH + (minRH|doy) + (minRH|year) + (minRH|era.id), data = hour17)

lmer6PM <- lmer(RelativeHumidity ~ maxRH + (maxRH|doy) + (maxRH|year) + (maxRH|era.id) +
                  minRH + (minRH|doy) + (minRH|year) + (minRH|era.id), data = hour18)

lmer7PM <- lmer(RelativeHumidity ~ maxRH + (maxRH|doy) + (maxRH|year) + (maxRH|era.id) +
                  minRH + (minRH|doy) + (minRH|year) + (minRH|era.id), data = hour19)

lmer8PM <- lmer(RelativeHumidity ~ maxRH + (maxRH|doy) + (maxRH|year) + (maxRH|era.id) +
                  minRH + (minRH|doy) + (minRH|year) + (minRH|era.id), data = hour20)

lmer9PM <- lmer(RelativeHumidity ~ maxRH + (maxRH|doy) + (maxRH|year) + (maxRH|era.id) +
                  minRH + (minRH|doy) + (minRH|year) + (minRH|era.id), data = hour21)

lmer10PM <- lmer(RelativeHumidity ~ maxRH + (maxRH|doy) + (maxRH|year) + (maxRH|era.id) +
                  minRH + (minRH|doy) + (minRH|year) + (minRH|era.id), data = hour22)

lmer11PM <- lmer(RelativeHumidity ~ maxRH + (maxRH|doy) + (maxRH|year) + (maxRH|era.id) +
                   minRH + (minRH|doy) + (minRH|year) + (minRH|era.id), data = hour23)


#Now we can save the model to use later on the satellite data
save(lmer12AM, "/home/kfc27/project/HourlyModelingScripts/LmerHourlyModels/lmerModel_12AM.Rdata")
save(lmer1AM, "/home/kfc27/project/HourlyModelingScripts/LmerHourlyModels/lmerModel_1AM.Rdata")
save(lmer2AM, "/home/kfc27/project/HourlyModelingScripts/LmerHourlyModels/lmerModel_2AM.Rdata")
save(lmer3AM, "/home/kfc27/project/HourlyModelingScripts/LmerHourlyModels/lmerModel_3AM.Rdata")
save(lmer4AM, "/home/kfc27/project/HourlyModelingScripts/LmerHourlyModels/lmerModel_4AM.Rdata")
save(lmer5AM, "/home/kfc27/project/HourlyModelingScripts/LmerHourlyModels/lmerModel_5AM.Rdata")
save(lmer6AM, "/home/kfc27/project/HourlyModelingScripts/LmerHourlyModels/lmerModel_6AM.Rdata")
save(lmer7AM, "/home/kfc27/project/HourlyModelingScripts/LmerHourlyModels/lmerModel_7AM.Rdata")
save(lmer8AM, "/home/kfc27/project/HourlyModelingScripts/LmerHourlyModels/lmerModel_8AM.Rdata")
save(lmer9AM, "/home/kfc27/project/HourlyModelingScripts/LmerHourlyModels/lmerModel_9AM.Rdata")
save(lmer10AM, "/home/kfc27/project/HourlyModelingScripts/LmerHourlyModels/lmerModel_10AM.Rdata")
save(lmer11AM, "/home/kfc27/project/HourlyModelingScripts/LmerHourlyModels/lmerModel_11AM.Rdata")
save(lmer12PM, "/home/kfc27/project/HourlyModelingScripts/LmerHourlyModels/lmerModel_12PM.Rdata")
save(lmer1PM, "/home/kfc27/project/HourlyModelingScripts/LmerHourlyModels/lmerModel_1PM.Rdata")
save(lmer2PM, "/home/kfc27/project/HourlyModelingScripts/LmerHourlyModels/lmerModel_2PM.Rdata")
save(lmer3PM, "/home/kfc27/project/HourlyModelingScripts/LmerHourlyModels/lmerModel_3PM.Rdata")
save(lmer4PM, "/home/kfc27/project/HourlyModelingScripts/LmerHourlyModels/lmerModel_4PM.Rdata")
save(lmer5PM, "/home/kfc27/project/HourlyModelingScripts/LmerHourlyModels/lmerModel_5PM.Rdata")
save(lmer6PM, "/home/kfc27/project/HourlyModelingScripts/LmerHourlyModels/lmerModel_6PM.Rdata")
save(lmer7PM, "/home/kfc27/project/HourlyModelingScripts/LmerHourlyModels/lmerModel_7PM.Rdata")
save(lmer8PM, "/home/kfc27/project/HourlyModelingScripts/LmerHourlyModels/lmerModel_8PM.Rdata")
save(lmer9PM, "/home/kfc27/project/HourlyModelingScripts/LmerHourlyModels/lmerModel_9PM.Rdata")
save(lmer10PM, "/home/kfc27/project/HourlyModelingScripts/LmerHourlyModels/lmerModel_10PM.Rdata")
save(lmer11PM, "/home/kfc27/project/HourlyModelingScripts/LmerHourlyModels/lmerModel_11PM.Rdata")





