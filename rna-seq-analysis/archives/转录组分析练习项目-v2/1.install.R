# 从cran ----------
chooseCRANmirror()  # 选24 武汉

install.packages("pheatmap")
library(pheatmap)

install.packages("ggplot2")
library(ggplot2)

install.packages("BiocManager")
library(BiocManager)

# 从BiocManager安装 -------------

chooseBioCmirror() # 8 China Anhui

library(BiocManager)
BiocManager::install("DESeq2")
library(DESeq2)
BiocManager::install("clusterProfiler")
BiocManager::install("org.Hs.eg.db")

# 同学们非必要安装
BiocManager::install("remotes")
BiocManager::install("BioSenior/ggVolcano")
BiocManager::install("GSVA")
BiocManager::install("IOBR/IOBR")

