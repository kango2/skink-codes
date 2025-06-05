#!/bin/bash
#PBS -N bamcoverage
#PBS -l ncpus=12,mem=120gb,walltime=12:00:00,storage=gdata/if89+gdata/xl04,jobfs=60GB
#PBS -j oe
#PBS -M z5205618@ad.unsw.edu.au
#PBS -m ae

module use /g/data/if89/apps/modulefiles
module load parallel/20191022 pythonlib/3.9.2 python3-as-python