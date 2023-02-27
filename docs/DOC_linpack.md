# README
This is a bash script designed to run Linpack benchmark on a system. The Linpack benchmark is used to measure a system's floating-point computing power. The script is organized into two main sections: Variables and Functions.

## Functions
The script declares one function *runLinpack()*. This function changes directory to the location where the Linpack source code is stored and runs the benchmark. The benchmark results are stored in two files: one for the output and one for the time. These files are saved in the directory specified by the dir_local variable.

## Execution
The script is executed by calling the *runLinpack()* function.

The script is useful for anyone who wants to measure the floating-point computing power of their system. However, it is important to ensure that the Linpack source code is correctly installed in the directory specified by dir_local. Also, it is important to note that this script assumes the presence of the bash shell in the system.
