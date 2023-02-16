#! /usr/bin/bash

# Variable

# Local variable

# Global variable

###########################################################
###########################################################

function runHashjoin(){
cd ${dir_local}/sources/mitosis-workload-hashjoin

/usr/bin/time -v ./bin/bench_hashjoin_st 2>${dir_local}/evaluation/output_hashjoin_st_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_hashjoin_st_"$(date "+%H:%M:%S")".txt

/usr/bin/time -v ./bin/bench_hashjoin_mt 2>${dir_local}/evaluation/output_hashjoin_mt_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_hashjoin_mt_"$(date "+%H:%M:%S")".txt
}

###########################################################
###########################################################

runHashjoin;
