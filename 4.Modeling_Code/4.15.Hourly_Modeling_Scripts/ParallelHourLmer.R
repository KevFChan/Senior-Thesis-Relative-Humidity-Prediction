#We will aim to parallelize our data
library(foreach)
library(doParallel)
library(lme4)

#Read in the full dataset
era_data <- readRDS("/home/kfc27/project/ERAProcessingData/StepFourCombineDataframes/FullERADataFrame.RDS")
era_data <- era_data[order(era_data$era.id, era_data$Date, era_data$Hour), ]

#Convert year and id into factors
era_data$year <- as.factor(era_data$year)
era_data$era.id <- as.factor(era_data$era.id)

#########PARALLEL PART

num_cores <- 4

#Parallelize the backend
cl <- makeCluster(num_cores)
registerDoParallel(cl)

#Define the lmer function based on the hour
fit_lmer <- function(hour){
  lmer_model <- lmer(RelativeHumidity ~ maxRH + (maxRH|doy) + (maxRH|year) + (maxRH|era.id) +
                       minRH + (minRH|doy) + (minRH|year) + (minRH|era.id), data = hour)
  
  return(lmer_model)
}

#Create a list to store the models
lmer_models <- list()

#Loop through each hour and fit the model
hours <- unique(era_data$Hour)
foreach(i = 1:length(hours), .packages = c("lme4")) %dopar% {
  hour <- era_data[era_data$Hour == hours[i], ]
  hour_model <- fit_lmer(hour)
  lmer_models[[i]] <- hour_model
}

#Stop the parallel
stopCluster(cl)
registerDoSEQ()

#Save the models, we can do this since the models correspond with the hours
for(i in 1:length(lmer_models)){
  save(lmer_models[[i]], file = paste0("/home/kfc27/project/ERAProcessingScripts/StepFiveModelGeneration/ParallelLmerModels/lmerModel_", hours[i], ".Rdata"))
}









