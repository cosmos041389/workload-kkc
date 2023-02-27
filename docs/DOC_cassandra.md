# README
This repository contains a Bash script (start_workload.sh) that automates the process of setting up a Cassandra cluster, creating a keyspace, and running YCSB workloads against the cluster. The script assumes that you have Docker installed and running on your system.

## Function
- *genNetwork()*: To run with YCSB on docker, It generates network in docker.
- *checkCassandra()*: Check Cassandra server is running on docker container.
- *genContainer()*: Generate Cassandra container.
- *genKeyspace()*: If keyspace 'ycsb' not exist, it generates keyspace.
- *loadConfigure()*: Load configuration for workload from cassandra.conf.
- *startCassandra()*: Run *load* and *run* workload.
- *stopCassandra()*: When whole process is done, remove containers.

## Usage
Edit the configuration file (conf/ycsb.conf) to specify the Cassandra cluster settings and YCSB workload parameters.

Run the script:
```
bash driver_docker run cassandra
```
This will set up the Cassandra cluster, create the specified keyspace, load the specified YCSB workload, and run the workload against the cluster. The script will also output detailed timing information for the load and run operations.

When the script has completed, you can view the output files in the evaluation/ directory.

## License
This repository is licensed under the MIT License. See the LICENSE file for more information.
