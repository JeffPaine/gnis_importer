# gnis_importer
A simple makefile to download the entire [Geographic Names Information System](http://nhd.usgs.gov/gnis.html) dataset and import it into a PostgreSQL database. Additional data available on the GNIS [download page](http://geonames.usgs.gov/domestic/download_data.htm).

## Why
The GNIS contains the Federally recognized name and location data of roughly 2.2 million geographic features in the United States. This tool just makes it easier to download and access that data.

## Installation

```bash
$ git clone git@github.com:JeffPaine/gnis_importer.git
$ cd gnis_importer
# Run commands outlined below as desired
```

## Usage

### Download and Import to PostgreSQL
```bash
$ make
```
Downloads the complete GNIS database. Creates a database named `gnis`. Imports all features into a table named `features`.

### Download
```bash
$ make download
```
Downloads the GNIS database in `|` (pipe) delimited form.

### Import to PostgreSQL
```bash
$ make import
```

Imports the GNIS data into a postgres database named `gnis` and into a table named `features`.
