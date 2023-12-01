library(tidyverse)

fileList <- list.files("./Data/")
filePath <- paste("./Data/", fileList, sep = "")
filePath[1]

df.soft <- readLines(filePath[1])
df.soft <- gsub("!", "#", df.soft)
df.soft <- gsub("^", "#", df.soft)
df.soft <- read.table(df.soft, comment.char = "#", header = TRUE, sep = "\t")
