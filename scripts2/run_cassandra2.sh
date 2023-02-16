#! /usr/bin/bash

# Variables

# Local variable

# Global variable
export CONTAINER_NAME="some-cassandra"
export KEYSPACE_NAME="ycsb"
export TABLE_NAME="usertable"
export NETWORK_NAME="some-network"
export EVAL_DIR="/root/workload-kkc/evaluation/"
export DATA_DIR="/root/workload-kkc/sources/ycsb-0.17.0/workloads/"

# Runtime Cassandra Parameters
args=()
options="
cassandra.keyspace=
cassandra.username=
cassandra.password=
cassandra.readconsistencylevel=
cassandra.writeconsistencylevel=
cassandra.maxconnections=
cassandra.coreconnections=
cassandra.connecttimeoutmillis=
cassandra.useSSL=
cassandra.readtimeoutmillis=
cassandra.tracing=
"
threads=
target=
record=
operation= 

#########################################################
#########################################################

function genNetwork(){
if docker network ls | grep -qw "$NETWORK_NAME"; then
  echo "Network '$NETWORK_NAME' exists"
else
  echo "Network '$NETWORK_NAME' does not exist"
  docker network create some-network
fi
}

function checkCassandra(){
local status=$(docker exec -it some-cassandra nodetool status | grep UN | wc -l)
local cnt=0
until [ "$status" -eq 1 ]; do
  echo "Waiting for Cassandra to start...$cnt"
  sleep 5
  status=$(docker exec -it some-cassandra nodetool status | grep UN | wc -l)
  if [ "$cnt" -eq 6 ]; then
    echo "Time out"
    return 1;
  fi
  cnt=$((cnt+1))
done
return 0;
}

function genContainer(){
# Get a list of all running containers
RUNNING_CONTAINERS=$(docker ps --format "{{.Names}}")

# Check if the container is running
if echo "$RUNNING_CONTAINERS" | grep -q "$CONTAINER_NAME"; then
  echo "Container '$CONTAINER_NAME' is running"
else
  echo "Container '$CONTAINER_NAME' is not running"
  # Run Cassandra server container
  docker run --name some-cassandra --network some-network -d --rm cassandra
  sleep 60
  checkCassandra
  if [ "$?" -eq 1 ]; then
    echo "There maybe error on running Cassandra."
    echo "Process will be terminated."
    stopCassandra;
    exit 1;
  fi
  echo "The Cassandra container is completely active"
fi
}

function genKeyspace(){
# Does keyspace 'ycsb' exist?
# Connect to the Cassandra container and run the keyspace check
container_id=$(docker ps | grep some-cassandra | awk '{print $1}')
keyspace_check=$(docker exec $container_id sh -c "cqlsh -e 'describe keyspaces' | grep ycsb | wc -l")

# Pass the result back to the host script using an environment variable
export KEYSPACE_EXISTS=$keyspace_check

if [ "$KEYSPACE_EXISTS" -eq 1 ]; then
  echo "The keyspace 'ycsb' exists."
else
  echo "The keyspace 'ycsb' does not exist."
  docker exec -it "$CONTAINER_NAME" cqlsh -e "CREATE KEYSPACE IF NOT EXISTS $KEYSPACE_NAME WITH REPLICATION = { 'class': 'SimpleStrategy', 'replication_factor': 3 };"
  docker exec -it "$CONTAINER_NAME" cqlsh -e "USE $KEYSPACE_NAME; CREATE TABLE IF NOT EXISTS $TABLE_NAME (y_id varchar primary key, field0 varchar, field1 varchar, field2 varchar, field3 varchar, field4 varchar, field5 varchar, field6 varchar, field7 varchar, field8 varchar, field9 varchar);"	
fi
}

function getArg(){
echo "If you want to skip each option, just press [ENTER]"
for option in ${options[@]}
do
        read -p "$option" answer
        if [ ! -z $answer ]
        then
                args+="-p ${option}${answer} "
        fi
done
read -p "threads(default: 1)=" threads
read -p "target(default: 100)=" target
read -p "recordcount(default: 1000)=" record
read -p "operationcount(default: 1000)=" operation
if [ -z $threads ]; then threads=1 ;fi
if [ -z $target ]; then target=100 ;fi
if [ -z $record ]; then record=1000; fi
if [ -z $operation ]; then operation=1000; fi
echo $args
}

function startCassandra(){
getArg

mapfile -t files < <(ls "$DATA_DIR")

for i in "${!files[@]}"; do
  echo "$i: ${files[i]}"
done

read -p "Choose number dataset to test: " answer
echo "${files[answer]}"

# Load YCSB workload
/usr/bin/time -v docker run --link some-cassandra:cassandra --name temp --rm --network some-network alvarobrandon/ycsb load cassandra-cql -s -P ycsb-0.12.0/workloads/${files[answer]} -p hosts=cassandra -threads $threads -target $target -p recordcount=$record ${args[*]} 2>$EVAL_DIR/output_cassandra_load_time_"$(date "+%H:%M:%S")".txt | tee $EVAL_DIR/output_cassandra_load_"$(date "+%H:%M:%S")".txt

# Run YCSB workload
/usr/bin/time -v docker run --link some-cassandra:cassandra --name temp --rm --network some-network alvarobrandon/ycsb run cassandra-cql -s -P ycsb-0.12.0/workloads/${files[answer]} -p hosts=cassandra -threads $threads -target $target -p operationcount=$operation ${args[*]} 2>$EVAL_DIR/output_cassandra_run_time_"$(date "+%H:%M:%S")".txt | tee $EVAL_DIR/output_cassandra_run_"$(date "+%H:%M:%S")".txt
}

function stopCassandra(){
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
  echo "Removing container '$CONTAINER_NAME'"
  docker rm -f $CONTAINER_NAME
else
  echo "Container '$CONTAINER_NAME' does not exist"
fi
}

#########################################################
#########################################################

# Execution

genNetwork;
genContainer;
genKeyspace;
startCassandra;
stopCassandra;
