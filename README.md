# Senior-Thesis-Relative-Humidity-Prediction
Code for predicting relative humidity over Connecticut from 2019-2023 on the hourly, 1-km scale

# High-Resolution Hourly Relative Humidity Estimation for Connecticut

## 📌 Project Overview
This project generates **hourly 1 km × 1 km relative humidity estimates** across the state of Connecticut using a combination of:
- Weather station observations
- Meteorological satellite remote sensing data (MODIS Terra/Aqua)
- ERA5-Land reanalysis data
- Random forest models and linear mixed/fixed effects models

The resulting dataset is intended for future **CHEN Lab** research projects involving the state of Connecticut.

### **Workflow Summary**
1. Collect hourly weather station relative humidity observations and extract daily maximum & minimum values.
2. Use MODIS satellite data (Terra & Aqua) to train **random forest models** that predict daily RH max/min statewide.
3. Train **24 linear fixed effects models** and **24 linear mixed effects models**, one for each hour, using ERA5 hourly RH and the random forest daily estimates.
4. Apply the trained models to produce spatially-continuous **hourly predictions** over CT.
5. **UPDATE 2025** Used neural networks in "RH_Harmonic_NN_Prediction.ipynb" to achieve R-squared of 0.80 and RMSE of 9.22%.

---

## 🧠 **Purpose**
This documentation explains the structure and purpose of each folder and file in the repository to **future-proof the project** and ensure reproducibility for future CHEN lab collaborators and researchers.

---

## 🗂 **Repository Structure**

### **0.raw_data** — Raw meteorological & satellite data
- **0.2.1.LST_MOD11A1** — MODIS Terra daytime/nighttime land surface temperature (500 m)
- **0.2.2.LST_MYD11A1** — MODIS Aqua temperature (500 m)
- **0.3.ERA5** — Cleaned hourly dewpoint & temperature from ERA5-Land (10 km)
- **0.3.ERA5_old** — Original untouched ERA5 files
- **0.4.Elevation** — ASTGTM elevation (30 m resolution)
- **0.5.Greenness** — MODIS vegetation indices (EVI/NDVI/VI, 1 km monthly)
- **0.6.Land_use_type** — Land cover classifications (17 classes → reduced to 5)
- **0.7.Color_band** — MOD09 color bands (b01 red, b03 blue, b04 green, daily)
- **0.8.PrecipitationSolarWind** — Processed daily PSW variables (precip, solar radiation, wind)
- **0.8.PrecipitationSolarWind_old** — Unprocessed monthly downloads
- **0.tl_2020_us_state** — Connecticut shapefile boundaries
- **A.Support files** — Notes and extraction metadata

---

### **1.data_processing** — Data cleaning & preparation
Scripts used to convert raw data into structured RDS files used for modeling.

- **ERA_Scripts** — Process hourly ERA dewpoint/temperature into RH
- **1.1.ERA_Dewpoint_Temp/** — Cleaning to CSV format
- **1.15.Temp_DP_Cleaning.Rmd** — CSV → RDS conversion
- **1.2.Relative_Humidity_Scripts/** — Calculate hourly RH
- **1.3.Merging_RH_Grid_Ids.R** — Apply ERA & CT 1 km ID mapping
- **1.4.FullDataCreation.R** — Merge processed RH files

Additional processing:
- **ASTGTM, MCD12Q1, MOD13A3, MOD09 cleaning Rmd files** for elevation, land use, vegetation, and color band processing
- **HOBO_Monitor_Cleaning.Rmd** — Cleaning of 2024 HOBO monitor RH data

#### **PSW Processing**
Located under PSW_Processing:
- **1.0.PSW_2019_Processing.Rmd** — Structure exploration
- **1.1.PSW_Processing_Full_Loop.Rmd** — Create daily avg/min/max PSW files
- **1.2.Separating_PSW_Data.Rmd** — Organize outputs into folders
- **1.3.PSW_Cleaning_For_Merging.Rmd** — Clean PSW values for merging with weather stations
- **1.4.PSW_ERA_Merging.Rmd** — Consolidate multi-year PSW data
- **1.5.PSW_Weather_Station_Merging.Rmd** — Join PSW with weather stations

#### **Color Band Processing**
- **1.0.Color_Band_Exploration.Rmd**
- **1.1.Color_Band_Processing.Rmd**
- **1.2.Color_Band_Weather_Station_Merging.Rmd**

---

### **2.data_cleaning_code**
Proof-of-concept scripts; **can be ignored**.

---

### **3.cleaned_data**
RDS cleaned datasets
- **Cleaned_Data_For_Weather_Stations/**
- **ERA_precipitation, ERA_solar_radiation, ERA_wind** — Daily aggregated PSW variables
- **MOD11A1 / MYD11A1 daytime/nighttime RDS data**
- **Elevation_Data.RDS**, **NDVI/EVI/VI RDS files**, **Land_Cover_Data**
- **MOD09GA color band RDS files**

---

### **4.Modeling_Code**
Modeling scripts and Rmd notebooks
- **4.1.RF_PSW_Color_band.Rmd** — Random forest RH daily prediction (with PSW & color band)
- **4.15.Hourly_Modeling_Scripts/** — Mixed/fixed hourly models
- **4.2.RF_To_Lmer_Models.Rmd** — Apply Lmer models to RF predicted data (R² ≈ 0.059)
- **4.3.RF_To_Feglm_Models.Rmd** — Apply Feglm models (R² ≈ 0.326)
- **4.4.Feglm_Hour_Variable.Rmd** — Proposed improvements for future modeling

---

### **5.modeling_data** — Output & model artifacts
- **5.1.Full_ERA_Data_Frame.RDS** — Full ERA hourly RH dataset
- **5.2.RF_predicted_data_with_PSW_Color.rds**
- **LmerModels/** — 24 hourly mixed effects models
- **FeglmModels/** — 24 hourly fixed effects models
- **HOBO_Monitor_Data/** — RH monitors placed in Morse College & Hamden
- **RH_Daily_Min_Random_Forest_Model.rds / RH_Daily_Max_Random_Forest_Model.rds**

---

## 🛠 Software & Dependencies (to be expanded)
```r
R version >= 4.2
packages: tidyverse, raster, terra, randomForest, lme4, fixest, data.table, parallel
