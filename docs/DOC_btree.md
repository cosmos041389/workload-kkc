# README
This Bash script is designed to run a series of btree workload tests using the Mitosis Btree library. It reads the test parameters from a configuration file and outputs the test results and execution times to separate files.

## Usage
To use this script, simply execute it in a Bash shell:
```
bash driver_local run btree
```
## Configuration
The script expects a configuration file located at ${dir_local}/conf/btree.conf. This file should contain a list of btree test parameters, with one parameter per line. Comments can be included in the file by starting the line with a # character.

Configuration file:
```
bench_btree_st // single thread
bench_btree_mt // multi thread
```

## Output
The script will output two files for each test parameter specified in the configuration file: an output file containing the test results, and a time file containing information about the execution time of the test. These files will be located in the ${dir_local}/evaluation directory.

## License
This script is released under the MIT License. See the LICENSE file for more information.