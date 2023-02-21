#! /usr/bin/bash

# Variables

# Local Variable
params_ycsb=()

# Global Variable
if [ -z ${dir_local} ]
then
	export WORKLOAD_HOME=/home/$USER/workload-kkc/
fi

cd ${dir_local}/sources/ycsb-0.17.0
export YCSB_HOME=$(pwd)


#################################################################
#################################################################

# Functions

function initMemcached(){
echo "flush_all" | nc 127.0.0.1 11211
}

function loadConfigure(){
sed -n '/# MEMCACHED/,/# MEMCACHED/p' ${dir_local_conf}/ycsb.conf >tmp
while read line
do
    if [[ "$line" == \#* ]]; then
      continue
    fi
    if [ -z "$line" ]; then
      continue;
    fi
    params_ycsb+=("-p $line")
done < tmp
rm tmp
}

function runMemcached(){
/usr/bin/time -v ${YCSB_HOME}/bin/ycsb load memcached -s -P ${dir_local}/datasets/ycsb_datasets.lnk/workloada ${params_ycsb[*]} 2>${dir_local}/evaluation/output_ycsb_memcached_load_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_ycsb_memcached_load_"$(date "+%H:%M:%S")".txt
echo ""
/usr/bin/time -v ${YCSB_HOME}/bin/ycsb run memcached -s -P ${dir_local}/datasets/ycsb_datasets.lnk/workloada ${params_ycsb[*]} 2>${dir_local}/evaluation/output_ycsb_memcached_run_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_ycsb_memcached_run_"$(date "+%H:%M:%S")".txt
}

function startMemcached(){
stat=$(systemctl is-active memcached)
if [ "$stat" == "active" ]; then
	echo "memcached service is running"
else
	echo "memcached service is not running"
	sudo systemctl start memcached; sleep 5
fi  
}

##############################################################
##############################################################

# Execution

initMemcached;
loadConfigure;
startMemcached;
runMemcached;
