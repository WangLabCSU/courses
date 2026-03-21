#BiocManager::install("clusterProfiler")
#BiocManager::install("org.Hs.eg.db")

library(org.Hs.eg.db)
library(clusterProfiler)

#载入数据
dds.res <- read.table("PTC_vs_ATC_results.txt")
dim(dds.res)
#查看数据基因命名方式
head(rownames(dds.res))
#查看注释数据支持的基因识别方式
keytypes(org.Hs.eg.db)

#选择需要进行功能富集分析的基因集合
dds.res.up <- dds.res[which(dds.res$padj<0.05 & dds.res$log2FoldChange >2),]
dds.res.up.geneName <- rownames(dds.res.up)
length(dds.res.up.geneName)

#进行GO的Biological Process进行注释
# 默认的为ENTREZID，这里用的是gene symbol，所有需要指定参数keyType= "SYMBOL"
dds.res.up.ego.bp <- enrichGO(gene    = dds.res.up.geneName,
                              keyType       = "SYMBOL",
                              OrgDb         = org.Hs.eg.db,
                ont           = "BP",
                pAdjustMethod = "BH",
                pvalueCutoff  = 0.01,
                qvalueCutoff  = 0.05)
head(dds.res.up.ego.bp)
#在所有的GO进行注释
dds.res.up.ego <- enrichGO(gene          = dds.res.up.geneName,
                           keyType       = "SYMBOL",
                           OrgDb         = org.Hs.eg.db,
                           ont           = "ALL",
                           pAdjustMethod = "BH",
                           pvalueCutoff  = 0.01,
                          qvalueCutoff  = 0.05)
head(dds.res.up.ego)
#点图展示富集结果
dotplot(dds.res.up.ego.bp, showCategory=15,orderBy = "p.adjust")
dotplot(dds.res.up.ego, showCategory=15,orderBy = "count")

dds.res.FC<-dds.res[,"log2FoldChange"]
names(dds.res.FC) <- rownames(dds.res)
cnetplot(dds.res.up.ego, foldChange=dds.res.FC)

#enrichKEGG只支持"kegg", 'ncbi-geneid', 'ncib-proteinid' 和 'uniprot'的识别符，所有需要将gene symble转换为UNIPROT的ID。
dds.res.up.symbol2uniport <- bitr(dds.res.up.geneName, fromType="SYMBOL", toType=c("UNIPROT"), OrgDb="org.Hs.eg.db")
head(dds.res.up.symbol2uniport)
dds.res.up.kk <- enrichKEGG(dds.res.up.symbol2uniport[,2], keyType="uniprot",organism="hsa", pvalueCutoff=0.05, pAdjustMethod="BH", qvalueCutoff=0.1)
head(dds.res.up.kk)


#####GSEA 分析
head(dds.res.FC)
dds.res.FC.ordered <- dds.res.FC[order(dds.res.FC,decreasing = T)]
dds.res.gsecc <- gseGO(geneList = dds.res.FC.ordered,
                       keyType= "SYMBOL",
                       ont="ALL",
                       OrgDb=org.Hs.eg.db,
                       verbose=F)
head(summary(dds.res.gsecc))
gseaplot(dds.res.gsecc, geneSetID = "GO:0022613")

# Read more in https://yulab-smu.top/biomedical-knowledge-mining-book/index.html
# https://www.nature.com/articles/s41596-024-01020-z
# https://www.cell.com/the-innovation/fulltext/S2666-6758(21)00066-7
