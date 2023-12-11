library(tidyverse)
library(GEOquery)
library(cola)
library(impute)

gds <- getGEO(filename = "./Data/GDS2808.soft")
eset <- GDS2eSet(gds)
mat <- exprs(eset)
anno <- gds@dataTable@columns
# Access sample disease state (control vs ill)
disease.state <- gds@dataTable@columns$disease.state
# one patient from the sepsis group with > 80% missing data was removed
idx.col <- c(); ngene <- nrow(mat)
for (i in 1:ncol(mat)){
  idx.col[i] <- (is.na(mat[,i]) %>% sum()) / ngene
}
mat <- mat[,!(idx.col > 0.8)]
anno <- anno[!(idx.col > 0.8),]
disease.state <- disease.state[!(idx.col > 0.8)]
# KNN impute two groups
mat.ctrl <- mat[,disease.state == "control"] %>% impute.knn()
mat.seps <- mat[,disease.state == "sepsis"] %>% impute.knn()
mat <- cbind(mat.ctrl$data, mat.seps$data)
# Cola
mat <- adjust_matrix(mat)
res_list <- run_all_consensus_partition_methods(mat, mc.cores = 4, anno = anno)
# saveRDS(res_list, "Cola_res_list.rds")
# cola_report(res_list, "Cola_report", mc.cores = 4)
res_list <- readRDS("Cola_res_list.rds")
res <- res_list["SD:hclust"]
select_partition_number(res)
dimension_reduction(res, k = 2, method = "UMAP")
dimension_reduction(res, k = 2, method = "PCA")
dimension_reduction(res, k = 2, method = "t-SNE")



