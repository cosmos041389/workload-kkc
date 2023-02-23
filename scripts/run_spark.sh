#! /usr/bin/bash

# Variable

# Local
params=()
target=

# Global

##################################################################
##################################################################

# Functions

function loadConfigure(){
sed -n '/## LIST/,/## LIST/p' ${dir_local_conf}/spark.conf >tmp
while read line
do
    if [[ "$line" == \#* ]]; then
      continue
    fi
    if [ -z "$line" ]; then
      continue;
    fi
    target="$line"
done < tmp
rm tmp

sed -n "/## ${target}/,/## ${target}/p" "${dir_local_conf}/spark.conf" >tmp
while read line
do
    if [[ "$line" == \#* ]]; then
      continue
    fi
    if [ -z "$line" ]; then
      continue;
    fi
    params+=("$line")
done < tmp
rm tmp
}

function runSpark(){
cd ${dir_local_sources}/spark-3.3.2-bin-hadoop3

/usr/bin/time -v bin/spark-submit ${dir_local}/datasets/spark/${target}.jar ${params[*]} 2>${dir_local}/evaluation/output_spark_PageRank_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_spark_PageRank_"$(date "+%H:%M:%S")".txt
}

##################################################################
##################################################################

# Execution

loadConfigure;
echo $target
echo ${params[*]}
runSpark;
