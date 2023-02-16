#! /usr/bin/bash

set -e

DIRS_GRAPHX=(`ls -d ${dir_local}/datasets/graphx/*/`)

for DIR in ${DIRS_GRAPHX[@]}
do
	cd $DIR && sbt package;
done
