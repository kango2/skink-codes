#!/bin/bash
#PBS -N P_trimmomatic
#PBS -l ncpus=12,mem=120gb,storage=gdata/if89+gdata/xl04,walltime=12:00:00
#PBS -j oe



module use /g/data/if89/apps/modulefiles
module load Trimmomatic/0.39 parallel/20191022
cd ${workingdir}
while IFS=',' read -r col1 col2 col3
do
    echo -e "trimmomatic PE -threads ${PBS_NCPUS} -phred33 ${col2} ${col3} -baseout ${workingdir}/trimmomatic_${directory_name}/${col1}_trimmed.fq.gz ILLUMINACLIP:${repository_path}/adapters/TruSeq3-PE.fa:2:30:10 ${trimming_option}"
done < ${workingdir}/../inputs.csv | parallel --jobs ${PBS_NCPUS} {}

echo -e "P_trimmomatic complete\nPackage version:\n\t- Trimmomatic/0.39" > ${workingdir}/../LOG/P_${directory_name}.packageVersion.txt
