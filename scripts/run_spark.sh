#! /usr/bin/bash

# Variable

# Local
params=()
target=
arguments=()

# Global

##################################################################
##################################################################

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
done < ${dir_local_conf}/spark.conf

target=${params[0]}
for element in "${params[@]}"; do
  if [ "$target" == "$element" ]; then
    continue;
  fi
  arguments+=("$element")
done
}

function runSpark(){
cd ${dir_local_sources}/spark-3.3.2-bin-hadoop3

echo "${target} ${arguments[*]}"
/usr/bin/time -v bin/spark-submit ${dir_local}/datasets/spark/${target}.jar ${arguments[*]} 2>${dir_local}/evaluation/output_spark_PageRank_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_spark_PageRank_"$(date "+%H:%M:%S")".txt
}

##################################################################
##################################################################

# Execution

loadConfigure;
runSpark;
