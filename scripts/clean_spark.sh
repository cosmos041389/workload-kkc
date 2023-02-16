#! /usr/bin/bash

DIRS_SPARK=(`ls -d ${dir_local}/datasets/spark/*/`)

for DIR in ${DIRS_SPARK[@]}
do
	cd $DIR && rm -rf project/ target/;
done
