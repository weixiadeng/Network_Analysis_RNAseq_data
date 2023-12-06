library(tidyverse)
library(GEOquery)
library(GENIE3)
library(factoextra)
library(FactoMineR)
library(missMDA)
library(impute)

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
soft.pca.df <- df.soft[,3:ncol(df.soft)] %>% t()
colnames(soft.pca.df) <- df.soft$ID_REF
# Estimate dimensionality
pcaDim <- estim_ncpPCA(soft.pca.df)
# pcaDim$ncp = 5
# PAC
res.comp <- imputePCA(soft.pca.df, ncp = 5)
res.pca <- PCA(res.comp$completeObs, graph = FALSE)
fviz_screeplot(res.pca, addlabels = TRUE, ylim = c(0, 15))
fviz_pca_ind(res.pca,
             label = "none",
             habillage = disease.state,
             palette = c("red", "blue"),
             addEllipses = TRUE)

# GENIE3
soft.genie.mat <- df.soft[,3:ncol(df.soft)] %>% data.matrix()
rownames(soft.genie.mat) <- df.soft$ID_REF

idx <- c(); nsamp <- ncol(soft.genie.mat)
for (i in 1:nrow(soft.genie.mat)){
  idx[i] <- (is.na(soft.genie.mat[i,]) %>% sum()) / nsamp
}
# Missing value imputation for gene expression data
# https://doi.org/10.1093/bib/bbq080
# https://doi.org/10.1186/s12859-015-0494-3
exprMatr.raw <- soft.genie.mat[(idx < 0.5),]
# one patient from the sepsis group with > 80% missing data was removed
idx.col <- c(); ngene <- nrow(soft.genie.mat)
for (i in 1:ncol(soft.genie.mat)){
  idx.col[i] <- (is.na(soft.genie.mat[,i]) %>% sum()) / ngene
}
exprMatr.raw <- exprMatr.raw[,!(idx.col > 0.8)]
# An expression matrix with genes in the rows, samples in the columns
exprMatr <- impute.knn(exprMatr.raw, k = 10)
weightMat <- GENIE3(exprMatr$data)
# saveRDS(weightMat, file = "soft_weightMat.rds")
linkList <- getLinkList(readRDS("soft_weightMat.rds"))










