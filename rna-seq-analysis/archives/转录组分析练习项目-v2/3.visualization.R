# volcano plot火山图 ----------

library(ggplot2)

volcano_data <- read.table("PTC_vs_ATC_results.txt", sep = "\t") #读入差异表达结果
volcano_data <- na.omit(volcano_data) #删除含NA的行
significant <- as.factor(abs(volcano_data$log2FoldChange) >=2 & volcano_data$padj <= 0.01) #设置显著性阈值

ggplot(volcano_data, aes(x = log2FoldChange, y = - log10(padj))) +
    geom_point(aes(shape = significant, color = significant)) +
    xlim(c(-10, 10)) +
    labs(x = "log2FoldChange", y = "-log10 padj") +
    scale_y_continuous(limits = c(0, 20), expand = c(0, 0)) +
    scale_shape_discrete(labels =c ("no", "yes")) +
    scale_color_discrete(labels = c("no", "yes")) #ggplot2命令

# https://github.com/BioSenior/ggVolcano
# remotes::install_github("BioSenior/ggVolcano")
library(ggVolcano)

# use the function -- add_regulate to add a regulate column
# to the DEG result data.
volcano_data2 = tibble::rownames_to_column(volcano_data, "row")
data <- add_regulate(volcano_data2, log2FC_name = "log2FoldChange",
                     fdr_name = "padj",log2FC = 2, fdr = 0.01)

# plot
ggvolcano(data, x = "log2FoldChange", y = "padj",
          label = "row", label_number = 10, output = FALSE)


# heatmap -----------------------------------------------------------------
# count, fpkm, tpm ... (https://cloud.tencent.com/developer/article/2370873)
#BiocManager::install("IOBR/IOBR") # 这个依赖包很多，同学们不一定好安装，我把结果先缓存

# count to tpm
dataMatrix <- read.table("geneCountMatrix.txt",header = T)
dim(dataMatrix)
head(dataMatrix)
rownames(dataMatrix) <- dataMatrix[,"gene_symbol"]
dataMatrix <- dataMatrix[,2:dim(dataMatrix)[2]]
dataMatrix[1:5, 1:5]

library(IOBR)
tpm = IOBR::count2tpm(dataMatrix, idType = "Symbol")

# get genes to plot
library(pheatmap)

deseq_results_significant <- read.table("PTC_vs_ATC_DEG.txt") #读入显著差异表达结果
deseq_results_significant <- deseq_results_significant[order(deseq_results_significant$padj), ]
head(deseq_results_significant)
significant_genes <- rownames(deseq_results_significant) #提取显著差异基因

tpm_sig = tpm[significant_genes, ]
head(tpm_sig)

tpm_sig = na.omit(tpm_sig)

pheatmap(log2(t(tpm_sig + 1)), show_colnames = FALSE) #所有差异基因热图
pheatmap(log2(t(tpm_sig[1:30, ] + 1))) #差异基因top30热图

