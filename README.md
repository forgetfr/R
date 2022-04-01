
# R version 4.1.3

Site officiel de l'application: [CRAN-R](https://cran.r-project.org/).

## Controle des **versions**:

<table>
<tr>
    <td>Version</td><td>Auteur</td><td>Description</td>
</tr><tr>
    <td>0.1</td><td>francis.forget@umontreal.ca</td><td>Installation vanille</td>
</tr><tr>
    <td>0.2</td><td>francis.forget@umontreal.ca</td><td>Ajouter une action au script "delete|install"</td>
</tr><tr>
    <td>0.4</td><td>francis.forget@umontreal.ca</td><td>Ajouter les librairies R supplementaires demandees par le client</td>
</tr><tr>
    <td>0.5</td><td>francis.forget@umontreal.ca</td><td>Rediriger le stdout et stderr dans un fichier temporaire</td>
</tr><tr>
    <td>1.0</td><td>francis.forget@umontreal.ca</td><td>Integration a l'environnement de deploiement</td>
</tr>
</table>

## Pre-requis a inserer dans le playbook:
### Dependances systeme pour le playbook
`git-core`

### Dependances systeme pour la compilation
`gcc-gfortran readline-devel xorg-x11-server-devel libX11-devel libXt-devel xz-devel pcre2-devel libcurl-devel java-latest-openjdk`

### Librairies system hdfr5 pour permettre de rouler des librairies R supplementaires
`hdf5 hdf5-devel`

## Parametres contextuel

PATH_TO_INSTALL="${1}/R/R-${VERSION}"   # Repertoire d'installation
LOCAL_ARTEFACT="${2}"                   # Depot UdeM des sources externes;
WORKING_BUILD="${3}"                    # Repertoire de compilation 
GIT_DIR=`dirname $0`                    # Repertoire courant qui contiendra tous les fichiers de git.
ACTION="$4"                             # Gestion du cycle de vie de l'application

Utiliser le repo CRAN: <https://cran.utstat.utoronto.ca/>

## Installation
Les grandes etapes que l'on retrouve dans le script `installation.sh` :
1. Telecharger les sources si necessaire;
2. Compiler les sources;
3. Configurer le repo R pour l'acces aux librairies R supplementaires 
4. Rouler le script R qui isntalle l'ensemble des librairies exiges et l'executer
5. Preparer un modulefile pour simplifier l'acces a l'application R

## Notes:

