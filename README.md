
# R version 4.1.3

Site officiel de l'application: [CRAN-R](https://cran.r-project.org/).

## Controle des **versions**:

<table>
<tr>
    <td>Version</td><td>Auteur</td><td>Description</td>
</tr><tr>
    <td>1.0</td><td>francis.forget@umontreal.ca</td><td>Installation vanille</td>
</tr><tr>
    <td>1.1</td><td>francis.forget@umontreal.ca</td><td>Ajouter une action au script "delete|install"</td>
</tr>
</table>

---

## Pre-requis dans le playbook:

### Dependances systeme pour la compilation
`gcc-gfortran readline-devel xorg-x11-server-devel libX11-devel libXt-devel xz-devel pcre2-devel libcurl-devel java-latest-openjdk`

### Librairie hdfr5 pour les modules R supplementaires
`hdf5 hdf5-devel`

---

## Contexte

Repertoire d'installation: /usr/local/R/R-**${VERSION}**

Utiliser le repo CRAN: <https://cran.utstat.utoronto.ca/>

---

## Installation

Pour l'installation, lire le script `installation.sh`

Les etapes:
1. Telecharger les sources;
2. Compiler les sources;
3. Configurer le repo ### ceci empeche de nous poser la question a chaque installer des modules
4. Creer un script R qui contient l'ensemble des modules exiges et l'executer

A noter:

