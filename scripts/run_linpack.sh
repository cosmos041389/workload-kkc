#! /usr/bin/bash

# Variable

# Local variable

# Global variable

#########################################################
#########################################################

# Functions

function runLinpack(){
cd ${dir_local}/sources/cfm/linpack

/usr/bin/time -v bash runme_xeon64 2>${dir_local}/evaluation/output_linpack_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_linpack_"$(date "+%H:%M:%S")".txt
}

#########################################################
#########################################################

# Execution

runLinpack;
