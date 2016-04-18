#!/usr/bin/python

import glob
import os
import sys


import json


def process_file(fname, data, dbg):
  if dbg:
    print fname,
  with open(fname) as data_file:
    parsed_data = json.load(data_file)
  features = parsed_data['features']
  if len(features) < 1:
    if dbg:
      print 'empty'
  else:
    feature = features[0]
    name = feature['properties']['name']
    if dbg:
      print name
    data[name] = parsed_data

def main(argv):
  dbg = len(argv) > 1 and argv[1] == '--debug'
  files = glob.glob('data*.geojson')
  files.sort()
  data = {}
  for fname in files:
    process_file(fname, data, dbg)
  if not dbg:
    print json.dumps(data)

if __name__ == "__main__":
  main(sys.argv)

