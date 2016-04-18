#!/bin/bash

# Get streets script version 2.

for FILE in *.osm; do
  OUTFILE="$(basename ${FILE} .osm).geojson"
  rm -f ${OUTFILE}
  ogr2ogr --config OSM_USE_CUSTOM_INDEXING NO -F GeoJSON ${OUTFILE} ${FILE} lines
done <streets.txt

./makejson.py >streetgeo.json
