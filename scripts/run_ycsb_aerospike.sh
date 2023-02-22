#! /usr/bin/bash

# Varaible

# Local
YCSB_HOME=${dir_local}/sources/ycsb-0.17.0/
params_aerospike=()
params_ycsb=()

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
    params_ycsb+=("-p $line")
done < tmp
rm tmp

echo ${params_aerospike[@]}
echo ${params_ycsb[@]}
}

function startAerospike(){
status=$(systemctl is-active aerospike)

if [ "$status" == "active" ]
then
  echo "aerospike service is running."
else
  echo "aerospike service is not running."
  #
  # To configure Aerospike server, refer to /etc/aerospike/aerospike.conf
  #
  systemctl start aerospike; sleep 5
fi
}

function runAerospike(){
cd $YCSB_HOME

/usr/bin/time -v ${YCSB_HOME}/bin/ycsb load aerospike -s -P ${dir_local}/datasets/ycsb_datasets.lnk/workloada ${params_aerospike[*]} ${params_ycsb[*]} 2>${dir_local}/evaluation/output_ycsb_aerospike_load_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_ycsb_aerospike_load_"$(date "+%H:%M:%S")".txt
echo ""
/usr/bin/time -v ${YCSB_HOME}/bin/ycsb run aerospike -s -P ${dir_local}/datasets/ycsb_datasets.lnk/workloada ${params_aerospike[*]} ${params_ycsb[*]} 2>${dir_local}/evaluation/output_ycsb_aerospike_run_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_ycsb_aerospike_run_"$(date "+%H:%M:%S")".txt
}


###############################################################
###############################################################

# Execution

loadConfigure;
startAerospike;
runAerospike;
