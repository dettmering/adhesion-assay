###########
# Figures #
###########

# To get the right sorting, you might have to define factors on your own, i.e.
# summary$Metadata_Dose <- factor(summary$Metadata_Dose, levels = C('0Gy', '0,1Gy'))
# and similar for the other data frames "cells", "img" and "nuclei".

library(ggplot2)

pdf(paste0(format(Sys.time(), "%Y-%m-%d"), "_results.pdf"), width = 8.27, height = 5.83)

# EC count vs. PBL count for each image

ggplot(img, aes(x = Count_EC, y = Count_PBL)) +
  geom_point(aes(color = Metadata_Time)) +
  scale_color_discrete(name = "Time") +
  xlab("EC Count") +
  ylab("PBL Count") +
  facet_grid(Metadata_Treatment ~ Metadata_Dose) +
  theme_bw()

# PBL/EC in %, ignores position of PBL

ggplot(summary, aes(x = Metadata_Dose, y = img.PBL_EC_ratio.Mean * 100)) +
  geom_bar(aes(fill = Metadata_Treatment), position = position_dodge(width = 0.9), stat="identity") +
  geom_errorbar(aes(group = Metadata_Treatment, ymin = img.PBL_EC_ratio.Mean * 100 - (img.PBL_EC_ratio.SD / sqrt(n_images) * 100), ymax = img.PBL_EC_ratio.Mean * 100 + (img.PBL_EC_ratio.SD / sqrt(n_images) * 100)), position = position_dodge(width = 0.9), width = 0.1) +
  scale_fill_discrete(name = "Treatment") +
  xlab("Dose (Gy)") +
  ylab("Mean number of PBL per 100 EC") +
  facet_grid(. ~ Metadata_Time) +
  theme_bw()

# PBL count per image, ignores position

ggplot(summary, aes(x = Metadata_Dose, y = img.Count_PBL.Mean)) +
  geom_bar(aes(fill = Metadata_Treatment), position = position_dodge(width = 0.9), stat="identity") +
  geom_errorbar(aes(group = Metadata_Treatment, ymin = img.Count_PBL.Mean - (img.Count_PBL.SD / sqrt(n_images)), ymax = img.Count_PBL.Mean + (img.Count_PBL.SD / sqrt(n_images))), position = position_dodge(width = 0.9), width = 0.1) +
  geom_text(aes(y = 0, label = n_images, group = Metadata_Treatment), size = 3, vjust = -1, position = position_dodge(width = 0.9)) +
  scale_fill_discrete(name = "Treatment") +
  xlab("Dose (Gy)") +
  ylab("Mean number of PBL per image") +
  facet_grid(. ~ Metadata_Time) +
  theme_bw()

ggplot(img, aes(x = Metadata_Dose, y = Count_PBL)) +
  geom_boxplot(aes(fill = Metadata_Treatment), position = position_dodge(width = 0.9)) +
  scale_fill_discrete(name = "Treatment") +
  xlab("Dose (Gy)") +
  ylab("Mean number of PBL per image") +
  facet_grid(. ~ Metadata_Time) +
  theme_bw()

# EC count per dish. Error comes from distribution of EC count per image

ggplot(summary, aes(x = Metadata_Dose, y = EC_per_dish.Mean)) +
  geom_bar(aes(fill = Metadata_Treatment), position = position_dodge(width = 0.9), stat="identity") +
  geom_errorbar(aes(group = Metadata_Treatment, ymin = EC_per_dish.Mean - EC_per_dish.SEM, ymax = EC_per_dish.Mean + EC_per_dish.SEM), position = position_dodge(width = 0.9), width = 0.1) +
  scale_fill_discrete(name = "Treatment") +
  xlab("Dose (Gy)") +
  ylab("Mean number of EC per petri dish") +
  facet_grid(. ~ Metadata_Time) +
  theme_bw()

plot(log10(pbl$Intensity_MeanIntensity_DAPI))
abline(h = PBL.threshold, col = "red")

dev.off()