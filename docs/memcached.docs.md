# Description
Memcached benchmark script using `memaslap`
    
### Options
#### Value required
- `servers`: 💡 **Modify script run_memcached.sh at line 75**   
List one or more servers to connect. Servers count must be less than threads count. e.g.: –servers=localhost:1234,localhost:11211  
Default `127.0.0.1:11211`  

- `threads`: Number of threads to startup, better equal to CPU numbers. Default 8.
- `concurrency`: Number of concurrency to simulate with load. Default 128.
- `conn_sock`: Number of TCP socks per concurrency. Default 1.
- `execute_number`: Number of operations(get and set) to execute for the given test. Default 1000000.
- `time`: How long the test to run, suffix: s-seconds, m-minutes, h-hours, d-days e.g.: –time=2h. The default is 600s.
- `cfg_cmd`: 💡 **Modify script run_memcached.sh at line 75**  
Load the configure file to get command,key and value distribution list.  
Default `workload-kkc/datasets/memaslap.cnf`
- `win_size`: Task window size of each concurrency, suffix: K, M e.g.: –win_size=10k. Default 10k.
- `fixed_size`: Fixed length of value.
- `verify`: The proportion of date verification, e.g.: –verify=0.01
- `division`: Number of keys to multi-get once. Default 1, means single get.
- `stat_freq`: Frequency of dumping statistic information. suffix: s-seconds, m-minutes, e.g.: –resp_freq=10s.
- `exp_verify`: The proportion of objects with expire time, e.g.: –exp_verify=0.01. Default no object with expire time
- `overwrite`: The proportion of objects need overwrite, e.g.: –overwrite=0.01. Default never overwrite object.
- `tps`: Expected throughput, suffix: K, e.g.: –tps=10k.
- `rep_write`: The first nth servers can write data, e.g.: –rep_write=2.

#### Value not required
- `reconnect`: 	Reconnect tests, when connection is closed it will be reconnected.
  
- `udp`: 	UDP tests, default memaslap uses TCP, TCP port and UDP port of server must be same.
- `facebook`: Whether it enables facebook test feature, set with TCP and multi-get with UDP.
- `binary`: Whether it enables binary protocol. Default with ASCII protocol.
- `verbose`: Whether it outputs detailed information when verification fails.

# Remark
Original info: [memaslap options](http://docs.libmemcached.org/bin/memaslap.html#options)
