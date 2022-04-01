
# R version 4.1.3

Site officiel de l'application: [CRAN-R](https://cran.r-project.org/).

## Controle des **versions**:

| Version  | Auteur  | Description  |
|---|---|---|
| 0.1  | francis.forget@umontreal.ca  | Installation vanille  |
| 0.8  | francis.forget@umontreal.ca  | Ajouter les librairies R supplementaires demandees par le client  |
| 0.9  | francis.forget@umontreal.ca  | Rediriger le stdout et stderr dans un fichier temporaire  |
| 1.0  | francis.forget@umontreal.ca  | Integration a l'environnement de deploiement  |


## Pre-requis a inserer dans le playbook:
### Dependances systeme pour le playbook
`git-core`

### Dependances systeme pour la compilation
`gcc-gfortran readline-devel xorg-x11-server-devel libX11-devel libXt-devel xz-devel pcre2-devel libcurl-devel java-latest-openjdk`

### Librairies system hdfr5 pour permettre de rouler des librairies R supplementaires
`hdf5 hdf5-devel`

## Parametres contextuel

| Contexte  | Parametres envoyes par le playbook  |
|---|---|
| Repertoire d'installation         | PATH_TO_INSTALL="${1}/R/R-${VERSION}"
| Depot UdeM interne des artefacts  | LOCAL_ARTEFACT="${2}"
| Repertoire de compilation         | WORKING_BUILD="${3}" 
| Repertoire courant qui contiendra tous les fichiers de git  |  GIT_DIR=\`dirname $0\`

Utiliser le repo CRAN: <https://cran.utstat.utoronto.ca/>

## Installation
Les grandes etapes que l'on retrouve dans le script `installation.sh` :
1. Telecharger les sources si necessaire;
2. Compiler les sources;
3. Configurer le repo R pour l'acces aux librairies R supplementaires 
4. Rouler le script R qui isntalle l'ensemble des librairies exiges et l'executer
5. Preparer un modulefile pour simplifier l'acces a l'application R

## Notes:

