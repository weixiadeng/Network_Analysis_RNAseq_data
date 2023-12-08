library(tidyverse)
library(GEOquery)
library(GENIE3)
library(missMDA)
library(impute)

# Access file path
fileList <- list.files("./Data/")
filePath <- paste("./Data/", fileList, sep = "")
# Reading the NCBI's GEO microarray SOFT files 
dat.soft <- getGEO(filename = filePath[1])
# Access sample disease state (control vs ill)
disease.state <- dat.soft@dataTable@columns$disease.state
# Save to data frame
df.soft <- Table(dat.soft)
# Subset for expression data
exprDat <- df.soft[,3:ncol(df.soft)] %>% data.matrix()
# Remove genes appears less than 50% across all sample
idx.row <- c(); nsamp <- ncol(exprDat)
for (i in 1:nrow(exprDat)){
  idx.row[i] <- (is.na(exprDat[i,]) %>% sum()) / nsamp
}
exprDat <- exprDat[(idx.row < 0.5),]
# Subset the genes identifiers after remove less than 50% across all sample
geneID <- df.soft[(idx.row < 0.5), 1:2]
# Remove duplicate genes (only keep the first one)
idx.dup <- duplicated(geneID$IDENTIFIER)
exprDat <- exprDat[!idx.dup,]
geneID <- geneID[!idx.dup,]
rownames(exprDat) <- geneID$IDENTIFIER
# one patient from the sepsis group with > 80% missing data was removed
idx.col <- c(); ngene <- nrow(exprDat)
for (i in 1:ncol(exprDat)){
  idx.col[i] <- (is.na(exprDat[,i]) %>% sum()) / ngene
}
exprDat <- exprDat[,!(idx.col > 0.8)]
disease.state <- disease.state[!(idx.col > 0.8)]
# Split samples by "control" vs "sepsis"
# Followed by KNN imputation
exprMatr.ctrl <- exprDat[, disease.state == "control"] %>% impute.knn()
exprMatr.seps <- exprDat[, disease.state == "sepsis"] %>% impute.knn()
# Read regulators file
regulators <- read.table("gene_labels.csv", header = TRUE)
idx <- regulators$target_genes %in% geneID$IDENTIFIER
regulators <- regulators$target_genes[idx] %>% unique()
# Run GENIE3 on two set of samples
weightMat.ctrl <- GENIE3(exprMatr.ctrl$data, regulators = regulators,
                         nCores = 3, verbose = TRUE)
# saveRDS(weightMat.ctrl, file = "soft_GENIE3_KNN_ctrl.rds")
linkList.ctrl <- getLinkList(weightMat.ctrl)
# write.table(linkList.ctrl, file = "soft_GENIE3_KNN_ctrl_link.txt", sep = "\t")
weightMat.seps <- GENIE3(exprMatr.seps$data, regulators = regulators,
                         nCores = 3, verbose = TRUE)
# saveRDS(weightMat.seps, file = "soft_GENIE3_KNN_seps.rds")
linkList.seps <- getLinkList(weightMat.seps)
# write.table(linkList.seps, file = "soft_GENIE3_KNN_seps_link.txt", sep = "\t")

head(linkList.ctrl)
head(linkList.seps)









