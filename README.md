# label_pipeline [![Build Status](https://travis-ci.org/trump-fmi/label_pipeline.svg?branch=master)](https://travis-ci.org/trump-fmi/label_pipeline)

## Short description

Meta project to perform label data import from .osm.pbf files and compute the label elimination sequence afterwards


## Quickstart
To clone the project use `git clone --recursive https://github.com/krumpefp/label_pipeline.git` in order to initialise submodules.

Using Linux: To install the project use the following commands:
- `cd label_pipeline`
- `sh install.sh`
Hopefully there are no compile errors

To compute a labeling:
1) Create a <config> or use one from `config/`
2) Download an <osm.pbf> file (f.e. from [geofabrik](https://download.geofabrik.de/europe/germany/baden-wuerttemberg-latest.osm.pbf))
3) Perform the following command
- `cd bin`
- `./pipeline <config> <osm.pbf>`

This will create a new .ce file in the bin directory
