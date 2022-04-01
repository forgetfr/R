#!/bin/bash

# Version de l'application
VERSION="4.1.3"

############################################################################ 
### DEBUT: NE PAS MODIFIER CETTE SECTION
############################################################################ 

exec &>> "/tmp/deleteR.outpout.$$$$"
mount -o remount,exec /tmp
umask 0022

PATH_TO_INSTALL="${1}/R-${VERSION}"     # Repertoire d'installation
LOCAL_ARTEFACT="${2}"                   # Depot UdeM des sources externes;

############################################################################ 
### FIN: NE PAS MODIFIER CETTE SECTION
############################################################################ 


[[ -e "${LOCAL_ARTEFACT}/R-${VERSION}.tar.gz" ]] && {
    echo "# SENS ############ Supression de l'artefact ${LOCAL_ARTEFACT}/R-${VERSION}.tar.gz";
    rm "${LOCAL_ARTEFACT}/R-${VERSION}.tar.gz";
}

[[ -e "${PATH_TO_INSTALL}" ]] && {
    echo "# SENS ############ Supression de l'application ${PATH_TO_INSTALL}/R-${VERSION}";
    rm -rf ${PATH_TO_INSTALL}/R-${VERSION};
}

############################################################################ 
### DEBUT: NE PAS MODIFIER CETTE SECTION
############################################################################ 
mount -o remount,noexec /tmp
############################################################################ 
### FIN: NE PAS MODIFIER CETTE SECTION
############################################################################ 