# README
This Bash script is used to run GraphX, a distributed graph processing framework, on a local machine. It assumes that Spark 3.3.2 is installed in the dir_local_sources directory

## Prerequisites
Spark 3.3.2 installed in the dir_local_sources directory.
GraphX installed in the dir_local/datasets/graphx/ directory.
Variables
This script contains two types of variables: local and global.

## Functions
This script contains two functions: loadConfigure and runGraphx.

## loadConfigure
This function reads parameters from the graphx.conf file and stores them in the params array. It skips comments and empty lines in the file.

## runGraphx
This function runs the GraphX program using spark-submit. It uses the parameters stored in the params array to specify the program to run.

## Execution
The script first loads the configuration using the loadConfigure function, and then runs the GraphX program using the runGraphx function. The output is saved in the dir_local/evaluation/ directory.