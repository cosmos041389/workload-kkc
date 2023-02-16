# Description
Basically, This script exploits GraphX example codes provided by Spark.  
There are 9 options you can choose and 3 cases of configuration  
# Configuration
### 1. No need to configuration
This case needs no configuration. Because it generates data itself within source code.
However, if you were willing to change some configuration, you could change before build time by modifying source code.
##### List following:
- AggregateMessageExample
- SSSPExample

### 2. Build time configuration
In case of being required specific file path, you should modify it before building with `sbt`.
##### List following:
- ComprehensiveExample
- ConnectedComponentsExample
- PageRankExample
- TriangleCountingExample

### 3. Run time configuration
This case asks if you have specific value to pass.  
If not, Default value will be passed by pressing [ENTER].  
##### List following:
- Analytics

# Remark
##### Not implemented list following:
- LiveJournalPageRank
- SynthBenchmark

# Datasets
Symbolic link `graphx_datasets.lnk` is pointing to graphx example data directory located at `sources/spark-3.3.1-bin-hadoop3/data/graphx/`.  
If you would like to refer to or store into dataset related with GraphX, use `datasets/graphx_datasets.lnk/`
