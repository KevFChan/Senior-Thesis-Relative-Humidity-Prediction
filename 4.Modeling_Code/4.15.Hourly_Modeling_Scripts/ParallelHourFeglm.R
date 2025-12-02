#Parallelizing for the fixest models
library(foreach)
library(doParallel)
library(fixest)

#Read in the full dataset
era_data <- readRDS("/home/kfc27/project/CleanedData/ERA5RHModel_Ready/FullERADataFrame.RDS")

#Convert year and id into factors
era_data$year <- as.factor(era_data$year)
era_data$era.id <- as.factor(era_data$era.id)

#########PARALLEL PART

num_cores <- detectCores()

#Parallelize the backend
cl <- makeCluster(num_cores - 1)
registerDoParallel(cl)

fit_feglm <- function(hour){
  feglm_model <- feglm(RelativeHumidity ~ maxRH*doy + maxRH*year + maxRH*era.id +
                         minRH*doy + minRH*year + minRH*era.id, data = hour)
  
  return(feglm_model)
}

feglm_models <- list()

#Loop through each hour and fit the model
hours <- unique(era_data$Hour)
foreach(i = 1:length(hours), .packages = c("fixest")) %dopar% {
  hour <- era_data[era_data$Hour == hours[i], ]
  hour_model <- fit_feglm(hour)
  feglm_models[[i]] <- hour_model
}

#Stop the parallel
stopCluster(cl)
registerDoSEQ()

#Save the models
for(i in 1:length(feglm_models)){
  save(feglm_models[[i]], file = paste0("/home/kfc27/project/HourlyModelingScripts/FeglmHourlyModels/feglmModel_", hours[i], ".Rdata"))
}











