#!/bin/bash

WORKINGDIR=`mktemp -p`
VERSION="4.1.3"
PATH_TO_INSTALL="/usr/local/R${VERSION}"
PATH_TO_LINK="/usr/local/R"

cd $WORKINGDIR

wget https://cran.r-project.org/src/base/R-4/R-${VERSION}.tar.gz
mkdir tar -zxf R-${VERSION}.tar.gz && cd R-${VERSION}

mkdir ${PATH_TO_INSTALL}
./configure --prefix=${PATH_TO_INSTALL} 
make 
make install

ln -s ${PATH_TO_INSTALL} ${PATH_TO_LINK}

rm -rf $WORKINGDIR