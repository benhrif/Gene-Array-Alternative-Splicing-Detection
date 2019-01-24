## load package
package.installed <- installed.packages()

suppressMessages(suppressWarnings(library("RSQLite")))
suppressMessages(suppressWarnings(library("DBI")))
suppressMessages(suppressWarnings(library("oligo")))

args <- suppressMessages(suppressWarnings(commandArgs(TRUE)));

suppressWarnings(suppressMessages(load(args[1])));
norm <- args[2]
summ <- "probeset"


####preprocessing

bg <- suppressMessages(suppressWarnings(backgroundCorrect(rawData)))
nm <- suppressMessages(suppressWarnings(normalize(bg, method = norm)))
ppData<-suppressMessages(suppressWarnings(rma(nm,background = FALSE, normalize = FALSE, target = summ)))

##output
suppressMessages(suppressWarnings(save(ppData,file="ppData.RData")))
