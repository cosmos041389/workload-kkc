#! /usr/bin/bash

# Variables

# Local Variable

# For Configure properties
declare -A params_memaslap
params=()

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
  params_memaslap["${line%%=*}"]="${line#*=}"
done < ${dir_local_conf}/memaslap.conf
}

function getArguments(){
options=$(getopt -o s:T:c:n:x:t:F:w:X:v:d:S:e:o:RUaBP:p:bhV --long servers:,threads:,concurrency:,conn_sock:,execute_number:,time:,cfg_cmd:,win_size:,fixed_size:,verify:,division:,stat_freq:,exp_verify:,overwrite:,reconnect,udp,facebook,binary,tps:,rep_write:,verbose,help,version -- "$@")
eval set -- "$options"

while true; do
  case "$1" in
  -s|--servers) params_memaslap["servers"]="$2"; shift 2;;
  -T|--threads) params_memaslap["threads"]="$2"; shift 2;;
  -c|--concurrency) params_memaslap["concurrency"]="$2"; shift 2;;
  -n|--conn_sock) params_memaslap["conn_sock"]="$2"; shift 2;;
  -x|--execute_number) params_memaslap["execute_number"]="$2"; shift 2;;
  -t|--time) params_memaslap["time"]="$2"; shift 2;;
  -F|--cfg_cmd) params_memaslap["cfg_cmd"]="$2"; shift 2;;
  -w|--win_size) params_memaslap["win_size"]="$2"; shift 2;;
  -X|--fixed_size) params_memaslap["fixed_size"]="$2"; shift 2;;
  -v|--verify) params_memaslap["verify"]="$2"; shift 2;;
  -d|--division) params_memaslap["division"]="$2"; shift 2;;
  -S|--stat_freq) params_memaslap["stat_freq"]="$2"; shift 2;;
  -e|--exp_verify) params_memaslap["exp_verify"]="$2"; shift 2;;
  -o|--overwrite) params_memaslap["overwrite"]="$2"; shift 2;;
  -P|--tps) params_memaslap["tps"]="$2"; shift 2;;
  -p|--rep_write) params_memaslap["req_write"]="$2"; shift 2;;
  -R|--reconnect) params_memaslap["reconnect"]="reconnect"; shift 1;;
  -U|--udp) params_memaslap["udp"]="udp"; shift 1;;
  -a|--facebook) params_memaslap["facebook"]="facebook"; shift 1;;
  -B|--binary) params_memaslap["binary"]="binary"; shift 1;;
  -b|--verbose) params_memaslap["verbose"]="verbose"; shift 1;;
  -h|--help) params_memaslap["help"]="help"; shift 1;;
  -V|--version) params_memaslap["version"]="version"; shift 1;;
  --) shift; break;;
  *) echo "Invalid option: $1"; exit 1;;
  esac
done

# Concatenate arguments
for key in "${!params_memaslap[@]}"
do
  if [ "$key" == "reconnect" ] || [ "$key" == "udp" ] || [ "$key" == "facebook" ] || [ "$key" == "binary" ] || [ "$key" == "verbose" ] || [ "$key" == "help" ] || [ "$key" == "version" ];then
    params+=("--$key"); continue;
  fi
  params+=("--$key=${params_memaslap[$key]}")
done
}

function runMemcached(){
/usr/bin/time -v memaslap ${params[*]} 2>${dir_local}/evaluation/output_memcached_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_memcached_"$(date "+%H:%M:%S")".txt
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

#initMemcached;
loadConfigure;
#set -x;
getArguments $*;
echo $*;
echo "${params[@]}"

startMemcached;
runMemcached;
