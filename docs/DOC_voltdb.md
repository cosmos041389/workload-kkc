# Description
This is a Bash script that initializes, runs, and stops a VoltDB database. It exports some global variables and defines three functions: initVoltdb(), runVoltdb(), and stopVoltdb().

The `initVoltdb` function disables transparent huge pages and initializes the VoltDB database in a directory specified by the VOLTDB_INIT variable. If the database has already been initialized, it skips this step. Then, it starts the database in the background and waits for 10 seconds for it to fully start up.

The `runVoltdb` function changes the current directory to the VoltDB test directory specified by the VOLTDB_TEST variable. It runs the run.sh script with the init argument, which initializes the TPCC benchmark tables in the database, and redirects the output to a file in the evaluation directory with a timestamp in the filename. Then, it runs the run.sh script with the client argument, which runs the TPCC benchmark workload on the database and also redirects the output to a file in the evaluation directory with a timestamp in the filename. The time command is used to measure the execution time of these commands, and the output is redirected to separate files in the evaluation directory.

The `stopVoltdb` function stops the VoltDB database using the voltadmin command.

# Prerequisites
To run this script, you need to have VoltDB installed and `bash driver_local build` must be preceded. You also need to have the sudo command installed and have permission to use it.

# Usage
To run the script, open a terminal and navigate to the directory where the script is saved. Then, run the following command:
```
bash driver_local run voltdb
```

# Notes
The script assumes that you have a directory named evaluation in the same directory as the script, and that you have write permissions for this directory.
The initVoltdb() function contains commands that require superuser (root) privileges. These commands prompt for your password using sudo. You may need to enter your password to run the script.
The script uses the echo command with the -e option to enable interpretation of escape sequences, such as \n for a newline character. This may not work with all versions of echo.
# Disclaimer
This script is provided as-is, and the author assumes no responsibility for any consequences resulting from its use. Use at your own risk.
