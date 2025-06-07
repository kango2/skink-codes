#!/bin/bash

#
export workingdir="/path/to/workingdir" #Directory where your copy of config.sh is in
export raw_dir="/path/to/directory_with_raw_sequences" #directory containing all of your raw fastq files, can not be in any sub-directories
export R1_identifier="_R1.fq.gz" #the file extension of your forward sequence file, usually contains "R1"
export R2_identifier="_R2.fq.gz" #the file extension of your reverse sequence file, usually contains "R2"



##                              v1.1                                    ##
##                      END CONFIGURATION AREA                          ##
##----------------------------------------------------------------------##
##----------------------------------------------------------------------##
##  Do not edit below this line                                         ##
##----------------------------------------------------------------------##

mkdir -p ${workingdir}
if [ -d "$raw_dir" ] && [ "$(ls -A "$raw_dir")" ]; then
    echo "$raw_dir exist and contain files, now generating inputs.csv"
    for i in ${raw_dir}/*${R1_identifier}; do
        filename=$(basename ${i/$R1_identifier/})
        R1_PATH="$i"
        R2_PATH="${raw_dir}/${filename}${R2_identifier}"
        echo -e "${filename},${filename},${R1_PATH},${R2_PATH}"
    done > ${workingdir}/inputs.csv
else
    echo "The raw_dir directory either does not exist or is empty. Stopping script"
    exit 1
fi
