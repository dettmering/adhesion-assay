###############################
### Adhesion assay analysis ###
###############################

# You have to set the directory of the CellProfiler output with setwd("FOLDER"), e.g. setwd("D:/cellprofilerresult/")

# Read CellProfiler results

img <- read.csv("Image.csv")
pbl <- read.csv("PBL.csv")

# Load sources

library(devtools) # needed for https source from github

source_url('https://raw.github.com/tdett/r-helpers/master/generateList.R')

# Set classifiers

classifiers <- c(
  'Metadata_Celltype',
  'Metadata_Time',
  'Metadata_Dose',
  'Metadata_Treatment'
)

# Set columns of interest c('Column', 'dataframe')

columns <- rbind(
  c('Count_Cells', 'img'),
  c('Count_EC', 'img'),
  c('Count_PBL', 'img'),
  c('PBL_EC_ratio', 'img'),
  c('EC_per_cm2', 'img'),
  c('has.nucleus', 'pbl')
)

# Variables

# These values are for a Leica TCS SPE, 10x objective

width.um <- 1270.69
height.um <- 949.13
width.px <- 1392
height.px <- 1040

# Calculations on the image area etc.

Image_area_cm2 <- width.um * height.um / 10^8
Pixel_area_um2 <- (width.um * height.um) / (width.px * height.px)
Petridish_area_cm2 <- 9.621128 # (3.5/2)^2 * pi

# Calculations for whole image

img$Count_EC <- img$Count_Cells - img$Count_PBL
img$PBL_EC_ratio <- img$Count_PBL / img$Count_EC
img$EC_per_cm2 <- img$Count_EC / Image_area_cm2

#####################
# Calculate results #
#####################

# We assume a CV of 15% for DAPI intensity in order to determine if a detected PBL has a nucleus

PBL.threshold <- (median(log10(pbl$Intensity_MeanIntensity_DAPI)) + (median(log10(pbl$Intensity_MeanIntensity_DAPI)) * 0.15 * 2))
pbl$has.nucleus <- log10(pbl$Intensity_MeanIntensity_DAPI) > PBL.threshold

# Generate grouping list

summary <- generateList(img, classifiers)

i <- 0
j <- 0
k <- 0

# This is complicated, but needed to be flexible. This calculates summary statistics for certain columns in certain data frames, given in the 'columns' list.

for (i in 1:length(summary$n)) {
  for (k in unique(columns[, 2])) { # generate subset dataframes
    assign(paste0(k, '.subset'), merge(get(k), summary[i, classifiers]))
  }
  
  summary[i, 'n_images'] <- length(img.subset$ImageNumber)
  
  for (j in 1:length(columns[, 1])) {
    summary[i, paste0(columns[j, 2], '.', columns[j, 1], '.Sum')] <- sum(get(paste0(columns[j, 2], '.subset'))[, columns[j, 1]])
    summary[i, paste0(columns[j, 2], '.', columns[j, 1], '.Median')] <- median(get(paste0(columns[j, 2], '.subset'))[, columns[j, 1]])
    summary[i, paste0(columns[j, 2], '.', columns[j, 1], '.Mean')] <- mean(get(paste0(columns[j, 2], '.subset'))[, columns[j, 1]])
    summary[i, paste0(columns[j, 2], '.', columns[j, 1], '.SD')] <- sd(get(paste0(columns[j, 2], '.subset'))[, columns[j, 1]])
  }
}

summary$PBL_with_nuclei.Percent <- summary$pbl.has.nucleus.Sum / summary$img.Count_PBL.Sum * 100

summary$EC_per_dish.Mean <- summary$img.EC_per_cm2.Mean * Petridish_area_cm2
summary$EC_per_dish.SD <- summary$img.EC_per_cm2.SD * Petridish_area_cm2
summary$EC_per_dish.SEM <- summary$EC_per_dish.SD / sqrt(summary$n_images)
summary$EC_per_dish.SEM.Percent <- summary$EC_per_dish.SEM / summary$EC_per_dish.Mean * 100

# Export raw data and summary table to csv (working directory)

timestamp <- format(Sys.time(), "%Y-%m-%d")

write.csv(img, paste0(timestamp, "_rawdata-img.csv"), row.names = F)
write.csv(summary, paste0(timestamp, "_results.csv"), row.names = F)

# remove temporary variables

rm(i, j, img.subset)
