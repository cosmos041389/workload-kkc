#! /usr/bin/bash

# Local Variable


# Global Variable
export VOLTDB_HOME=${dir_local}/sources/voltdb
export VOLTDB_INIT=${dir_local}/temp
export VOLTDB_TEST=${VOLTDB_HOME}/tests/test_apps/tpcc

#####################################################################
#####################################################################

# Functions

function initVoltdb(){
echo -e "sudo bash -c \"echo never > /sys/kernel/mm/transparent_hugepage/enabled\""
sudo -S bash -c "echo never > /sys/kernel/mm/transparent_hugepage/enabled"
sudo -K
echo -e "sudo bash -c \"echo never > /sys/kernel/mm/transparent_hugepage/defrag\""
sudo -S bash -c "echo never > /sys/kernel/mm/transparent_hugepage/defrag"

cd $VOLTDB_HOME
if [ ! -d ${VOLTDB_INIT}/voltdbroot ]
then
	bin/voltdb init --dir=${VOLTDB_INIT}
fi
bin/voltdb start --dir=${VOLTDB_INIT} --background; sleep 10
}

function runVoltdb(){
cd $VOLTDB_TEST
/usr/bin/time -v bash run.sh init 2>${dir_local}/evaluation/output_voltdb_init_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_voltdb_init_"$(date "+%H:%M:%S")".txt;
/usr/bin/time -v bash run.sh client 2>${dir_local}/evaluation/output_voltdb_client_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_voltdb_client_"$(date "+%H:%M:%S")".txt
}

function stopVoltdb(){
cd $VOLTDB_HOME
bin/voltadmin shutdown
}

#####################################################################
#####################################################################

# Execution

initVoltdb;
runVoltdb;
stopVoltdb;
