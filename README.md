# Workload installation-running automation script
Maintained by Kyeongcheol KANG

# Environment
By default, Its scripts are written on CentOS 8.3.2011.

# Directory structure
- `conf` : It contains every configuration of workloads
- `datasets` : It contains every datasets of workloads 
- `deps` : It contains dependencies for installing services
- `docs` : Details on each workloads
- `env` : Set of environment variable preceding workload execution
- `evaluation` : Result of workload execution
- `scripts` : Scripts running on local environment
- `scripts2` : Scripts running on docker container environment
- `sources` : Set of services for workload execution
- `temp` : This directory is used when generating temporary files while workload execution

# Quick start
Most of scripts can be run solely, however using `driver_local` or `driver_docker` for workload installing and running is recommended.
### Init
```
bash driver_local init
```
By `init` argument, Git submodule init-update, package installation, generating symbolic link are conducted.
### Build
```
bash driver_local build
```
Some services require additional build progress like `voltdb`, `quicksort`. In that case, It conducts build progress on every services.
### Run
```
bash driver_local run <workload> [options]
```
- `workload` : Name of target workload
- `options` : By giving command-line arugments, configuration can be overwritten
- abc
