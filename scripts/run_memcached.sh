#! /usr/bin/bash

# Variables

# Local Variable
params_memaslap=()

#######################################################
#######################################################

function initMemcached(){
echo "flush_all" | nc 127.0.0.1 11211
}

function loadConfigure(){
while read line
do
  if [[ "$line" == \#* ]]; then
    continue
  fi
  if [ -z "$line" ]; then
    continue
  fi
  params_memaslap+=("$line")
done < ${dir_local_conf}/memaslap.conf
}

function runMemcached(){
/usr/bin/time -v memaslap ${params_memaslap[*]} 2>${dir_local}/evaluation/output_memcached_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_memcached_"$(date "+%H:%M:%S")".txt
}

function startMemcached(){
status=$(systemctl is-active memcached)

if [ "$status" == "active" ]; then
  echo "memcached service is running"
else
  echo "memcached service is not running"
  sudo systemctl start memcached
fi
}

#######################################################
#######################################################

# Execution

initMemcached;
loadConfigure;
startMemcached;
runMemcached;
