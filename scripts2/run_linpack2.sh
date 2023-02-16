#! /usr/bin/bash
set -x
set -e

if [ -z $WORKLOAD_HOME ]
then
        export WORKLOAD_HOME=/root/workload-kkc/
fi

cd ${WORKLOAD_HOME}/sources/cfm/linpack

/usr/bin/time -v bash runme_xeon64 2>${WORKLOAD_HOME}/evaluation/output_linpack_time_"$(date "+%H:%M:%S")".txt | tee ${WORKLOAD_HOME}/evaluation/output_linpack_"$(date "+%H:%M:%S")".txt
