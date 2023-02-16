#! /usr/bin/bash

set -x
set -e

if [ -z $WORKLOAD_HOME ]
then
	export WORKLOAD_HOME=/root/workload-kkc/
fi

if [ ! -d $WORKLOAD_HOME/sources/snap/ ]
then
	cd $WORKLOAD_HOME/sources/;
	git submodule add https://github.com/amplab/snap.git;
fi

cd ${WORKLOAD_HOME}/sources/snap

make

./snap-aligner index ${WORKLOAD_HOME}/datasets/snap/datatest.fa ${WORKLOAD_HOME}/temp/index-dir/

/usr/bin/time -v ./snap-aligner single ${WORKLOAD_HOME}/temp/index-dir/ ${WORKLOAD_HOME}/datasets/snap/datatest.fq -o ${WORKLOAD_HOME}/evaluation/output_snap_"$(date "+%H:%M:%S")".sam 2>${WORKLOAD_HOME}/evaluation/output_snap_time_"$(date "+%H:%M:%S")".txt
