#!/bin/bash
#PBS -N diamond
#PBS -l ncpus=32,walltime=2:00:00,storage=gdata/if89+gdata/xl04,mem=80GB,jobfs=80GB
#PBS -j oe
#PBS -M z5205618@ad.unsw.edu.au
#PBS -m ae

module use /g/data/if89/apps/modulefiles
module load diamond/2.1.9 perllib/v5.26.3

export base=$(basename ${trinity_out} .trinity.Trinity.fasta)
diamond blastx --db ${blastxtranslation_uniprotfastadb} \
--out ${workingdir}/blastxtranslation_${directory_name}/diamond/${base}.vs.sprot.out \
--query ${trinity_out} \
--outfmt 6 \
--max-target-seqs 1 --max-hsps 1 --threads ${PBS_NCPUS}

perl ${repository_path}/scripts/RNA_processing/blastxtranslations.pl \
${trinity_out} \
${blastxtranslation_uniprotfasta} \
${workingdir}/blastxtranslation_${directory_name}/diamond/${base}.vs.sprot.out \
${workingdir}/blastxtranslation_${directory_name}/${base}
