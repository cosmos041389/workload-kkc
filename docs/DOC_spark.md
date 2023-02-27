# README
This Bash script is designed to automate the process of running Apache Spark with specific configurations and parameters. It first loads a configuration file, which contains information on the target application and its parameters. The script then extracts the relevant information from the configuration file and runs the Spark application with the specified parameters.

The script includes two functions:

*loadConfigure()*: This function loads the configuration file and extracts the target application and its parameters. It uses the sed command to filter the lines between two patterns, which specify the start and end of the relevant section of the configuration file. The function reads the filtered lines and stores the target and parameters in local variables.

*runSpark()*: This function navigates to the Spark installation directory and runs the spark-submit command with the specified jar file and parameters. It also redirects the output to log files and prints the execution time using the time command.

The script can be executed by running the *runSpark()* function, which will call the *loadConfigure()* function and use the extracted information to run Spark.

## How to Use
To use this script, follow these steps:

Ensure that Apache Spark is installed on your system.

Set the dir_local_conf and dir_local_sources variables to the appropriate directories for your system.

Modify the jar file and log file names in the *runSpark()* function to match your application.

### Usage
```
bash driver_local run spark
```

Note: This script is designed to work with specific applications and parameters. It may need to be modified to work with different applications or configurations.
