# README
This Bash script performs the QuickSort algorithm using the implementation provided in the quicksort binary file located in the sources/cfm/quicksort directory. The script takes in configuration properties from the conf/quicksort.conf file and can also accept command-line arguments for modifying the input values.

## Usage
To run the script, navigate to the directory containing the script in a terminal and execute the following command:
```
bash driver_local run quicksort [MB to generate]
```
The optional argument can be used to modify the input values provided in the conf/quicksort.conf file.

## Configuration
The script loads configuration properties from the conf/quicksort.conf file. These properties are read line by line, ignoring lines that start with # or are empty. The loaded properties are stored in an array called params, which is passed as arguments to the quicksort binary.

## Functions
The script contains three functions:

- loadConfigure(): This function loads the configuration properties from the conf/quicksort.conf file.

- getArguments(): This function accepts an optional argument and modifies the first value in the params array if the argument is an integer.

- runQuicksort(): This function changes the working directory to sources/cfm/quicksort and runs the quicksort binary with the input values provided in the params array. The output of the program is saved to a file in the evaluation directory.

## Output
The script outputs the params array to the console, indicating the values being passed to the quicksort binary. Additionally, the script uses the time command to measure the execution time of the program and outputs the results to a file in the evaluation directory.

Note: This script uses the set -e option, which causes the script to exit immediately if any command fails.
