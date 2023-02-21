#! /usr/bin/bash
set -e

# Variable

# Local
params=()

# Global

##########################################################
##########################################################

# Functions
function loadConfigure(){
while read line
do
    if [[ "$line" == \#* ]]; then
      continue
    fi
    if [ -z "$line" ]; then
      continue;
    fi
    params+=("$line")
done < ${dir_local}/conf/quicksort.conf
}

function runQuicksort(){
cd ${dir_local}/sources/cfm/quicksort

/usr/bin/time -v ./quicksort ${params[*]} 2>${dir_local}/evaluation/output_quicksort_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_quicksort_"$(date "+%H:%M:%S")".txt
}

##########################################################
##########################################################

# Execution

loadConfigure;
runQuicksort;
