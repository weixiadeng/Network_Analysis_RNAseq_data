library(tidyverse)
library(igraph)

soft.ctrl <- read.table("soft_GENIE3_KNN_ctrl_link.txt",
                        sep = "\t", header = TRUE)

soft.seps <- read.table("soft_GENIE3_KNN_seps_link.txt",
                        sep = "\t", header = TRUE)

soft.ctrl$weight %>% summary()
soft.seps$weight %>% summary()

df <- merge(x = soft.ctrl, y = soft.seps,
            by = c("regulatoryGene", "targetGene"))

# write.table(df, file = "soft_GENIE3_KNN_merge_link.txt", sep = "\t")
