# isa-must-gather : 
## Reference 
Openshift must-gather : https://docs.openshift.com/container-platform/4.10/support/gathering-cluster-data.html#gathering-data-specific-features_gathering-cluster-data
IBM MAS must-gather : https://www.ibm.com/support/pages/node/6487991

## Aim
isa-must-gather a friendly cli tool that allows user to collect log information using Openshift's must gather tool.
This is specialised in collecting logs for MAS application. Together with MAS, it is possible to collect openshift logs as well.

## Who should use it?

## How to install
1. download the shell script
2. copy the script to cluster


## How To Run
### Method 1: simply run the script
```
sh isa-must-gather.sh
```
(-) Cannot run this script anywhere
This method is not flexible. You need to remember the location of the script

### Method 2: Create Symbolic Link
2.1. Create Symbolic Link
````
sudo ln -s /path/to/run_must_gather.sh /usr/local/bin/runMustGather
````
2.2. 
```

```

