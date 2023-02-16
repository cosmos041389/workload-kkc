#! /bin/bash

# Variable

# Local
YCSB_HOME=${dir_local}/sources/ycsb-0.17.0
# NOTICE
# -p redis.host must be modified mannually at line 
# -p redis.port must be modified mannually at line
options=("redis.password" "redis.cluster")
defaults=("default:none" "default:false")
params=()
cnt=0

# Global

###########################################################
###########################################################

# Functions

function getArg(){
echo "If you want to skip the option, just press [ENTER]."
for option in ${options[@]}
do
	read -p "$option(${defaults[$cnt]})=" answer
	if [ ! -z $answer ]
	then
		params+="-p ${option}=${answer} "
	fi
	cnt=$((cnt+1))
done

echo $params
}

function startRedis(){
status=$(systemctl is-active aerospike)

if [ "$status" == "active" ]
then
  echo "redis is running."
else
  echo "redis is not running."
  systemctl start redis;
fi
}

function runRedis(){
/usr/bin/time -v ${YCSB_HOME}/bin/ycsb load redis -s -P ${dir_local}/datasets/ycsb_datasets.lnk/workloada -p "redis.host=127.0.0.1" -p "redis.port=6379" ${params[*]}  2>${dir_local}/evaluation/output_ycsb_redis_load_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_ycsb_redis_load_"$(date "+%H:%M:%S")".txt

/usr/bin/time -v ${YCSB_HOME}/bin/ycsb run redis -s -P ${dir_local}/datasets/ycsb_datasets.lnk/workloada -p "redis.host=127.0.0.1" -p "redis.port=6379" ${params[*]} 2>${dir_local}/evaluation/output_ycsb_redis_run_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_ycsb_redis_run_"$(date "+%H:%M:%S")".txt
}

###########################################################
###########################################################

# Execution

getArg;
startRedis;
runRedis;
