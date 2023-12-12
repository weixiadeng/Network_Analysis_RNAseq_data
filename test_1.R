library(tidyverse)
library(GEOquery)
library(org.Hs.eg.db)
library(clusterProfiler)

gseData <- getGEO("GSE236099", GSEMatrix = TRUE)

# reading in data from deseq2
df <- Table(gse)
# we want the log2 fold change 
original_gene_list <- df$log2FoldChange
# name the vector
names(original_gene_list) <- df$X
# omit any NA values 
gene_list <- na.omit(original_gene_list)
# sort the list in decreasing order (required for clusterProfiler)
gene_list = sort(gene_list, decreasing = TRUE)