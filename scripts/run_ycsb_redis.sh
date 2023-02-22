#! /bin/bash

# Variable

# Local
YCSB_HOME=${dir_local}/sources/ycsb-0.17.0
params_redis=()
params_ycsb=()

# Global

###########################################################
###########################################################

# Functions

function loadConfigure(){
sed -n '/# REDIS/,/# REDIS/p' ${dir_local_conf}/ycsb.conf >tmp
while read line
do
    if [[ "$line" == \#* ]]; then
      continue
    fi
    if [ -z "$line" ]; then
      continue;
    fi
    params_redis+=("-p $line")
done < tmp
rm tmp

sed -n '/# COMMON/,/# COMMON/p' ${dir_local_conf}/ycsb.conf >tmp
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

echo ${params_redis[@]}
echo ${params_ycsb[@]}
}

function startRedis(){
status=$(systemctl is-active redis)

if [ "$status" == "active" ]
then
  echo "redis is running."
else
  echo "redis is not running."
  systemctl start redis; sleep 5
fi
}

function runRedis(){
/usr/bin/time -v ${YCSB_HOME}/bin/ycsb load redis -s -P ${dir_local}/datasets/ycsb_datasets.lnk/workloada ${params_redis[*]} ${params_ycsb[*]} 2>${dir_local}/evaluation/output_ycsb_redis_load_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_ycsb_redis_load_"$(date "+%H:%M:%S")".txt
echo ""
/usr/bin/time -v ${YCSB_HOME}/bin/ycsb run redis -s -P ${dir_local}/datasets/ycsb_datasets.lnk/workloada ${params_redis[*]} ${params_ycsb[*]} 2>${dir_local}/evaluation/output_ycsb_redis_run_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_ycsb_redis_run_"$(date "+%H:%M:%S")".txt
}

###########################################################
###########################################################

# Execution

loadConfigure;
startRedis;
runRedis;
