
# R version 4.1.3

Site officiel de l'application: [CRAN-R](https://cran.r-project.org/).

## Controle des **versions**:

| Version  | Auteur  | Description  |
|---|---|---|
| 0.1  | francis.forget@umontreal.ca  | Installation vanille  |
| 0.8  | francis.forget@umontreal.ca  | Ajouter les librairies R supplementaires demandees par le client  |
| 0.9  | francis.forget@umontreal.ca  | Rediriger le stdout et stderr dans un fichier temporaire  |
| 1.0  | francis.forget@umontreal.ca  | Integration a l'environnement de deploiement  |
| 1.1  | francis.forget@umontreal.ca  | Structurer le README  |


## 1. Installation

### 1.1 Pre-installation (geree par le playbook):

#### 1.1.1 Dependances systeme pour la compilation
dnf install `git-core gcc-gfortran readline-devel xorg-x11-server-devel libX11-devel libXt-devel xz-devel pcre2-devel libcurl-devel java-latest-openjdk`

#### 1.1.2 Deoendances systeme pour permettre d'installer des librairies R supplementaires
dnf install `hdf5 hdf5-devel cairo-devel libxml2-devel openssl-devel libgit2-devel libjpeg-turbo-devel`

### 1.2 Parametres contextuels

| Contexte  | Ordre envoyee par le playbook| Nom de la variable dans les scripts  |
|---|---|---|
| Repertoire git contenant les fichiers  | ${0} |  GIT_DIR
| Repertoire d'installation         | ${1} | PATH_TO_INSTALL
| Depot UdeM interne des artefacts  | ${2} | LOCAL_ARTEFACT
| Repertoire de compilation         | ${3} | WORKING_BUILD
| Repertoire a journaliser          | ${4} | LOG_DIR
| Repertoire des modulefiles        | ${5} | MODULEFILES_DIR


Utiliser le repo CRAN: <https://cran.utstat.utoronto.ca/>

### 1.3 Procedure:

Les grandes etapes que l'on retrouve dans le script `installation.sh` :
1. Telecharger les sources si necessaire;
2. Compiler les sources;
3. Configurer le repo R pour l'acces aux librairies R supplementaires 
4. Rouler le script R qui isntalle l'ensemble des librairies connues 
5. Preparer un modulefile pour simplifier l'acces a l'application R

### 1.4 Post-installation (geree par le playbook):
Appliquer le playbook pour installer le modulefile R sur l'ensemble des serveurs de SENS.

## 2. Supression

### 2.1 Parametres contextuel

| Contexte  | Ordre envoyee par le playbook| Nom de la variable dans les scripts  |
|---|---|---|
| Repertoire d'installation         | ${1} | PATH_TO_INSTALL
| Depot UdeM interne des artefacts  | ${2} | LOCAL_ARTEFACT
| Repertoire des modulefiles        | ${3} | MODULEFILES_DIR

### 2.2 Procedure:

Les grandes etapes que l'on retrouve dans le script `suppression.sh` :
1. Supprimer les sources;
2. Supprimer le repertoire de l'application;

### 2.3 Post-suppression (geree par le playbook):
Appliquer le playbook pour retirer le modulefile R sur l'ensemble des serveurs de SENS.


## 3. AJout de librairies

En tant que root sur le serveur de compilation, executer dans `R`

<code> 
PACKAGE="NOM_DU_PACKAGE"

if(! (is.element(PACKAGE, installed.packages()[,1])) ) { install.packages(PACKAGE) }
</code>

Si l'installation necessite une/des librairie/s supplementaire/s, en faire la demande aupres des administrateurs de systeme et de les inscrires dans la presente documentation a la [section 1.1.2](#112-deoendances-systeme-pour-permettre-dinstaller-des-librairies-r-supplementaires)