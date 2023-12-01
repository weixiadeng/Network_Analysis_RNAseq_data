library(tidyverse)
library(GEOquery)

# Access file path
fileList <- list.files("./Data/")
filePath <- paste("./Data/", fileList, sep = "")
# Reading the NCBI's GEO microarray SOFT files 
dat.soft <- getGEO(filename = filePath[1])
dat.annot <- getGEO(filename = filePath[2])
# Save to data frame
df.soft <- Table(dat.soft)
df.annot <- Table(dat.annot)
df.txt <- read.table(filePath[3], sep = "\t",
                      header = TRUE, fill = TRUE)

