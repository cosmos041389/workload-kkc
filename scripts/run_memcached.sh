#! /usr/bin/bash

# Variables

# Local Variable

# Runtime Memcached parameters
defaults=("default:1" "default:16" "default:1" "default:1000000" "default:2h" "default:10k" "default:none" "default:none" "default:1" "default:10s" "default:none" "default:none" "default:none" "default:none")

# NOTICE
# -s(--servers) must be given manually at line 75
# -F(--cfg_cmd) must be given manually at line 75
options="
--threads
--concurrency
--conn_sock
--execute_number
--time
--win_size
--fixed_size
--verify
--division
--stat_freq
--exp_verify
--overwrite
--tps
--rep_write
"
params=()
cnt=0

optionse="
--reconnect
--udp
--facebook
--binary
--verbose
"
paramse=()

#######################################################
#######################################################

function initMemcached(){
echo "flush_all" | nc 127.0.0.1 11211
}

function getArg(){
echo "If you want to skip the option, just press [ENTER}"
for option in ${options[@]}
do
        read -p "$option(${defaults[$cnt]})=" answer
        if [ ! -z $answer ]
        then
                params+="${option}=${answer} "
        fi
  cnt=$((cnt+1))
done

echo "To enable or disable options, type [Y | N]. Pressing [ENTER] will set false as well."
for optione in ${optionse[@]}
do
	read -p "$optione: " answer
	case $answer in
	[Yy])
		paramse+="$optione "
		;;
	[Nn])
		echo "Set to False"
		;;
	*)
		echo "Wrong character or [ENTER] was passed, set to False"
		;;
	esac
done
}

function runMemcached(){
/usr/bin/time -v memaslap -s 127.0.0.1:11211 -F ${dir_local}/datasets/memaslap.cnf ${params[*]} ${paramse[*]} 2>${dir_local}/evaluation/output_memcached_time_"$(date "+%H:%M:%S")".txt | tee ${dir_local}/evaluation/output_memcached_"$(date "+%H:%M:%S")".txt
}

function startMemcached(){
status=$(systemctl is-active memcached)

if [ "$status" == "active" ]; then
  echo "memcached service is running"
else
  echo "memcached service is not running"
  sudo systemctl start memcached
fi
}

#######################################################
#######################################################

# Execution

initMemcached;
getArg;
startMemcached;
runMemcached;
