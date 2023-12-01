library(tidyverse)
library(GEOquery)
library(factoextra)
library(FactoMineR)

# Access file path
fileList <- list.files("./Data/")
filePath <- paste("./Data/", fileList, sep = "")
# Reading the NCBI's GEO microarray SOFT files 
dat.soft <- getGEO(filename = filePath[1])
dat.annot <- getGEO(filename = filePath[2])
# Save to data frame
df.soft <- Table(dat.soft)
df.annot <- Table(dat.annot)
df.txt <- read.table(filePath[3], sep = "\t", header = TRUE, fill = TRUE)
# Analysis of "GDS2808.soft"
disease.state <- dat.soft@dataTable@columns$disease.state
soft.pca <- PCA(df.soft[,2:ncol(df.soft)], graph = FALSE)
