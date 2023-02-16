#! /usr/bin/bash

set -e

DIRS_SPARK=(`ls -d ${dir_local}/datasets/spark/*/`)

for DIR in ${DIRS_SPARK[@]}
do
	cd $DIR && sbt package;
done
