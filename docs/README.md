# Description 
Details for each script

# Explanation
## Download, Install and Initialize
- `download.sh`: Download binaries of .tar, packages of .rpm and external datasets.
- `Makefile`: Check Prerequisites being installed, install and initialize.

## Run
### Common part
Every script executions produce two output files in the evaluation/.<br/>
`/usr/bin/time -v` generates output_\<workload\>\_time.txt with *stderr*.<br/>
Therefore, if error occurs, it won't be printed out.<br/>
And each of different execution command will generates output_\<workload\>.txt<br/>

### Executables
- btree
- graphx: Refer to `graphx.docs`
- hashjoin
- linpack
- memcached: Refer to `memcached.docs`
- quicksort: 1 argument is required, `Number of MB to generate`
- snap
- solr 💥 (Not Available Now)
- spark: Refer to `spark.docs`
- voltdb
- ycsb : Refer to `ycsb.docs`
  - aerospike
  - memcached
  - redis
  - cassandra 💥 (Not Available Now)
- tensorflow 💥 (Not Available Now)

# Remark
