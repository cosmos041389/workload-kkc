# Requirements
- Maven 3
- Python 2 ( It shouldn't be Python 3. It causes syntax error like [link](https://github.com/brianfrankcooper/YCSB/issues/1530) )

## Aerospike
Reference is [here](https://github.com/brianfrankcooper/YCSB/tree/master/aerospike)
#### Set up
`mvn -pl site.ycsb:aerospike-binding -am clean package`

#### Parameters
The following connection parameters are available.
  * `as.host` - The Aerospike cluster to connect to (default: `localhost`)
  * `as.port` - The port to connect to (default: `3000`)
  * `as.user` - The user to connect as (no default)
  * `as.password` - The password for the user (no default)
  * `as.timeout` - The transaction and connection timeout (in ms, default: `10000`)
  * `as.namespace` - The namespace to be used for the benchmark (default: `ycsb`)

## Memcached
Reference is [here](https://github.com/brianfrankcooper/YCSB/tree/master/memcached)
#### Set up
`mvn -pl site.ycsb:memcached-binding -am clean package`

#### Parameters
##### Required params
- `memcached.hosts`
  This is a comma-separated list of hosts providing the memcached interface.
  You can use IPs or hostnames. The port is optional and defaults to the
  memcached standard port of `11211` if not specified.

##### Optional params
- `memcached.shutdownTimeoutMillis`
  Shutdown timeout in milliseconds.
- `memcached.objectExpirationTime`
  Object expiration time for memcached; defaults to `Integer.MAX_VALUE`.
- `memcached.checkOperationStatus`
  Whether to verify the success of each operation; defaults to true.
- `memcached.readBufferSize`
  Read buffer size, in bytes.
- `memcached.opTimeoutMillis`
  Operation timeout, in milliseconds.
- `memcached.failureMode`
  What to do with failures; this is one of `net.spy.memcached.FailureMode` enum
  values, which are currently: `Redistribute`, `Retry`, or `Cancel`.
- `memcached.protocol`
  Set to 'binary' to use memcached binary protocol. Set to 'text' or omit this field to use memcached text protocol
  
  
## Redis
Reference is [here](https://github.com/brianfrankcooper/YCSB/tree/master/redis)
#### Set up
`mvn -pl site.ycsb:redis-binding -am clean package`

#### Parameters
The following connection parameters are available.
- `redis.host`
- `redis.port`
- `redis.password`
  * Don't set the password if redis auth is disabled.
- `redis.cluster`
  * Set the cluster parameter to `true` if redis cluster mode is enabled.
  * Default is `false`.