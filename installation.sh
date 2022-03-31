#!/bin/bash

exec &>> "/tmp/installR.outpout.$$$$"
umask 0022

# Variable a comfigurer selon la version de l'application
VERSION="4.1.3"
PATH_TO_INSTALL="${1}/R/R-${VERSION}"   # Repertoire d'installation
LOCAL_ARTEFACT="${2}"                   # Depot UdeM des sources externes;
WORKING_BUILD="${3}"                    # Repertoire de compilation
ACTION="$4"

# Action orientant le present script. Valeurs autorisees: "install|delete"
[[ "$ACTION" == "delete" ]] || rm -rf ${PATH_TO_INSTALL}
[[ -d ${PATH_TO_INSTALL} ]] && { echo "Repertoire d'installation existant" ; exit 1; }

############################################################################ 
### Etape 1:  Telecharger les sources si necessaire dans le depot d'artefact;
############################################################################ 
echo "# SENS ############ Telechargement des artefacts directements du site officiel"
cd $LOCAL_ARTEFACT
[[ ! -e "R-${VERSION}.tar.gz" ]] && wget https://cran.r-project.org/src/base/R-4/R-${VERSION}.tar.gz 

echo "# SENS ############ Decompresser les artefacts"
tar -zxf R-${VERSION}.tar.gz --directory $WORKING_BUILD

############################################################################ 
### Etape 2: Compiler les sources;
############################################################################ 
# Basculons dans le repertoire de BUILD
cd $WORKING_BUILD/R-${VERSION}

# Creer le repertoire ou residera l'application
mkdir -p ${PATH_TO_INSTALL}

echo "# SENS ############ Compiler et installer"
./configure --prefix=${PATH_TO_INSTALL} 
make 
make install

############################################################################ 
### Etape 3
############################################################################ 
echo "# SENS ############ Configurer le repo a utiliser par R"
cp Rprofile.site ${PATH_TO_INSTALL}/lib64/R/etc/Rprofile.site 
chmod 0644 ${PATH_TO_INSTALL}/lib64/R/etc/Rprofile.site 

############################################################################ 
### Etape 4
############################################################################ 
echo "# SENS ############ Installer les librairies R supplementaires"
${PATH_TO_INSTALL}/bin/Rscript ./installAllLibs.R

############################################################################ 
### Etape 5
############################################################################ 
# Creation du lien symbolique pour preserver les modules files
ln -s ${PATH_TO_INSTALL} ${PATH_TO_LINK}


# Nettoyer l'environnement de compilation
rm -rf $WORKINGDIR