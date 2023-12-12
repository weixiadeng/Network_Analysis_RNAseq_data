library(tidyverse)
library(org.Hs.eg.db)

df <- read.csv("key_genes.csv")

mapC <- mapIds(org.Hs.eg.db, keys = df$control_genes, column = "UNIPROT",
              keytype = "SYMBOL")

mapT <- mapIds(org.Hs.eg.db, keys = df$sepsis_genes, column = "UNIPROT",
              keytype = "SYMBOL")

mapT %>% unique() %>% paste(collapse = " ")
