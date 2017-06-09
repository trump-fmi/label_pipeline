#!/bin/bash

# The script unifies the process to create a label elimination order out of a
# given .osm.pbf file.

function quit {
	cd ..
	rm -r $tmpDir

	exit $1
}

function help {
  	echo "
The following input is required to be provided:
  (1) config.json	-   a config file to controll the input (json formated)
  (2) input.osm.pbf	-   a osm .pbf file the data should be imported from
"
}

osm_input_bin="vendor/osm_input/osm_input"
gb_bin="vendor/growing_balls/growing_balls"
echo "
  This shell script executes the pipeline to perform the following steps to
  compute a label elimination order that allows for non overlapping label
  visualization.
  Please ensure that the following programms are compiled and available in the
  current directory:
    (1) ${osm_input_bin}		-  to read the osm data
    (2) ${gb_bin}	-  to compute the elimination sequence

"

if [ "${1} != "" ] && [ -e "${1}" ]
   && [ "${2} != "" ] && [ -e "${2}" ]; then
   	if [[ ${1} == *.pbf ]]; then
		osm_file=${1}
		config_file=${2}
	else
		osm_file=${2}
		config_file=${1}
	fi
else
	help
	exit 1
fi

# turn the input file names to absolute paths
osm_file=$(realpath $osm_file)
config_file=$(realpath $config_file)

# create a temporary folder to perform the actual computation
tmpDir=".tmp"
while [ -d  $tmpDir ]; do
  read -e -p "${tmpDir} already exists.
  Please specify a new temporary directory name >" tmpDir
done

# turn to absolute paths
osm_input_bin=$(realpath ${osm_input_bin})
gb_bin=$(realpath ${gb_bin})

# cd to the temporary directory
mkdir $tmpDir
cd $tmpDir

# perform the osm input
# [BUG] add -tc 1 to prevent a bug in the osm_input software
cmd="${osm_input_bin} -C ${config_file} -i ${osm_file} -tc 1"
echo "Executing the following command to import the pbf data:
  ${cmd}"
eval $cmd

cmplt=$(find . -name *.complete.txt)
if [ ! -e "${cmplt}" ]; then
	echo "osm_input did not stop as expected. Aborting!"
	quit 1
fi

# perform the computation of the elimination sequence
cmd="${gb_bin} ${cmplt}"
echo "Executing the following command to compute the elimination sequence:
  ${cmd}"
eval $cmd

eo=$(find . -name *.eo)
if [ ! -e "${eo}" ]; then
	echo "Computing the elimination sequence did not stop as expected.\
	      Aborting!"
	quit 1
fi

mv eo ..
quit 0
