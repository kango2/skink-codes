#!/bin/bash
#PBS -l ncpus=24,mem=60GB,walltime=48:00:00,storage=gdata/if89+gdata/xl04,jobfs=400GB
#PBS -N P_repeatmodeler
#PBS -j oe
#PBS -M z5205618@ad.unsw.edu.au
#PBS -m ae

set -ex
module use /g/data/if89/apps/modulefiles
module load RepeatModeler/2.0.4-conda

cd ${workingdir}/repeatmodeler_${directory_name}
mkdir database
cd database
BuildDatabase -name ${species} -engine ncbi ${genome}

mkdir -p $TMPDIR/${species}_RepeatModeler
cd $TMPDIR/${species}_RepeatModeler
RepeatModeler -database ${workingdir}/repeatmodeler_${directory_name}/database/${species} -threads ${PBS_NCPUS} > ${workingdir}/repeatmodeler_${directory_name}/out.log
export RM_folder=$(ls | grep RM_)
tar cf - ${RM_folder} | pigz -p ${PBS_NCPUS} > ${RM_folder}.tar.gz
rsync ${RM_folder}.tar.gz ${workingdir}/repeatmodeler_${directory_name}

#output repeat library will be in ${workingdir}/database named:
#${species}-families.fa
#${species}-families.stk
#the .fa file can be fed directory into repeatmasker for soft masking, or you can concatenate it with the taxon repeats library for better repeat coverage

# logging package versions
echo -e "P_repeatmodeler complete\nPackage version:\n\t- RepeatModeler/2.0.4-conda" >> ${workingdir}/../LOG/log_${directory_name}/P.packageVersion.txt
