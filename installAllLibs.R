#
# Modified: Tue Mar 18 09:23:45 EDT 2014
#           Thu Mar 20 07:52:57 EDT 2014
#           Sat Oct  7 12:41:02 EDT 2017
#           Tue Mar 12 08:34:04 EDT 2019
#           Wed Mar 13 06:35:02 EDT 2019
#           Wed May 15 13:37:20 EDT 2019
#           Fri May 17 12:02:06 EDT 2019
#           Fri Jan  8 09:13:43 EST 2021
#           Sun Jan 10 12:00:45 EST 2021
#           Sun Jan 31 10:17:16 EST 2021
#           Mon Feb  1 09:37:39 EST 2021
#           Wed Sep  8 12:35:09 EDT 2021
#
# R script to install libraries
#
# Use Rscript to run this script (as root):
#
#            Rscript ./installAllLibs.R
#
#

# Install Rserve and bioc(xcms) separtly due to special
# considerations (Rserve is a server and xcms has multiple
# system dependencies)

already.installed <- function(pkg){
        is.element(pkg, installed.packages()[,1])
}

# Choose to use UToronto's CRAN mirror
# UToronto seems to be unavailable via https, use 14 (Manitoba)
chooseCRANmirror(ind=14)

# Regular library (CRAN) list
reg.l.list <- c("acepack","aggregation","assertthat","backports","base","base64","base64enc","BH","bindr","bindrcpp","bit","bit64","bitops","blob","boot",
                "Cairo","callr","caret","caTools","checkmate","class","cli","clipr","clisymbols","cluster","codetools","colorspace","compiler","corpcor",
                "corrplot","crayon","curl","CVST","data.table","datasets","DBI","ddalpha","DEoptimR","desc","devtools","dichromat","digest","dimRed",
                "dplyr","DRR","e1071","ellipse","evaluate","fansi","fastcluster","foreach","foreign","Formula","fs","futile.logger","futile.options",
                "gdata","ggplot2","gh","git2r","glue","gower","gplots","graphics","grDevices","grid","gridExtra","gridSVG","gtable","gtools","hexbin",
                "highr","Hmisc","htmlTable","htmltools","htmlwidgets","httpuv","httr","hwriter","igraph","ini","ipred","irlba","iterators","jsonlite",
                "kernlab","KernSmooth","knitr","labeling","lambda.r","later","lattice","latticeExtra","lava","lazyeval","locfit","lubridate","magrittr",
                "markdown","MASS","Matrix","matrixStats","memoise","meta","methods","mgcv","mime","ModelMetrics","munsell","nlme","nnet","numDeriv",
                "openssl","parallel","pheatmap","pillar","pkgbuild","pkgconfig","pkgload","plogr","pls","plyr","prettyunits","processx","prodlim","promises",
                "ps","purrr","R6","randomForest","rcmdcheck","RColorBrewer","Rcpp","RcppArmadillo","RcppRoll","RCurl","recipes","remotes","reshape2","rlang",
                "robustbase","rpart","rprojroot","RSQLite","rstudioapi","samr","scales","scatterplot3d","sessioninfo","setRNG","seurat","sfsmisc","shiny","sleuth",
                "snow","som","sourcetools","spatial","splines","Sqldf","stats","stats4","stringi","stringr","survival","tcltk","tibble","tidyr","tidyselect",
                "timeDate","tools","usethis","utf8","utils","viridis","viridisLite","vrmlgen","whisker","withr","XML","xopen","xtable","yaml",
                "ape","cowplot","deldir","devtools","dqrng","fitdistrplus","FNN","future","future.apply","ggrepel","ggridges","globals","goftest",
                "ica","leiden","listenv","lmtest","miniUI","patchwork","pbapply","plotly","polyclip","RANN","RcppAnnoy","reticulate","ROCR",
                "RSpectra","rsvd","Rtsne","sctransform","Seurat","sitmo","spatstat","spatstat.data","spatstat.utils","tensor","usethis","uwot","zoo")

# Bioconductor (BioC) library list
bioc.l.list <- c("affy","affyPLM","affyio","affyQCReport","annotate","AnnotationDbi","AnnotationFilter","AnnotationHub","arrayQualityMetrics","beadarray",
                 "BeadDataPackR","Biobase","BiocGenerics","biomaRt","BiocParallel","Biostrings","biovizBase","BSgenome","cummeRbund",
                 "DelayedArray", "DESeq2","edgeR","ensembldb","gcrma","genefilter","geneplotter","GenomeInfoDb","GenomeInfoDbData","GenomicAlignments",
                 "GenomicFeatures", "GenomicRanges","ggplot2","GlobalAncova","globaltest","graph","Gviz","hgu95av2cdf","hgu95av2probe","hgu133a2",
                 "hgu133plus2","illuminaio","impute","interactiveDisplayBase", "IRanges","KEGGgraph","limma","multtest","org.Dm.eg.db","org.Sc.sgd.db",
                 "pcaMethods","preprocessCore","ProtGenerics","RColorBrewer","rhdf5","Rgraphviz","Rsamtools", "rtracklayer","S4Vectors","ShortRead",
                 "siggenes","simpleaffy","SVGAnnotation","SummarizedExperiment","VariantAnnotation","vsn","XVector","ygs98.db",
                 "ygs98cdf","ygs98probe","zlibbioc", "org.Hs.eg.db","tximportData","tximport","readr")

# Installation of regular libraries

# Loop over elements of reg.l.list to install regular libraries
for (i in reg.l.list) {
        cat("\tLibrary under consideration is: ", i , "\n")
        if(already.installed(i)){
                cat("\t\t", i, " is already installed")
        } else {
                cat("\t\tInstalling: ", i, "....\n")
                install.packages(i)
        }
}

cat("\n")

# Ensure that BiocManager is installed
if (!requireNamespace("BiocManager", quietly = TRUE))
        install.packages("BiocManager")


# Installation of Bioconductor libraries
# source("http://bioconductor.org/biocLite.R")
# Loop over elements of bioc.l.list to install Bioconductor libraries
for (i in bioc.l.list){
        cat("\tLibrary under consideration is: ", i , "\n")
        if(already.installed(i)){
                cat("\t\t", i, " is already installed\n")
        } else {
                cat("\t\tInstalling: ", i, "....\n")
                # biocLite(i)
                BiocManager::install(i)
        }
}

cat("\n\n")