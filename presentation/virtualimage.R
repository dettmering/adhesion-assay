# Generate virtual respresentations of all images

library(ggplot2)

VirtualImg <- function(ImgNo) {
  nuc.image <- subset(nuc, ImageNumber == ImgNo)
  cells.image <- subset(cells, ImageNumber == ImgNo)
  try(pbl.image <- subset(pbl, ImageNumber == ImgNo))
  
  plottitle <- as.character(img[img$ImageNumber == ImgNo, 'FileName_DAPI'])
  
  ggplot(nuc.image, aes(x = Location_Center_X, y = Location_Center_Y)) +
    geom_point(data = cells.image, color = "grey", aes(size = (AreaShape_MajorAxisLength / 2)^2 * pi)) +
    geom_point(color = "blue", aes(size = AreaShape_Area)) +
    geom_point(data = pbl.image, color = "green") +
    scale_y_continuous(limits = c(0, height.px)) +
    scale_x_continuous(limits = c(0, width.px)) +
    scale_size_area(guide = FALSE) +
    ggtitle(plottitle) +
    xlab("X (px)") +
    ylab("Y (px)") +
    coord_equal() +
    theme_bw()
}

pdf(paste0(format(Sys.time(), "%Y-%m-%d"), "_virtualimages.pdf"), width = 5.83, height = 4.13)

for (i in img$ImageNumber) {
  try(print(VirtualImg(i)))
}

dev.off()