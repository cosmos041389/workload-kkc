#! /usr/bin/bash

# Variable

# Local variable
params=()

# Global variable

###########################################################
###########################################################

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
done < ${dir_local}/conf/hashjoin.conf
}

function runHashjoin(){
cd ${dir_local}/sources/mitosis-workload-hashjoin

for param in "${params[@]}"; do
  /usr/bin/time -v ./bin/$param 2>${dir_local}/evaluation/output_${param:6}_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_${param:6}_"$(date "+%H:%M:%S")".txt
done
}

###########################################################
###########################################################

loadConfigure;
runHashjoin;
