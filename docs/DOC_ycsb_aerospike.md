# YCSB Aerospike Benchmarking Script
This script is used to run benchmark tests on an Aerospike database using the Yahoo! Cloud Serving Benchmark (YCSB) tool. The script loads a specified dataset into the database and runs the workload on the database to measure performance metrics.

## Requirements
- Aerospike server installed and running
- YCSB 0.17.0 installed
- Bash shell

## Usage
The script can be run with the following command:
```
bash driver_local run ycsb_aerospike [OPTIONS]
```

The available options are:
- `-w, --workload` : the YCSB workload to run (default: workloada)
- `-r, --recordcount` : the number of records to load into the database (default: 100000)
- `-o, --operationcount` : the number of operations to perform (default: 100000)
- `-d, --db` : the name of the Aerospike namespace to use (default: test)
- `-e, --exporter` : the type of exporter to use (default: csv)
- `-E, --exportfile` : the name of the file to export metrics to (default: metrics.csv)
- `-t, --threadcount` : the number of threads to use for the workload (default: 4)
- `-m, --measurementtype` : the type of performance metrics to measure (default: histogram)
- `-L, --load` : flag to load the dataset into the database
- `-R, --run` : flag to run the workload on the database

Example usage:
```
bash driver_local run ycsb_memcached -w workloadb -r 500000 -o 500000 -t 8 -L -R
```
This command will load 500,000 records into the database, run the workloadb workload with 500,000 operations using 8 threads, and export the metrics to a CSV file.

# Output
The script will output the results of the benchmark test to the console and to a file in the evaluation directory of the script. The file will be named output_ycsb_aerospike_[MOD]_[TIME].txt, where [MOD] is the mode (load or run) and [TIME] is the current time. Performance metrics will be exported to a CSV file named metrics.csv in the same directory.

# License
This script is licensed under the MIT License.