# Version de l'application
VERSION="4.1.3"

############################################################################
### DEBUT: NE PAS MODIFIER CETTE SECTION
############################################################################

mount -o remount,exec /tmp
umask 0022

PATH_TO_INSTALL="${1}/R-${VERSION}" # Repertoire d'installation
LOCAL_ARTEFACT="${2}" # Depot UdeM des sources externes;
WORKING_BUILD="${3}" # Repertoire de compilation
LOG_DIR="${4}/R-${VERSION}" # configure make and install logs
GIT_DIR=`dirname $0` # Repertoire courant qui contiendra tous les fichiers de git.

mkdir -p $LOG_DIR
exec &>> "${LOG_DIR}/installation-R.outpout.`date +%Y-%m-%d-%s`"

[[ -d ${PATH_TO_INSTALL} ]] && { echo "Repertoire d'installation existant" ; exit 1; }

############################################################################ 
### FIN: NE PAS MODIFIER CETTE SECTION
############################################################################ 

############################################################################ 
### Etape 1:  Telecharger les sources si necessaire dans le depot d'artefact
############################################################################ 

cd $LOCAL_ARTEFACT
[[ ! -e "R-${VERSION}.tar.gz" ]] && {
    echo "# SENS ############ Telechargement des artefacts directements du site officiel";
    wget https://cran.r-project.org/src/base/R-4/R-${VERSION}.tar.gz;
}

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
./configure --prefix=${PATH_TO_INSTALL} --with-blas --with-lapack --enable-R-shlib
make 
make install

############################################################################ 
### Etape 3
############################################################################ 
echo "# SENS ############ Configurer le repo a utiliser par R"
cp ${GIT_DIR}/etc/Rprofile.site ${PATH_TO_INSTALL}/lib64/R/etc/Rprofile.site 
chmod 0644 ${PATH_TO_INSTALL}/lib64/R/etc/Rprofile.site 

############################################################################ 
### Etape 4
############################################################################ 
echo "# SENS ############ Installer les librairies R supplementaires"
${PATH_TO_INSTALL}/bin/Rscript ${GIT_DIR}/installAllLibs.R

############################################################################ 
### Etape 5
############################################################################ 
# For test purposes: Creation du lien symbolique pour preserver les modules files
# En production, ceci sera remplace par un modulefile qui ajoute 
# ${PATH_TO_INSTALL}/bin/ au PATH
ln -s ${PATH_TO_INSTALL}/bin/* /usr/local/bin/ 

############################################################################ 
### DEBUT: NE PAS MODIFIER CETTE SECTION
############################################################################ 
# Nettoyer l'environnement de compilation
rm -rf $WORKINGDIR

mount -o remount,noexec /tmp
############################################################################ 
### FIN: NE PAS MODIFIER CETTE SECTION
############################################################################ 