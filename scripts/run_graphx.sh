#! /usr/bin/bash
set -e

# Variable

# Local variable


# Global variable


##########################################################
##########################################################

function runGraphx(){
	/usr/bin/time -v bin/spark-submit ${dir_local}/datasets/graphx/"$1"/target/scala-2.12/"$2"_2.12-1.0.jar 2>${dir_local}/evaluation/output_graphx_"$1"_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_graphx_"$1"_"$(date "+%H:%M:%S")".txt
}

function printList(){
dir_list=${dir_local}/sources/spark-3.3.1-bin-hadoop3/examples/src/main/scala/org/apache/spark/examples/graphx
cd $dir_list

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

read -p "Type the name of example or the number to try. Type [quit] if you want to stop running GraphX.: " answer

case $answer in
1|AggregateMessageExample) # data will be generated
  runGrpahx AggregateMessages aggregatemessages
  ;;
2|Analytics) # 3 arguments is needed <task type> <file> --numEPart=<num_edge_partitions>
	echo "Type each arguments or skip by pressing [ENTER]."	
	read -p "Task type(pagerank | triangles)(Default: pagerank)=" task
	read -p "File path(Default: ${dir_local}/datasets/spark_datasets.lnk/pagerank_data.txt)=" path
	read -p "Number of edge partitions(Default: 2)=" edge

	if [ -z "$task" ]; then task=pagerank; fi
	if [ -z "$path" ]; then path=${dir_local}/datasets/spark_datasets.lnk/pagerank_data.txt; fi
	if [ -z "$edge" ]; then edge=2; fi
  runGraphx Analytics analytics	
  ;;
3|ComprehensiveExample) # data file path must be modified in source code before build
  runGraphx Comprehensive comprehensive
  ;;
4|ConnectedComponentsExample) # data file path must be modified in source code before build
  runGraphx ConnectedComponents connectedcomponents
  ;;
5|LiveJournalPageRank)
  echo "Not Implemented"
  ;;
6|PageRankExample) # data file path must be modified in source code before modified
  runGraphx PageRank pagerank
  ;;
7|SSSPExample) # data will be generated
  runGraphx SSSP sssp
  ;;
8|SynthBenchmark)
  echo "Not Implemented"
  ;;
9|TriangleCountingExample) # data file path must be modified in source code before modified
  runGraphx TriangleCounting trianglecounting
  ;;
[Qq][Uu][Ii][Tt])
	echo "Quit from GraphX"
	answer=quit
	;;
*)
	echo "Wrong number or example passed"
	;;
esac

echo -e "\n\n"
done
}

##########################################################
##########################################################

# Execution

printList;
setGraphx;

