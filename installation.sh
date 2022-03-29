#!/bin/bash

WORKINGDIR=`mktemp -p`
cd $WORKINGDIR

wget https://cran.r-project.org/src/base/R-4/R-4.1.3.tar.gz

tar -zxf R-4.1.3.tar.gz

cd 


rm -rf $WORKINGDIR
