#!/bin/bash

# Get streets script version 2.

ID="0"
while read STREET; do
  ID=$(($ID + 1))
  echo "STREET= ${STREET} ID=${ID}"
  sleep 30
  wget http://overpass-api.de/api/kill_my_queries -O /dev/null
  sleep 10

# Query to get a street name located in Budapest, 9th district.
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

# To obtain such queries, there are several possibilities, e.g.:
# 1. Search and get the area code at http://www.openstreetmap.org/
#    (Use "IX. kerület" as a name. Prepend 360 to the resulting id.)
#    Substitute area code into this query.
# 2. Use overpass-turbo.eu, go to Query Wizard
#    Enter something like: name="Üllői út" in "IX. kerület"
#    Export the query to text.
