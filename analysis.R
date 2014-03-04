###############################
### Adhesion assay analysis ###
###############################

# You have to set the directory of the CellProfiler output with setwd("FOLDER"), e.g. setwd("D:/cellprofilerresult/")

# Read CellProfiler results

img <- read.csv("DefaultOUT_Image.csv")
cells <- read.csv("DefaultOUT_Cells.csv")
nuc <- read.csv("DefaultOUT_Nuclei.csv")
pbl <- read.csv("DefaultOUT_PBL.csv")

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

# Set columns of interest

col <- c(
  'Count_Cells',
  'Count_EC',
  'Count_PBL',
  'PBL_EC_ratio',
  'EC_per_cm2'
)

# Variables

width.um <- 1270.69
height.um <- 949.13
width.px <- 1392
height.px <- 1040

Image_area_cm2 <- width.um * height.um / 10^8
Pixel_area_um2 <- (width.um * height.um) / (width.px * height.px)
Petridish_area_cm2 <- 9.621128 # (3.5/2)^2 * pi

img$Count_EC <- img$Count_Cells - img$Count_PBL
img$PBL_EC_ratio <- img$Count_PBL / img$Count_EC
img$EC_per_cm2 <- img$Count_EC / Image_area_cm2

# Classify PBL by size

pbl[pbl[,'AreaShape_Area'] >= median(pbl$AreaShape_Area) + sd(pbl$AreaShape_Area), 'Size'] <- 'large'
pbl[pbl[,'AreaShape_Area'] < median(pbl$AreaShape_Area) + sd(pbl$AreaShape_Area), 'Size'] <- 'small'

##########################################################
# Calculate percentage translocated and other parameters #
##########################################################

summary <- generateList(cells, classifiers)

i <- 0
j <- NULL

for (i in 1:length(summary$n)) {
  cells.subset <- merge(cells, summary[i, classifiers])
  img.subset <- merge(img, summary[i, classifiers])
  
  summary[i, 'n_images'] <- length(img.subset$ImageNumber)
  
  for (j in col) {
    summary[i, paste0(j, '.Sum')] <- sum(img.subset[, j])
    summary[i, paste0(j, '.Median')] <- median(img.subset[, j])
    summary[i, paste0(j, '.Mean')] <- mean(img.subset[, j])
    summary[i, paste0(j, '.SD')] <- sd(img.subset[, j])
  }
}

summary$EC_per_dish.Mean <- summary$EC_per_cm2.Mean * Petridish_area_cm2
summary$EC_per_dish.SD <- summary$EC_per_cm2.SD * Petridish_area_cm2

# Export raw data and summary table to csv (working directory)

write.csv(img, paste0(format(Sys.time(), "%Y-%m-%d"), "_rawdata-img.csv"), row.names = F)
write.csv(cells, paste0(format(Sys.time(), "%Y-%m-%d"), "_rawdata.csv"), row.names = F)
write.csv(summary, paste0(format(Sys.time(), "%Y-%m-%d"), "_results.csv"), row.names = F)

# remove temporary variables

rm(i, j, cells.subset, img.subset)

###########
# Figures #
###########

library(ggplot2)

pdf(paste0(format(Sys.time(), "%Y-%m-%d"), "_results.pdf"), width = 5.83, height = 4.13)

ggplot(cells, aes(x = Children_PBL_Count)) +
  geom_histogram() +
  facet_grid(Metadata_Treatment ~ Metadata_Dose)

ggplot(summary, aes(x = Metadata_Dose, y = PBL_EC_ratio.Mean * 100)) +
  geom_bar(aes(fill = Metadata_Treatment), position = position_dodge(width = 0.9), stat="identity") +
  geom_errorbar(aes(group = Metadata_Treatment, ymin = PBL_EC_ratio.Mean * 100 - PBL_EC_ratio.SD * 100, ymax = PBL_EC_ratio.Mean * 100 + PBL_EC_ratio.SD * 100), position = position_dodge(width = 0.9), width = 0.1) +
  xlab("Dose (Gy)") +
  ylab("Mean number of PBL per EC (%)") +
  theme_bw()

ggplot(summary, aes(x = Metadata_Dose, y = EC_per_dish.Mean)) +
  geom_bar(aes(fill = Metadata_Treatment), position = position_dodge(width = 0.9), stat="identity") +
  geom_errorbar(aes(group = Metadata_Treatment, ymin = EC_per_dish.Mean - EC_per_dish.SD, ymax = EC_per_dish.Mean + EC_per_dish.SD), position = position_dodge(width = 0.9), width = 0.1) +
  xlab("Dose (Gy)") +
  ylab("Mean number of EC per petri dish") +
  theme_bw()

dev.off()