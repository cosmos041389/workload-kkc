#! /usr/bin/bash
set -e

# Variable

# Local

# Global

##############################################################
##############################################################

function runSnap(){
cd ${dir_local}/sources/snap

./snap-aligner index ${dir_local}/datasets/snap/datatest.fa ${dir_local}/temp/index-dir/

/usr/bin/time -v ./snap-aligner single ${dir_local}/temp/index-dir/ ${dir_local}/datasets/snap/datatest.fq -o ${dir_local}/evaluation/output_snap_"$(date "+%H:%M:%S")".sam 2>${dir_local}/evaluation/output_snap_time_"$(date "+%H:%M:%S")".txt
}

##############################################################
##############################################################

runSnap;
