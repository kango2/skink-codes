#!/bin/bash
#PBS -N P_processrmout
#PBS -l ncpus=1,mem=80GB,walltime=00:30:00,storage=gdata/if89+gdata/xl04
#PBS -j oe
#PBS -M z5205618@ad.unsw.edu.au
#PBS -m ae

module use /g/data/if89/apps/modulefiles
module load perllib/v5.26.3

perl ${repository_path}/scripts/DNA_processing/processrmout.pl \
${original_fasta} \
${chunk} \
${RMout} \
${Merged_out}

#This is commented out because fasta files are either .fasta or .fa and I can't be bothered to change the script to handle both. DIY!
# cd ${Merged_out}
# for i in $(ls *.fasta.masked); do mv ${i} ${i/.fasta.masked/}_masked.fasta; done

cd ${Merged_out}
mv * ../
cd ..
rm -rf Merged


# logging package versions
echo -e "P_repeatmasker complete\nPackage version:\n\t- RepeatMasker/4.1.2-p1" >> ${workingdir}/../LOG/log_${directory_name}/P.packageVersion.txt
