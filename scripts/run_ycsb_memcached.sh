#! /usr/bin/bash

# Variables

# Local Variable
YCSB_HOME=${dir_local}/sources/ycsb-0.17.0

# For Configure properties
params_memcached=()
params_ycsb=()
declare -A params

# Global Variable

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
    params_memcached+=("-p $line")
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
    params["${line%%=*}"]="${line#*=}"
done < tmp
rm tmp

sed -n '/# MODE/,/# MODE/p' ${dir_local_conf}/ycsb.conf >tmp
while read line
do
    if [[ "$line" == \#* ]]; then
      continue
    fi
    if [ -z "$line" ]; then
      continue;
    fi
    params["${line}"]="${line}"
done < tmp
rm tmp
}

function getArguments(){

# Parse options using getopt
options=$(getopt -o w:r:o:d:e:E:t:m:LR --long workload:,recordcount:,operationcount:,db:,exporter:,exportfile:,threadcount:,measurementtype:,load,run -- "$@")
eval set -- "$options"

# Overwrite arguments.
while true; do
  case "$1" in
    -w|--workload) params["workload"]="$2"; shift 2;;
    -r|--recordcount) params["recordcount"]="$2"; shift 2;;
    -o|--operationcount) params["operationcount"]="$2"; shift 2;;
    -d|--db) params["db"]="$2"; shift 2;;
    -e|--exporter) params["exporter"]="$2"; shift 2;;
    -E|--exportfile) params["exportfile"]="$2"; shift 2;;
    -t|--threadcount) params["threadcount"]="$2"; shift 2;;
    -m|--measurementtype) params["measurementtype"]="$2"; shift 2;;
    -L|--load) params["load"]="load"; shift 1;;
    -R|--run) params["run"]="run"; shift 1;;
    --) shift; break;;
    *) echo "Invalid option: $1"; exit 1;;
  esac
done

# Concatenate arguments.
for key in "${!params[@]}"
do
  if [ "$key" == "load" ] || [ "$key" == "run" ]; then
    continue;
  fi
  params_ycsb+=("-p $key=${params[$key]}")
done
}

function startMemcached(){
stat=$(systemctl is-active memcached)

if [ "$stat" == "active" ]; then
  echo "memcached service is running"
else
  echo "memcached service is not running"
  # OS: CentOS 8.3.2011
  # To configure Memcached server, refer to /etc/sysconfig/memcached
  #	
  sudo systemctl start memcached; sleep 5
fi  
}

function runMemcached(){
cd ${YCSB_HOME}

if [ -z "$1" ] && [ -z "$2" ]; then
  echo "No mod(load, run) is set. exit with 1.";
  exit 1;
fi

for((i=1; i<=$#; i++));do
  /usr/bin/time -v ${YCSB_HOME}/bin/ycsb ${!i} memcached -s -P ${dir_local}/datasets/ycsb_datasets.lnk/workloada ${params_memcached[*]} ${params_ycsb[*]} 2>${dir_local}/evaluation/output_ycsb_memcached_${!i}_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_ycsb_memcached_${!i}_"$(date "+%H:%M:%S")".txt
echo ""
done
}

##############################################################
##############################################################

# Execution


#initMemcached;
loadConfigure;
getArguments $*;
echo $*
echo "${params_memcached[@]}"
echo "${params_ycsb[@]}"

startMemcached;
runMemcached ${params["load"]} ${params["run"]}; 
