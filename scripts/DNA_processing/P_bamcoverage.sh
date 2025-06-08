#!/bin/bash
#PBS -N P_bamcoverage
#PBS -l ncpus=8,mem=120gb,walltime=8:00:00,storage=gdata/if89+gdata/xl04,jobfs=120GB
#PBS -j oe



module use /g/data/if89/apps/modulefiles
module load parallel/20191022 pythonlib/3.9.2 python3-as-python
cd ${input_path}


for i in $(ls *.bam); do echo ${i/.bam/}; done | \
parallel --jobs ${PBS_NCPUS} bamCoverage -bs ${binsize} -p ${PBS_NCPUS} -of bedgraph -b {}.bam -o ${workingdir}/bamcoverage_${directory_name}/raw/{}.bedgraph

cd ${workingdir}/bamcoverage_${directory_name}/raw
# chmod u+x ${workingdir}/scripts/process_bedgraph.py
for i in $(ls *.bedgraph); do python ${repository_path}/scripts/DNA_processing/process_bedgraph.py ${i} ${binsize} > ${workingdir}/bamcoverage_${directory_name}/${i/.bedgraph/}_fixed.bedgraph; done


export VERSION=$(pip freeze | grep deepTools | sed 's/==/\//g')
echo -e "P_bamcoverage complete\nPython Package version:\n\t- python/3.9.2\n\t- ${VERSION}" >> ${workingdir}/../LOG/log_${directory_name}/P.packageVersion.txt
