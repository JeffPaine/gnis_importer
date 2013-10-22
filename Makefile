# gnis_importer
# https://github.com/JeffPaine/gnis_importer

# Database settings (change as needed)
DATABASE_NAME = 'gnis'
FEATURES_TABLE_NAME = 'features'


all: \
	download \
	import

clean:
	rm -rf original/


download: original/all_gnis_data.txt

# Unzip file and update modified datetime
original/all_gnis_data.txt: original/all_gnis_data.zip
	unzip -p -q -n $< | cat > $@
	touch $@

# Download GNIS data in | (pipe) delimited format
# http://geonames.usgs.gov/domestic/download_data.htm
original/all_gnis_data.zip:
	mkdir -p $(dir $@)
	wget http://geonames.usgs.gov/docs/stategaz/NationalFile_20131020.zip --output-document=$@.download
	mv $@.download $@

# Create database DATABASE_NAME and import features into table named FEATURES_TABLE_NAME
import: original/all_gnis_data.txt
	createdb $(DATABASE_NAME)
	psql $(DATABASE_NAME) --command "CREATE TABLE "$(FEATURES_TABLE_NAME)" ("FEATURE_ID" INTEGER NOT NULL, "FEATURE_NAME" VARCHAR(1919), "FEATURE_CLASS" VARCHAR(15) NOT NULL, "STATE_ALPHA" VARCHAR(2) NOT NULL, "STATE_NUMERIC" VARCHAR(2) NOT NULL, "COUNTY_NAME" VARCHAR(26), "COUNTY_NUMERIC" VARCHAR(4), "PRIMARY_LAT_DMS" VARCHAR(7) NOT NULL, "PRIM_LONG_DMS" VARCHAR(8) NOT NULL, "PRIM_LAT_DEC" FLOAT NOT NULL, "PRIM_LONG_DEC" FLOAT NOT NULL, "SOURCE_LAT_DMS" VARCHAR(7), "SOURCE_LONG_DMS" VARCHAR(8), "SOURCE_LAT_DEC" FLOAT, "SOURCE_LONG_DEC" FLOAT, "ELEV_IN_M" INTEGER, "ELEV_IN_FT" INTEGER, "MAP_NAME" VARCHAR(33) NOT NULL, "DATE_CREATED" DATE, "DATE_EDITED" DATE);"
	psql $(DATABASE_NAME) --command "COPY features FROM '$(abspath $<)' WITH CSV HEADER DELIMITER '|';"
