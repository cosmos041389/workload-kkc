#! /usr/bin/bash
set -x
set -e

if [ -z $WORKLOAD_HOME ]
then
        export WORKLOAD_HOME=/root/workload-kkc/
fi

cd ${WORKLOAD_HOME}/sources/cfm/quicksort

read -p "Number of MB to generate: " input

/usr/bin/time -v ./quicksort $input 2>${WORKLOAD_HOME}/evaluation/output_quicksort_time_"$(date "+%H:%M:%S")".txt | tee ${WORKLOAD_HOME}/evaluation/output_quicksort_"$(date "+%H:%M:%S")".txt
