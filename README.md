# gnis_importer
A simple makefile to download the [Geographic Names Information System](http://nhd.usgs.gov/gnis.html) and import it into a PostgreSQL database.

## Usage

```bash
$ make
```
Downloads the complete GNIS database. Creates a database named `gnis`. Imports all features into a table named `features`.

```bash
$ make download
```
Downloads the GNIS database in | delimited form.


```bash
$ make import
```

Imports the GNIS data into a postgres database named `gnis` and into a table named `features`.

## Installation

```bash
$ git clone git@github.com:JeffPaine/gnis_importer.git
$ cd gnis_importer
# Run commands as desired
```
