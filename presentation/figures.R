###########
# Figures #
###########

library(ggplot2)

pdf(paste0(format(Sys.time(), "%Y-%m-%d"), "_results.pdf"), width = 5.83, height = 4.13)

# Histogram: PBLs per EC

ggplot(cells, aes(x = Children_PBL_Count)) +
  geom_histogram() +
  xlab("No. of PBL per EC") +
  facet_grid(Metadata_Treatment ~ Metadata_Dose)

# EC count vs. PBL count for each image

ggplot(img, aes(x = Count_EC, y = Count_PBL)) +
  geom_point() +
  xlab("EC Count") +
  ylab("PBL Count") +
  facet_grid(Metadata_Treatment ~ Metadata_Dose) +
  theme_bw()

# PBL/EC in %, ignores position of PBL

ggplot(summary, aes(x = Metadata_Dose, y = img.PBL_EC_ratio.Mean * 100)) +
  geom_bar(aes(fill = Metadata_Treatment), position = position_dodge(width = 0.9), stat="identity") +
  geom_errorbar(aes(group = Metadata_Treatment, ymin = img.PBL_EC_ratio.Mean * 100 - (img.PBL_EC_ratio.SD / sqrt(n_images) * 100), ymax = img.PBL_EC_ratio.Mean * 100 + (img.PBL_EC_ratio.SD / sqrt(n_images) * 100)), position = position_dodge(width = 0.9), width = 0.1) +
  xlab("Dose (Gy)") +
  ylab("Mean number of PBL per EC (%)") +
  theme_bw()

# PBL count per image, ignores position

ggplot(summary, aes(x = Metadata_Dose, y = img.Count_PBL.Mean)) +
  geom_bar(aes(fill = Metadata_Treatment), position = position_dodge(width = 0.9), stat="identity") +
  geom_errorbar(aes(group = Metadata_Treatment, ymin = img.Count_PBL.Mean - (img.Count_PBL.SD / sqrt(n_images)), ymax = img.Count_PBL.Mean + (img.Count_PBL.SD / sqrt(n_images))), position = position_dodge(width = 0.9), width = 0.1) +
  xlab("Dose (Gy)") +
  ylab("Mean number of PBL per image") +
  theme_bw()

# EC count per dish. Error comes from distribution of EC count per image

ggplot(summary, aes(x = Metadata_Dose, y = EC_per_dish.Mean)) +
  geom_bar(aes(fill = Metadata_Treatment), position = position_dodge(width = 0.9), stat="identity") +
  geom_errorbar(aes(group = Metadata_Treatment, ymin = EC_per_dish.Mean - EC_per_dish.SEM, ymax = EC_per_dish.Mean + EC_per_dish.SEM), position = position_dodge(width = 0.9), width = 0.1) +
  xlab("Dose (Gy)") +
  ylab("Mean number of EC per petri dish") +
  theme_bw()

dev.off()