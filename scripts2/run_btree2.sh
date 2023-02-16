#! /usr/bin/bash

set -x
set -e

if [ -z $WORKLOAD_HOME ]
then
	export WORKLOAD_HOME=/root/workload-kkc/
fi

cd ${WORKLOAD_HOME}/sources/mitosis-workload-btree

make

/usr/bin/time -v ./bin/bench_btree_st 2> $WORKLOAD_HOME/evaluation/output_btree_st_time_"$(date "+%H:%M:%S")".txt | tee $WORKLOAD_HOME/evaluation/output_btree_st_"$(date "+%H:%M:%S")".txt

/usr/bin/time -v ./bin/bench_btree_mt 2> $WORKLOAD_HOME/evaluation/output_btree_mt_time_"$(date "+%H:%M:%S")".txt | tee $WORKLOAD_HOME/evaluation/output_btree_mt_"$(date "+%H:%M:%S")".txt
