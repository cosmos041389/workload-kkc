#! /usr/bin/bash

# Variables

# Local Variable
# NOTICE
# -p memcached.hosts must be given mannually at line 50, 52
options="
memcached.shutdownTimeoutMillis
memcached.objectExpirationTime
memcached.checkOperationStatus
memcached.readBuffersize
memcached.opTimeoutMillis
memcached.failureMode
memcached.protocol
"
defaults=("default:none" "default:Integer.MAX_VALUE" "default:true" "default:none" "default:none" "default:none" "default:none")
params=()
cnt=0
threads=
target=
record=
operation=

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

function getArg(){
echo "If you want to skip the option, just press [ENTER]"
for option in ${options[@]}
do
	read -p "$option(${defaults[$cnt]})=" answer
	if [ ! -z $answer ]
	then
		params+="-p ${option}=${answer} "
	fi
	cnt=$((cnt+1))
done
read -p "threads(default:8)=" threads
read -p "target(default:1000)=" target
read -p "recordcount(default:10000)=" record
read -p "operationcount(default:10000)=" operation
if [ -z $threads ]; then threads=8 ;fi
if [ -z $target ]; then target=1000 ;fi
if [ -z $record ]; then record=10000; fi
if [ -z $operation ]; then operation=10000; fi
echo $params
}

function runMemcached(){
local DATASET="${dir_local}/datasets/ycsb_datasets.lnk"

mapfile -t files < <(ls "$DATASET")

for i in "${!files[@]}"; do
  echo "$i: ${files[i]}"
done

read -p "Choose number dataset to test: " answer
echo "${files[answer]}"
echo "threads:$threads target:$target record:$record operation:$operation"

/usr/bin/time -v ${YCSB_HOME}/bin/ycsb load memcached -s -P ${dir_local}/datasets/ycsb_datasets.lnk/${files[answer]} -threads $threads -target $target -p recordcount=$record -p "memcached.hosts=127.0.0.1" ${params[*]} 2>${dir_local}/evaluation/output_ycsb_memcached_load_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_ycsb_memcached_load_"$(date "+%H:%M:%S")".txt
echo ""
/usr/bin/time -v ${YCSB_HOME}/bin/ycsb run memcached -s -P ${dir_local}/datasets/ycsb_datasets.lnk/${files[answer]} -threads $threads -target $target -p operationcount=$operation -p "memcached.hosts=127.0.0.1" ${params[*]} 2>${dir_local}/evaluation/output_ycsb_memcached_run_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_ycsb_memcached_run_"$(date "+%H:%M:%S")".txt
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
getArg;
startMemcached;
runMemcached;
