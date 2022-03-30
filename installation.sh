#!/bin/bash

# Variable a comfigurer selon la version de l'application
VERSION="4.1.3"
PATH_TO_INSTALL="/usr/local/R${VERSION}"
PATH_TO_LINK="/usr/local/R"

# Creation du repertoire de compilation
WORKINGDIR=`mktemp -p /sens/sens_data_test/temps`
cd $WORKINGDIR

# Telechargement des artefacts directements du site officiel
wget https://cran.r-project.org/src/base/R-4/R-${VERSION}.tar.gz

# Decompresser les artefacts
mkdir tar -zxf R-${VERSION}.tar.gz && cd R-${VERSION}

# Creer le repertoire ou residera l'application
mkdir ${PATH_TO_INSTALL}

# Compiler et installer
./configure --prefix=${PATH_TO_INSTALL} 
make 
make install

# Creation du lien symbolique pour preserver les modules files
ln -s ${PATH_TO_INSTALL} ${PATH_TO_LINK}

# Nettoyer l'environnement de compilation
rm -rf $WORKINGDIR