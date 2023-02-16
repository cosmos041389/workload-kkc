#! /usr/bin/bash
set -e

# Variable

# Local variable


# Global variable


##########################################################
##########################################################

# Functions

function runBtree(){
cd ${dir_local}/sources/mitosis-workload-btree

/usr/bin/time -v ./bin/bench_btree_st 2> ${dir_local}/evaluation/output_btree_st_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_btree_st_"$(date "+%H:%M:%S")".txt

/usr/bin/time -v ./bin/bench_btree_mt 2> ${dir_local}/evaluation/output_btree_mt_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_btree_mt_"$(date "+%H:%M:%S")".txt
}

##########################################################
##########################################################

# Execution

runBtree;
