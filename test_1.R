library(tidyverse)
library(GEOquery)
library(org.Hs.eg.db)
library(clusterProfiler)

df.labels <- read.csv("./Data/GSE185263_raw_file_labels.csv")
df <- read.csv("./Data/GSE185263_raw_counts.csv.gz")

# we want the log2 fold change 
original_gene_list <- df$log2FoldChange
# name the vector
names(original_gene_list) <- df$X
# omit any NA values 
gene_list <- df$ensembl_gene_id
# sort the list in decreasing order (required for clusterProfiler)
gene_list <- sort(gene_list, decreasing = TRUE)

keytypes(org.Hs.eg.db)

gse <- gseGO(geneList = "ENSG00000171984", 
             ont = "ALL", 
             keyType = "ENSEMBL", 
             nPerm = 10000, 
             minGSSize = 3, 
             maxGSSize = 800, 
             pvalueCutoff = 0.05, 
             verbose = TRUE, 
             OrgDb = org.Hs.eg.db, 
             pAdjustMethod = "none")
