#! /usr/bin/bash

set -x
set -e

if [ -z $WORKLOAD_HOME ]
then
	export WORKLOAD_HOME=/root/workload-kkc/
fi

cd ${WORKLOAD_HOME}/sources/mitosis-workload-hashjoin

make

/usr/bin/time -v ./bin/bench_hashjoin_st 1>${WORKLOAD_HOME}/evaluation/output_hashjoin_st_"$(date "+%H:%M:%S")".txt 2>${WORKLOAD_HOME}/evaluation/output_hashjoin_st_time_"$(date "+%H:%M:%S")".txt

/usr/bin/time -v ./bin/bench_hashjoin_mt 1>${WORKLOAD_HOME}/evaluation/output_hashjoin_mt_"$(date "+%H:%M:%S")".txt 2>${WORKLOAD_HOME}/evaluation/output_hashjoin_mt_time_"$(date "+%H:%M:%S")".txt
