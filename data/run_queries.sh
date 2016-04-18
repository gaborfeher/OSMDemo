#!/bin/bash

# Get streets script version 2.

ID="0"
while read STREET; do
  ID=$(($ID + 1))
  echo "STREET= ${STREET} ID=${ID}"
  sleep 30
  wget http://overpass-api.de/api/kill_my_queries -O /dev/null
  sleep 10

# Use https://overpass-turbo.eu/ to construct such queries.
# (Gets a street name of Budapest, IX. kerület. (That's the area(NNNN).)
# Previous version:
#   way["highway"="residential"]["name"="${STREET}"](area.searchArea);
  cat >post-file.txt <<EOF
[out:xml][timeout:180];
area(3601552462)->.searchArea;
(
  way["name"="${STREET}"](area.searchArea);
);
out body;
>;
out skel qt;
EOF
  RESULT_FILE="data_${ID}"
  rm -f ${RESULT_FILE}.osm
  wget "http://overpass-api.de/api/interpreter" --post-file post-file.txt -O ${RESULT_FILE}.osm
done <streets.txt

