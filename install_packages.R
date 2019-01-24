## load package

if(!"oligo" %in% rownames(package.installed)){
  suppressMessages(suppressWarnings(source("http://bioconductor.org/biocLite.R")))
  suppressMessages(suppressWarnings(biocLite("oligo")))
}
if(!"S4Vectors" %in% rownames(package.installed)){
  suppressMessages(suppressWarnings(source("http://bioconductor.org/biocLite.R")))
  suppressMessages(suppressWarnings(biocLite("S4Vectors")))
}
if(!"pvclust" %in% rownames(package.installed)){
  suppressMessages(suppressWarnings(source("http://bioconductor.org/biocLite.R")))
  suppressMessages(suppressWarnings(biocLite("pvclust")))
}
if(!"Biobase" %in% rownames(package.installed)){
  suppressMessages(suppressWarnings(source("http://bioconductor.org/biocLite.R")))
  suppressMessages(suppressWarnings(biocLite("Biobase")))
}
if(!"RSQLite" %in% rownames(package.installed)){
  suppressMessages(suppressWarnings(source("http://bioconductor.org/biocLite.R")))
  suppressMessages(suppressWarnings(biocLite("RSQLite")))
}
if(!"DBI" %in% rownames(package.installed)){
  suppressMessages(suppressWarnings(source("http://bioconductor.org/biocLite.R")))
  suppressMessages(suppressWarnings(biocLite("DBI")))
}
if(!"methods" %in% rownames(package.installed)){
  suppressMessages(suppressWarnings(source("http://bioconductor.org/biocLite.R")))
  suppressMessages(suppressWarnings(biocLite("methods")))
}