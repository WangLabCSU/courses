#install.packages("BiocManager")
#BiocManager::install("DESeq2")
# browseVignettes("DESeq2")

library("DESeq2")
dataMatrix <- read.table("geneCountMatrix.txt",header = T)
dim(dataMatrix)
head(dataMatrix)
rownames(dataMatrix) <- dataMatrix[,"gene_symbol"]
dataMatrix <- dataMatrix[,2:dim(dataMatrix)[2]]
head(dataMatrix)

coldata <- read.table("samplesinfo.txt",header = T)
head(coldata)

dds <- DESeqDataSetFromMatrix(countData = dataMatrix, colData = coldata, design = ~ type)
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep,]
dds <- DESeq(dds)

dds.res <- results(dds,alpha = 0.05)
summary(dds.res)
sum(dds.res$padj<0.05, na.rm=TRUE)
dds.resOrdered <- dds.res[order(dds.res$padj),]
write.table(as.data.frame(dds.resOrdered), file="PTC_vs_ATC_results.txt",quote = F,sep = "\t")
sum( (dds.res$padj<0.05 & abs(dds.res$log2FoldChange)>2),na.rm=TRUE)

###### 筛选log2 fold change在两倍以上，p-adjust小于0.05的ATC和PTC差异表达基因 
dds.res.filtered <- dds.res[which(dds.res$padj<0.05 & abs(dds.res$log2FoldChange) >2),]
write.table(dds.res.filtered, file="PTC_vs_ATC_DEG.txt",quote = F,sep = "\t")


