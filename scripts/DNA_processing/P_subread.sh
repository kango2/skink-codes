#!/bin/bash
#PBS -N JUST_subread
#PBS -l ncpus=12,mem=120gb,storage=gdata/if89+gdata/xl04,walltime=12:00:00
#PBS -j oe



module use /g/data/if89/apps/modulefiles
module load subread/2.1.1 parallel/20191022 samtools/1.21
cd ${workingdir}
echo -e "\tYour subread output from this run will be in\n\t\t${workingdir}/subread/index_${directory_name}\n\t\t${workingdir}/subread/mapping_${directory_name}" >> ${workingdir}/logs/config.log
#index genome
mkdir -p ${workingdir}/subread/index_${directory_name}
subread-buildindex -o ${workingdir}/subread/index_${directory_name}/genome ${genome}

#subread mapping to genome
mkdir -p ${workingdir}/subread/mapping_${directory_name}

if [ "$run_on_trimmed_output" = "YES" ]; then
    while IFS=',' read -r col1 col2 col3
    do
        echo -e "subread-align -t 1 -T ${PBS_NCPUS} --sortReadsByCoordinates -i ${workingdir}/subread/index_${directory_name}/genome -r ${workingdir}/trimmomatic/${col1}_trimmed_1P.fq.gz -R ${workingdir}/trimmomatic/${col1}_trimmed_2P.fq.gz -o ${workingdir}/subread/mapping_${directory_name}/${col1}_subread.bam"
    done < inputs.csv | parallel --jobs ${PBS_NCPUS} {}
elif [ "$run_on_trimmed_output" = "NO" ]; then
    while IFS=',' read -r col1 col2 col3
    do
        echo -e "subread-align -t 1 -T ${PBS_NCPUS} --sortReadsByCoordinates -i ${workingdir}/subread/index_${directory_name}/genome -r ${col2} -R ${col3} -o ${workingdir}/subread/mapping_${directory_name}/${col1}_subread.bam"
    done < inputs.csv | parallel --jobs ${PBS_NCPUS} {}
fi

cd ${workingdir}/subread/mapping_${directory_name}
rm *.bai
for i in $(ls *.bam); do echo ${i}; done | \
parallel --jobs ${PBS_NCPUS} samtools index -b -@ ${PBS_NCPUS} {} {}.bai


echo -e "P_subread complete\nPackage version:\n\t- subread/2.1.1\n\t- samtools/1.21" >> ${workingdir}/../LOG/P_${directory_name}.packageVersion.txt
