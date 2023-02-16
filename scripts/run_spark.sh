#! /usr/bin/bash
set -e

# Variable

# Local

# Global

##################################################################
##################################################################

# Functions

function printList(){
local dir_list=${dir_local}/sources/spark-3.3.1-bin-hadoop3/examples/src/main/scala/org/apache/spark/examples/
cd $dir_list

cnt=1

file_list=($(ls "$dir_list"))

for file in "${file_list[@]}"
do
  echo "${file:0:-6}"
done

}

function setGraphx(){
while [ "$answer" != "quit" ]
do

cd ${dir_local}/sources/spark-3.3.1-bin-hadoop3/

read -p "Type the name of example or the number to try. Type [quit] if you want to stop running Spark.: " answer

case $answer in
1|ALS)
	echo "Type each arguments or skip by pressing [ENTER]. If you skip, default value will be passed."	
	read -p "Number of movies(Default: 100)=" movies
	read -p "Number of users(Default: 500)=" users
	read -p "Number of features(Default: 10)=" features
	read -p "Iterations(Default: 5)=" iterations
	read -p "Slices(Default: 2)=" slices
	if [ -z "$movies" ]; then movies=100; fi
	if [ -z "$users" ]; then users=500; fi
	if [ -z "$features" ]; then features=10; fi
	if [ -z "$iterations" ]; then iterations=5; fi
	if [ -z "$slices" ]; then slices=2; fi
	
      	/usr/bin/time -v bin/spark-submit ${dir_local}/datasets/spark/ALS/target/scala-2.12/als_2.12-1.0.jar "$movies" "$users" "$features" "$iterations" "$slices" 1>${dir_local}/evaluation/output_spark_ALS_"$(date "+%H:%M:%S")".txt 2>${dir_local}/evaluation/output_spark_ALS_time_"$(date "+%H:%M:%S")".txt 
        ;;
2|HdfsLR)
        echo "Not implemented"
	;;

3|KMeans)
	echo "Type each arguments.Or you can skip by pressing [ENTER]."
	read -p "File path(Default: ${dir_local}/datasets/spark_datasets.lnk/kmeans_data.txt)=" file_path
	read -p "K(Default: 10)=" k
	read -p "ConvergeDist(Default: 5)=" cvdist
	if [ -z "$file_path" ]
	then
		file_path=${dir_local}/datasets/spark_datasets.lnk/kmeans_data.txt
	fi
	if [ -z "$k" ]
	then
		k=10
	fi
	if [ -z "$cvdist" ]
	then
		cvdist=5
	fi
		
	/usr/bin/time -v bin/spark-submit ${dir_local}/datasets/spark/KMeans/target/scala-2.12/kmeans_2.12-1.0.jar "$file_path" "$k" "$cvdist" 1>${dir_local}/evaluation/output_spark_KMeans_"$(date "+%H:%M:%S")".txt 2>${dir_local}/evaluation/output_spark_KMeans_time_"$(date "+%H:%M:%S")".txt
	;;
4|LR)
	echo "Not implemented"
	;;
5|PageRank)
	echo "Type each arguments.Or you can skip by pressing [ENTER]."
	read -p "File path(Default: ${dir_local}/datasets/spark_datasets.lnk/pagerank_data.txt)=" file_path
	read -p "Iterations(Default: 10)=" iter
	if [ -z "$file_path" ]
	then
		file_path=${dir_local}/datasets/spark_datasets.lnk/pagerank_data.txt
	fi
	if [ -z "$iter" ]
	then
		iter=10
	fi
	/usr/bin/time -v bin/spark-submit ${dir_local}/datasets/spark/PageRank/target/scala-2.12/pagerank_2.12-1.0.jar "$file_path" "$iter" 1>${dir_local}/evaluation/output_spark_PageRank_"$(date "+%H:%M:%S")".txt 2>${dir_local}/evaluation/output_spark_PageRank_time_"$(date "+%H:%M:%S")".txt
	;;
6|Pi)
	echo "Type argument. Or you can skip by pressing [ENTER]."
	read -p "Slices(Default: 2)=" slices
	if [ -z "$slices" ]
	then
		slices=2
	fi
	/usr/bin/time -v bin/spark-submit ${dir_local}/datasets/spark/Pi/target/scala-2.12/pi_2.12-1.0.jar "$slices" 1>${dir_local}/evaluation/output_spark_Pi_"$(date "+%H:%M:%S")".txt 2>${dir_local}/evaluation/output_spark_Pi_time_"$(date "+%H:%M:%S")".txt
	;;
7|RemoteFileTest)
	echo "Type argument. Or you can skip by pressing [ENTER]."
	read -p "File(Default: ${dir_local}/datasets/spark_datasets.lnk/pagerank_data.txt)=" file
	if [ -z "$file" ]
	then
		file=${dir_local}/datasets/spark_datasets.lnk/pagerank_data.txt
	fi
	/usr/bin/time -v bin/spark-submit ${dir_local}/datasets/spark/RemoteFileTest/target/scala-2.12/remotefiletest_2.12-1.0.jar "$file" 1>${dir_local}/evaluation/output_spark_RemoteFileTest_"$(date "+%H:%M:%S")".txt 2>${dir_local}/evaluation/output_spark_RemoteFileTest_time_"$(date "+%H:%M:%S")".txt
	;;
8|TC)
	echo "Type argument. Or you can skip by pressing [ENTER]."
	read -p "Slices(Default: 2)=" slices
	if [ -z "$slices" ]
	then
		slices=2
	fi
	/usr/bin/time -v bin/spark-submit ${dir_local}/datasets/spark/TC/target/scala-2.12/tc_2.12-1.0.jar "$slices" 1>${dir_local}/evaluation/output_spark_TC_"$(date "+%H:%M:%S")".txt 2>${dir_local}/evaluation/output_spark_TC_time_"$(date "+%H:%M:%S")".txt
	;;
[Qq][Uu][Ii][Tt])
	echo "Quit from Spark"
	answer=quit
	;;
*)
        echo "Wrong number or example passed"
        ;;
esac

echo -e "\n\n"
done

echo "SPARK: Completed"
}

##################################################################
##################################################################

# Execution

