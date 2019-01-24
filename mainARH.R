package.installed <- installed.packages()

# Get inputs
suppressWarnings(suppressMessages(library("methods")))
suppressWarnings(suppressMessages(library("S4Vectors")))
suppressWarnings(suppressMessages(library("oligo")))
args <- suppressMessages(suppressWarnings(commandArgs(TRUE)));
suppressWarnings(suppressMessages(load(args[1])));
Design_matrix <- suppressWarnings(suppressMessages(as.matrix(read.table(args[2],header=TRUE))));

chip <- gsub('\\.','',ppData@annotation)
chip <- substr(chip,3,nchar(chip))
Database <- paste(chip,"transcriptcluster.db",sep="")
if(!Database %in% rownames(package.installed)){
  suppressMessages(suppressWarnings(source("http://bioconductor.org/biocLite.R")))
  suppressMessages(suppressWarnings(biocLite(Database)))
}
suppressMessages(library(Database,character.only = TRUE))


#require library
suppressWarnings(suppressMessages(source(paste(args[3],"/annoter_gene.R",sep=""))))
suppressWarnings(suppressMessages(source(paste(args[3],"/ARH.R",sep=""))))
suppressWarnings(suppressMessages(source(paste(args[3],"/ARH_plot.R",sep=""))))

rownames(Design_matrix) <- Design_matrix[,1]

Expression_set <- exprs(ppData)

col <- colnames(Expression_set)
cl <- vector()
listControl <- Design_matrix[which(Design_matrix[col,2]=="C"),1]
listTrait <- Design_matrix[which(Design_matrix[col,2]=="T"),1]

cl <- c(rep(0,length(listControl)),rep(1,length(listTrait)))

featureData(ppData) <- getNetAffx(ppData, "probeset")


TC <- pData(featureData(ppData))

Genes <- TC
Genes_order <- Genes[order(Genes[,1]),7]
control <- listControl
trait <- listTrait
ARH_result <- suppressMessages(suppressWarnings(ARH(rowMeans(Expression_set[,control]),rowMeans(Expression_set[,trait]),Genes_order)))
ARH_sd_result <- suppressMessages(suppressWarnings(ARH_sd(rowMeans(Expression_set[,control]),rowMeans(Expression_set[,trait]),Genes_order)))
#ARH_p_result <- suppressMessages(suppressWarnings(ARH_p(rowMeans(Expression_set[,control]),rowMeans(Expression_set[,trait]),Genes_order)))
ARH_sp_result <- suppressMessages(suppressWarnings(ARH_sp(rowMeans(Expression_set[,control]),rowMeans(Expression_set[,trait]),Genes_order)))

ARH_splicing <- ARH_result[which(ARH_result>0.03)]
ARH_splicing <- ARH_splicing[order(ARH_splicing,decreasing = TRUE  )]
listFinalARH <- annoter_gene(ARH_splicing,Database)
listFinalARH <- listFinalARH[which(listFinalARH[,3]!="NA"),]
listFinalARH <- listFinalARH[order(listFinalARH[,2]),]
colnames(listFinalARH)[c(1,2)] <- c("Gene ID","ARH")
arh_sp_1 <- split(ARH_sp_result,Genes_order)

if(dim(listFinalARH)[1]<100){
  n <- dim(listFinalARH)[1]
}else{
  n <- 100
}
pdf("ARHPlots.pdf")

for(i in 1:n){
  key <- listFinalARH[i,1]
  
  sp <- arh_sp_1[key][[1]]
  
  c <- rowMeans(Expression_set[names(sp),control])
  t <- rowMeans(Expression_set[names(sp),trait])
  
  suppressMessages(suppressWarnings(plot_arh(c,t,sp,listFinalARH[i,6])))
  
}
suppressMessages(suppressWarnings(write.table(listFinalARH,file="ARHResult.csv",sep='\t',row.names=F)))
dev.off()
