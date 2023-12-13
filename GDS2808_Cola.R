library(tidyverse)
library(GEOquery)
library(cola)

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
# Cola
mat <- adjust_matrix(mat, max_na = 0.5)
res_list <- run_all_consensus_partition_methods(mat, mc.cores = 4,
                                                anno = anno, verbose = FALSE)
# saveRDS(res_list, "GDS2808_Cola_res_list.rds")
# Plot
res <- res_list["SD:hclust"]
select_partition_number(res)
dimension_reduction(res, k = 2, method = "UMAP",
                    control = list(col = disease.state))
dimension_reduction(res, k = 2, method = "PCA",
                    control = list(scale = TRUE))
dimension_reduction(res, k = 2, method = "t-SNE",
                    control = list(bg = disease.state))






