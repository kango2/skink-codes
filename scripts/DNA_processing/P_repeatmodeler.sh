#!/bin/bash
#PBS -l ncpus=24,mem=60GB,walltime=48:00:00,storage=gdata/if89+gdata/xl04,jobfs=400GB
#PBS -N repeatmodeler
#PBS -j oe



set -ex
module use /g/data/if89/apps/modulefiles
module load RepeatModeler/2.0.4-conda

cd ${workingdir}/repeatmodeler_${directory_name}
mkdir database
cd database
BuildDatabase -name ${prefix} -engine ncbi ${inputgenome}

mkdir -p $TMPDIR/${prefix}_RepeatModeler
cd $TMPDIR/${prefix}_RepeatModeler
RepeatModeler -database ${workingdir}/repeatmodeler_${directory_name}/database/${prefix} -threads ${PBS_NCPUS} > ${workingdir}/repeatmodeler_${directory_name}/out.log
export RM_folder=$(ls | grep RM_)
tar cf - ${RM_folder} | pigz -p ${PBS_NCPUS} > ${RM_folder}.tar.gz
rsync ${RM_folder}.tar.gz ${workingdir}

#output repeat library will be in ${workingdir}/database named:
#${prefix}-families.fa
#${prefix}-families.stk
#the .fa file can be fed directory into repeatmasker for soft masking, or you can concatenate it with the taxon repeats library for better repeat coverage

# logging package versions
echo -e "P_repeatmodeler complete\nPackage version:\n\t- RepeatModeler/2.0.4-conda" >> ${workingdir}/../LOG/P_${directory_name}.packageVersion.txt
