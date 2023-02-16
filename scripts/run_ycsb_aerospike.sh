#! /usr/bin/bash
set -e

# Varaible

# Local
YCSB_HOME= ${dir_local}/sources/ycsb-0.17.0
options=("as.host" "as.port" "as.user" "as.password" "as.timeout" "as.namespace")
defaults=("default:localhost" "default:3000" "default:none" "default:none" "default:10000(ms)" "default:ycsb")
params=()
cnt=0

# Global

###############################################################
###############################################################

# Functions 
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
echo $params
}

function startAerospike(){
status=$(systemctl is-active aerospike)

if [ "$status" == "active" ]
then
  echo "aerospike service is running."
else
  echo "aerospike service is not running."
  systemctl start aerospike
fi
}

function runAerospike(){
cp aerospike/src/main/java/site/ycsb/db/AerospikeClient.java aerospike/src/main/java/site/ycsb/db/AerospikeClient.java.tmp
sed -i 's/\"ycsb\"/\"test\"/g' aerospike/src/main/java/site/ycsb/db/AerospikeClient.java

/usr/bin/time -v ${YCSB_HOME}/bin/ycsb load aerospike -s -P ${dir_local}/datasets/ycsb_datasets.lnk/workloada ${params[*]} 2>${dir_local}/evaluation/output_ycsb_aerospike_load_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_ycsb_aerospike_load_"$(date "+%H:%M:%S")".txt

/usr/bin/time -v ${YCSB_HOME}/bin/ycsb run aerospike -s -P ${dir_local}/datasets/ycsb_datasets.lnk/workloada ${params[*]}  2>${dir_local}/evaluation/output_ycsb_aerospike_run_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_ycsb_aerospike_run_"$(date "+%H:%M:%S")".txt

cp aerospike/src/main/java/site/ycsb/db/AerospikeClient.java.tmp aerospike/src/main/java/site/ycsb/db/AerospikeClient.java
rm aerospike/src/main/java/site/ycsb/db/AerospikeClient.java.tmp
}


###############################################################
###############################################################

# Execution

getArg;
startAerospike;
runAerospike;
