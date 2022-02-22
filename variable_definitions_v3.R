# Variable definitions
# Add all covariates, exposures and outcomes
# Run this from top to bottom before analysis

# Remove all objects
rm(list=ls())

# Load the data file
#data = readRDS(file = "M:\\Projects\\Ellen\\data\\data_v1.rds")
data = readRDS(file = "/Volumes/benb/Projects/Ellen/data/data_v4.rds")
choose.file()
file.choose()

#psoriasis
table(data$PsorEv_NT3BLQ1)

#eczema
#include
table(data$EczEv_NT3BLQ1)
table(data$EczCh_NT3EczQ)

data$Eczema = NA
data$Eczema[data$EczEv_NT3BLQ1==1 & data$EczCh_NT3EczQ==1] = 1 #1311 EczEv AND EczCh
data$Eczema[data$EczEv_NT3BLQ1==0 & data$EczCh_NT3EczQ==0] = NA #error n=2
data$Eczema[data$EczEv_NT3BLQ1==0 & data$EczCh_NT3EczQ==1] = NA #error n=2
data$Eczema[data$EczEv_NT3BLQ1==0 & data$EczCh_NT3EczQ==2] = NA #error n=2
data$Eczema[is.na(data$EczEv_NT3BLQ1)] = NA #missing EczEv
data$Eczema[data$EczEv_NT3BLQ1==0 & is.na(data$EczCh_NT3EczQ)] = 0 #45016 controls
data$Eczema[data$EczEv_NT3BLQ1==1 & data$EczCh_NT3EczQ==0] = 0 #EczEv yes and EczCh no = control
data$Eczema[data$EczEv_NT3BLQ1==1 & data$EczCh_NT3EczQ==2] = NA #EczEv yes and EczCh do not know = missing
data$Eczema[data$EczEv_NT3BLQ1==1 & is.na(data$EczCh_NT3EczQ)] = NA #EczEv yes and EczCh missing = missing
table(data$Eczema) #1311 cases and 47244 controls

# Age
summary(data$PartAg_NT3BLQ1)

# Sex
table(data$Sex)
data$Sex = data$Sex.x

# BMI
summary(data$BMI_NT3BLM)

#BMI Z score
mean_bmi <- mean(data$BMI_NT3BLM, na.rm = T)
sd_bmi <- sd(data$BMI_NT3BLM, na.rm = T)
data$BMIZSCORE <- ((data$BMI_NT3BLM - mean_bmi)/sd_bmi)

# Smoking
table(data$SmoStat_NT3BLQ1)

# Alcohol frequency
table(data$AlcFLY_NT3BLQ1)

# Work
table(data$WorTitISCO_2_NT3BLI)

#BMI GRS Z score
grsmean <- mean(data$BSCORE)
grstd <- sd(data$BSCORE)
data$BGRSZSCORE <- ((data$BSCORE - grsmean)/grstd)


