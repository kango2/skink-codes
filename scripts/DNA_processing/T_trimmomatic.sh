#!/bin/bash
#PBS -N T_trimmomatic
#PBS -l ncpus=12,mem=120gb,storage=gdata/if89+gdata/xl04,walltime=36:00:00
#PBS -j oe



module use /g/data/if89/apps/modulefiles
module load Trimmomatic/0.39 parallel/20191022
cd ${workingdir}

# running trimmomatic
while IFS=',' read -r col1 col2 col3 col4
do
    echo -e "trimmomatic PE -threads ${PBS_NCPUS} -phred33 ${col3} ${col4} -baseout ${workingdir}/trimmomatic_${directory_name}/${col2}_trimmed.fq.gz ILLUMINACLIP:${repository_path}/adapters/TruSeq3-PE.fa:2:30:10 ${trimming_option}"
done < ${input_list} | parallel --jobs ${PBS_NCPUS} {}

# logging package version
echo -e "T_trimmomatic complete\nPackage version:\n\t- Trimmomatic/0.39" > ${workingdir}/../LOG/log_${directory_name}/T.packageVersion.txt
