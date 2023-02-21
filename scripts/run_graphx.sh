#! /usr/bin/bash

# Variable
# Local variable
params=()
target=


# Global variable


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
done < ${dir_local_conf}/graphx.conf

if [ "${#params[@]}" -gt 1 ]; then
  echo "More than 2 examples are chosen. Exit with 1."
  exit 1;
fi
}

function runGraphx(){
cd ${dir_local_sources}/spark-3.3.2-bin-hadoop3
/usr/bin/time -v bin/spark-submit ${dir_local}/datasets/graphx/"${params[*]}".jar 2>${dir_local}/evaluation/output_graphx_"${params[*]}"_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_graphx_"${params[*]}"_"$(date "+%H:%M:%S")".txt
}

##########################################################
##########################################################

# Execution

loadConfigure;
runGraphx;
