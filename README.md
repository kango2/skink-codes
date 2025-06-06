# skink-codes
This repository contains useful scripts to streamline necessary processing of data for sex chromosome analysis. There are 2 important files in this repository which you should get familiar with if you are planning to use some of the code:
1. **launch.sh** Your config file, run this to launch jobs
2. **generate_input_list.sh** Generate input list to tell trimmomatic or subread what input files to use.

# Dependency
Scripts here are designed to run on NCI gadi and uses a lot of modules in project if89, they will need adjustment if running on other HPC system.
To get started, clone the repository somewhere where you have access:
```
cd /path/to/somewhere/you/like
git clone https://github.com/kango2/skink-codes.git
```
That's it, you now have all the scripts available, to launch them, read the next section

# launch.sh
This is the file that controls all (almost all) of the settings in the job you want to run. Usage is simple, first edit the file with the settings you need within the double quotes. then run it
```
# Edit launch.sh
cd /path/to/your/copy/of/the/repository
./launch.sh
```
scripts for 4 pipelines/streamline and 6 individual tools are launchable from this file. To avoid potential conflicts, you can not launch both pipeline and individual tools at the same time, and within each category, only 1 pipeline or 1 individual tool at the same time, there will be internal checks to warn you about this if it occurs.


