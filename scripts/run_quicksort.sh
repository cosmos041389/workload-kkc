#! /usr/bin/bash
set -e

# Variable

# Local

# Global

##########################################################
##########################################################

# Functions

function runQuicksort(){
cd ${dir_local}/sources/cfm/quicksort

/usr/bin/time -v ./quicksort $input 2>${dir_local}/evaluation/output_quicksort_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_quicksort_"$(date "+%H:%M:%S")".txt
}

function getArg(){
read -p "Number of MB to generate: " input
}

##########################################################
##########################################################

# Execution

getArg;
runQuicksort;
