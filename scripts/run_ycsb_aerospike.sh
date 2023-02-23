#! /usr/bin/bash

# Varaible

# Local
YCSB_HOME=${dir_local}/sources/ycsb-0.17.0/

# For Configure properties
params_aerospike=()
params_ycsb=()
declare -A params

# For Command-line arguments
workload=""
recordcount=""
operationcount=""
db=""
exporter=""
exportfile=""
threadcount=""
measurementtype=""
arg_load=""
arg_run=""

# Global

###############################################################
###############################################################

# Functions 
function loadConfigure(){
sed -n '/# AEROSPIKE/,/# AEROSPIKE/p' ${dir_local_conf}/ycsb.conf >tmp
while read line
do
    if [[ "$line" == \#* ]]; then
      continue
    fi
    if [ -z "$line" ]; then
      continue;
    fi
    params_aerospike+=("-p $line")
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

while true; do
  case "$1" in
    -w|--workload) workload="$2"; params["workload"]="$2"; shift 2;;
    -r|--recordcount) recordcount="$2"; params["recordcount"]="$2"; shift 2;;
    -o|--operationcount) operationcount="$2"; params["operationcount"]="$2"; shift 2;;
    -d|--db) db="$2"; params["db"]="$2"; shift 2;;
    -e|--exporter) exporter="$2"; params["exporter"]="$2"; shift 2;;
    -E|--exportfile) exportfile="$2"; params["exportfile"]="$2"; shift 2;;
    -t|--threadcount) threadcount="$2"; params["threadcount"]="$2"; shift 2;;
    -m|--measurementtype) measurementtype="$2"; params["measurementtype"]="$2"; shift 2;;
    -L|--load) params["load"]="load"; shift 1;;
    -R|--run) params["run"]="run"; shift 1;;
    --) shift; break;;
    *) echo "Invalid option: $1"; exit 1;;
  esac
done

# Overwrite by arguments, if exists.
for key in "${!params[@]}"
do
  if [ "$key" == "load" ] || [ "$key" == "run" ]; then
    continue;
  fi
  params_ycsb+=("-p $key=${params[$key]}")
done
}

function startAerospike(){
status=$(systemctl is-active aerospike)

if [ "$status" == "active" ]
then
  echo "aerospike service is running."
else
  echo "aerospike service is not running."
  # OS: CentOS 8.3.2011
  # To configure Aerospike server, refer to /etc/aerospike/aerospike.conf
  #
  sudo systemctl start aerospike; sleep 5
fi
}

function runAerospike(){
cd $YCSB_HOME

if [ -z "$1" ] && [ -z "$2" ]; then
  echo "No mod(load, run) is set. exit with 1.";
  exit 1;
fi

for((i=1; i<=$#; i++));do
  /usr/bin/time -v ${YCSB_HOME}/bin/ycsb ${!i} aerospike -s -P ${dir_local}/datasets/ycsb_datasets.lnk/workloada ${params_aerospike[*]} ${params_ycsb[*]} 2>${dir_local}/evaluation/output_ycsb_aerospike_${!i}_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_ycsb_aerospike_${!i}_"$(date "+%H:%M:%S")".txt
echo ""
done
}


###############################################################
###############################################################

# Execution


loadConfigure;
getArguments $*;
echo $*
echo "${params_aerospike[@]}"
echo "${params_ycsb[@]}"

startAerospike;
runAerospike ${params["load"]} ${params["run"]};
