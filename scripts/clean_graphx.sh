#! /usr/bin/bash

DIRS_GRAPHX=(`ls -d ${dir_local}/datasets/graphx/*/`)

for DIR in ${DIRS_GRAPHX[@]}
do
	cd $DIR && rm -rf project/ target/;
done
