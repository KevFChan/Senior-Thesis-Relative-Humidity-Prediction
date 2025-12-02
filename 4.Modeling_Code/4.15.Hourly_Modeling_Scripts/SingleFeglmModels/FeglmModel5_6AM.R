#ERA Hourly Modeling for 5 and 6 AM

library(fixest)

#Load in the data
era_data <- readRDS("/home/kfc27/project/ERAProcessingData/StepFourCombineDataframes/FullERADataFrame.RDS")
era_data <- era_data[order(era_data$era.id, era_data$Date, era_data$Hour), ]

#Convert year and id into factors
era_data$year <- as.factor(era_data$year)
era_data$era.id <- as.factor(era_data$era.id)

#Subset the data to the correct hour, CHANGE THIS
hour1 <- era_data[era_data$Hour == 5, ]
hour2 <- era_data[era_data$Hour == 6, ]

#Create the model, CHANGE THIS
model1 <- feglm(RelativeHumidity ~ maxRH*doy + maxRH*year + maxRH*era.id + 
                  minRH*doy + minRH*year + minRH*era.id, data = hour1, family = "gaussian")

model2 <- feglm(RelativeHumidity ~ maxRH*doy + maxRH*year + maxRH*era.id + 
                 minRH*doy + minRH*year + minRH*era.id, data = hour2, family = "gaussian")

#Now we save this model, CHANGE THIS
save(model1, file = "/home/kfc27/project/ERAProcessingData/StepFiveSavedModels/FeglmModels/feglmModel_5AM.Rdata")
save(model2, file = "/home/kfc27/project/ERAProcessingData/StepFiveSavedModels/FeglmModels/feglmModel_6AM.Rdata")
