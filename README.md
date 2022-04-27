
# R version 4.1.3

Site officiel de l'application: [CRAN-R](https://cran.r-project.org/).

## Controle des **versions**:

| Version  | Auteur  | Description  |
|---|---|---|
| 0.1  | francis.forget@umontreal.ca  | MVP |
| 0.2  | francis.forget@umontreal.ca  | Rediriger le stdout et stderr dans un fichier temporaire  
| 0.6  | francis.forget@umontreal.ca  | Ajouter les librairies R supplementaires demandees par le client  |
| 0.8  | francis.forget@umontreal.ca  | Integration a l'environnement de deploiement  |
| 0.9  | francis.forget@umontreal.ca  | Resultats tests d'acceptation  |
| 1.0  | francis.forget@umontreal.ca  | MEP :-S ok ok ok mettons qu'il y a eu des tests d'acceptation du client  |
| 1.1  | francis.forget@umontreal.ca  | Structurer le README  |
| 1.2  | francis.forget@umontreal.ca  | Validation d'erreurs  |

## 0. Mentalite de compilation
R est un logiciel pouvant supporter une panoplie de librairies provenant de la communaute Open-Source entreposees sur CRAN-R.org.

Il faut installer R et par la suite, a l'interieur de l'application, il faut invoquer une commande R pour installer une librairie.
<code>
install.packages(nom_de_la_librairie)
</code>

Etapes: telechargement des sources --> installation des packgages systemes --> modification du code des sources --> compilation --> installation --> configuration finale.

## 1. Installation

### 1.1 Pre-installation (geree par le playbook):

#### 1.1.1 Dependances systeme pour la compilation du core R
dnf install `git-core gcc-gfortran readline-devel xorg-x11-server-devel libX11-devel libXt-devel xz-devel pcre2-devel libcurl-devel java-latest-openjdk java-latest-openjdk-devel toto`

#### 1.1.2 Dependances systeme pour permettre l'installation des librairies R supplementaires
dnf install `hdf5 hdf5-devel cairo-devel libxml2-devel openssl-devel libgit2-devel libjpeg-turbo-devel cmake`

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

Les grandes etapes que l'on retrouve dans le script `install` :
1. Telecharger les sources si necessaire;
2. Compiler les sources;
3. Configurer le repo R pour l'acces aux librairies R supplementaires 
4. Rouler le script R qui isntalle l'ensemble des librairies connues 
5. Deployer le modulefile pour simplifier l'acces a l'application R

N.B. Le package SAMR (derniere mise a jour en 2018) demande n'est plus compatible avec la version de R > 4.1


## 2. Supression

### 2.1 Parametres contextuel

| Contexte  | Ordre envoyee par le playbook| Nom de la variable dans les scripts  |
|---|---|---|
| Repertoire d'installation         | ${1} | PATH_TO_INSTALL
| Repertoire des modulefiles        | ${2} | MODULEFILES_DIR

### 2.2 Procedure:

Les grandes etapes que l'on retrouve dans le script `uninstall` :
1. Supprimer le repertoire de l'application;
2. Supprimer le modulefiles


## 3. AJout de librairies

En tant que root sur le serveur de compilation, executer dans `R`

<code> 
PACKAGE="NOM_DU_PACKAGE"

if(! (is.element(PACKAGE, installed.packages()[,1])) ) { install.packages(PACKAGE) }
</code>

Si l'installation necessite une/des librairie/s supplementaire/s, en faire la demande aupres des administrateurs de systeme et de les inscrires dans la presente documentation a la [section 1.1.2](#112-deoendances-systeme-pour-permettre-dinstaller-des-librairies-r-supplementaires)