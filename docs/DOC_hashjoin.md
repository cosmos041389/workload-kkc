# README
This bash script loads a configuration file and executes a binary for the MITOSIS workload hashjoin. It is assumed that the configuration file is located at dir_local/conf/hashjoin.conf, and it contains parameters to be passed to the hashjoin binary.

## Usage
To use this script, simply execute it in a bash shell with the following command:

```
bash driver_local run hashjoin
```
## Configuration
The configuration file must have one parameter per line, and each line should not be empty or start with the # character. The parameters will be passed to the hashjoin binary located in dir_local/sources/mitosis-workload-hashjoin/bin.

## Output
The output of the hashjoin binary for each parameter will be saved in dir_local/evaluation/output_xxx_HH:MM:SS.txt, where xxx is the parameter number and HH:MM:SS is the current time. Additionally, the execution time for each parameter will be saved in dir_local/evaluation/output_xxx_time_HH:MM:SS.txt.

## Variables
The following variables can be modified to suit your needs:
- dir_local: the path to the directory where the configuration file and binary are located.
- params: the name of the array that stores the parameters from the configuration file.

## Functions
The script contains the following functions:
- loadConfigure: loads the configuration file and stores its parameters in the params array.
- runHashjoin: executes the hashjoin binary for each parameter in the params array and saves the output and execution time.
