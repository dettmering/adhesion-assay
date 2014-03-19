### Compare manual counts with automated counts

# Please load manual counts into variable 'm'
# Please load automatic counts (cellProfiler Image.txt) into variable 'a'

# Convert factors to characters

m$FileName_DAPI <- as.character(m$FileName_DAPI)
a$FileName_DAPI <- as.character(a$FileName_DAPI)

m$Manual_PercentPositive <- m$Manual_Count_PBL / m$Manual_Count_Nuclei * 100

i <- 0

for (i in 1:length(m$FileName_DAPI)) {
  m[i, 'Auto_Count_Nuclei'] <- a[a$FileName_DAPI == m[i, 'FileName_DAPI'], 'Count_Nuclei']
  m[i, 'Auto_Count_PBL'] <- a[a$FileName_DAPI == m[i, 'FileName_DAPI'], 'Count_PBL']
}

m$Auto_PercentPositive <- m$Auto_Count_PBL / m$Auto_Count_Nuclei * 100

m$Ratio_Nuclei <- m$Auto_Count_Nuclei / m$Manual_Count_Nuclei
m$Difference_Nuclei <- m$Auto_Count_Nuclei - m$Manual_Count_Nuclei

m$Ratio_PBL <- m$Auto_Count_PBL / m$Manual_Count_PBL
m$Difference_PBL <- m$Auto_Count_PBL - m$Manual_Count_PBL

# Compare end point: Percent Macrophages

m$Ratio_Percentage <- m$Auto_PercentPositive / m$Manual_PercentPositive
m$Difference_Percentage <- m$Auto_PercentPositive - m$Manual_PercentPositive

# Plot results

boxplot(m$Ratio_Nuclei ~ m$Morphology, ylab = "Nuclei Count")
boxplot(m$Ratio_PBL ~ m$Morphology, ylab = "PBL Count")
boxplot(m$Ratio_Percentage ~ m$Morphology, ylab = "Percent Macrophages")

wilcox.test(m$Ratio_Nuclei ~ m$Morphology)
wilcox.test(m$Ratio_PBL ~ m$Morphology)
wilcox.test(m$Ratio_Percentage ~ m$Morphology)

# Print values

message(paste(mean(m$Ratio_Nuclei), '+/-' , sd(m$Ratio_Nuclei), 'Nuclei'))
message(paste(mean(m$Ratio_PBL), '+/-' , sd(m$Ratio_PBL), 'PBL'))
message(paste(mean(m$Ratio_Percentage), '+/-' , sd(m$Ratio_Percentage), 'Percent positive'))