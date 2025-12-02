#ERA Hourly Modeling for 5 and 6 PM

library(lme4)

#Load in the data
era_data <- readRDS("/home/kfc27/project/ERAProcessingData/StepFourCombineDataframes/FullERADataFrame.RDS")
era_data <- era_data[order(era_data$era.id, era_data$Date, era_data$Hour), ]

#Convert year and id into factors
era_data$year <- as.factor(era_data$year)
era_data$era.id <- as.factor(era_data$era.id)

#Subset the data to the correct hour, CHANGE THIS
hour1 <- era_data[era_data$Hour == 17, ]
hour2 <- era_data[era_data$Hour == 18, ]

#Create the model, CHANGE THIS
model1 <- lmer(RelativeHumidity ~ maxRH + (maxRH|doy) + (maxRH|year) + (maxRH|era.id) +
                minRH + (minRH|doy) + (minRH|year) + (minRH|era.id), data = hour1)

model2 <- lmer(RelativeHumidity ~ maxRH + (maxRH|doy) + (maxRH|year) + (maxRH|era.id) +
                 minRH + (minRH|doy) + (minRH|year) + (minRH|era.id), data = hour2)

#Now we save this model, CHANGE THIS
save(model1, file = "/home/kfc27/project/ERAProcessingData/StepFiveSavedModels/LmerModels/lmeModel_5PM.Rdata")
save(model2, file = "/home/kfc27/project/ERAProcessingData/StepFiveSavedModels/LmerModels/lmeModel_6PM.Rdata")


