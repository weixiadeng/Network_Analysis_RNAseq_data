library(tidyverse)
library(igraph)
library(caret)

soft.ctrl <- read.table("soft_GENIE3_KNN_ctrl_link.txt",
                        sep = "\t", header = TRUE)

soft.seps <- read.table("soft_GENIE3_KNN_seps_link.txt",
                        sep = "\t", header = TRUE)

# Normalize weight of two groups
ctrl <- preProcess(as.data.frame(soft.ctrl$weight), method = c("range"))
ctrl.norm <- predict(ctrl, as.data.frame(soft.ctrl$weight))
soft.ctrl$weightNorm <- ctrl.norm[,1]

seps <- preProcess(as.data.frame(soft.seps$weight), method = c("range"))
seps.norm <- predict(seps, as.data.frame(soft.seps$weight))
soft.seps$weightNorm <- seps.norm[,1]

# Save the top 10000 weight
# write.table(soft.ctrl[1:10000,], row.names = FALSE,
#             file = "soft_GENIE3_KNN_ctrl_top_link.txt", sep = "\t")

# write.table(soft.seps[1:10000,], row.names = FALSE,
#             file = "soft_GENIE3_KNN_seps_top_link.txt", sep = "\t")


df <- merge(x = soft.ctrl, y = soft.seps,
            by = c("regulatoryGene", "targetGene"))

# write.table(df, file = "soft_GENIE3_KNN_merge_link.txt", sep = "\t")

df <- read.table("soft_GENIE3_KNN_merge_link.txt",
                 sep = "\t", header = TRUE)

ctrl <- preProcess(as.data.frame(df$weight.x), method = c("range"))
ctrl.norm <- predict(ctrl, as.data.frame(df$weight.x))

seps <- preProcess(as.data.frame(df$weight.y), method = c("range"))
seps.norm <- predict(seps, as.data.frame(df$weight.y))

plot(ctrl.norm[,1], seps.norm[,1])

plot(density(seps.norm[,1]), col = "black")
lines(density(ctrl.norm[,1]), col = "red")
abline(v = quantile(seps.norm[,1], probs = 0.99), col = "black")
abline(v = quantile(ctrl.norm[,1], probs = 0.99), col = "red")





