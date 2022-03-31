#!/bin/bash

# Variable a comfigurer selon la version de l'application
VERSION="4.1.3"
PATH_TO_INSTALL="/usr/local/R${VERSION}"
PATH_TO_LINK="/usr/local/R"

# Creation du repertoire de compilation
WORKINGDIR=`mktemp -p /sens/sens_data_test/temp`
cd $WORKINGDIR

# Action orientant le present script. Valeurs autorisees: "install|delete"
ACTION=$1
[[ "$ACTION" == "delete" ]] || rm -rf ${PATH_TO_INSTALL}
[[ -d ${PATH_TO_INSTALL} ]] && { echo "Repertoire d'installation existant" ; exit 1; }

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

#Configurer le repo a utiliser par R
cp Rprofile.site ${PATH_TO_INSTALL}/lib64/R/etc/Rprofile.site 
chmod 0644 ${PATH_TO_INSTALL}/lib64/R/etc/Rprofile.site 

#Installer les librairies R supplementaires
${PATH_TO_INSTALL}/bin/Rscript ./installAllLibs.R

# Creation du lien symbolique pour preserver les modules files
ln -s ${PATH_TO_INSTALL} ${PATH_TO_LINK}


# installer la librairie hdf5 dans R

# Nettoyer l'environnement de compilation
rm -rf $WORKINGDIR