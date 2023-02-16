# Description 
Workload Installation/Running Simplification Tool

# Hardware Environment
OS | Kernel | CPU
----|----|----
CentOS 8.3.2011 | 4.18.0-240.10.1.el8.x86_64 | Intel(R) Core(TM) i9-9820X CPU @ 3.30GHz

Graphic Card | RAM | -
----|----|----
NVIDIA Corporation GM204 [GeForce GTX 970] | 129.648416GB | -

# Getting Started
## Change Directory
```
cd scripts/
```

## Download Source files
Some services and frameworks are provided as binary.
You can pass arguments consecutively. If you run with no arguments, all sources listed will be downloaded.
```
bash download.sh [workload1] [workload2] [workload3] ...
```

## Install and Initialize Workloads
### ⚠ NOTICE ⚠   
### Many of scripts are depending on git submodules, therefore **initializing git submodule first** is recommended.
```
make [all | git_init | specific workloads]
```

# Run Scripts
You can try running scripts with whatever its prefix starts with 'run'.
With no arguments passed, all existing scripts will be run consecutively.
```
bash run.sh [workload1] [workload2] [workload3] ...
```
Refer to 'docs/' for more information about running specific workload.

# Directory Structure
- `bin` points to binaries located in 'sources/'
- `datasets` contains datasets 
- `deps` contains resolved dependencies
- `docs` contains documentaions informing specific running scripts
- `evaluation` will contain every output after runnning workload. output format is like output_[tool]_<service>[_time].txt
- `scripts` contains all scripts
- `sources` contains source binaries, git submodules
- `temp` is used while some workloads generate temporary files or directories

# Remark
Running script only with run.sh is recommended
