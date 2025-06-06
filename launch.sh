#!/bin/bash

# For more info on how to set up this launch file, please refer to the README.md file in the github repository.

#====================================================================================#
# General setting, please set these variables to your own values                     #
# These are the settings that will be used by all scripts in the repository          #
#====================================================================================#

## The path to your copy of the repository
export repository_path="/g/data/xl04/jc4878/github/skink-codes"             # do not put trailing "/" at the end
## The path to the directory everything will be written to (your working directory, where the output will be stored)
export workingdir="/g/data/xl04/jc4878/workingdir"                          # do not put trailing "/" at the end                  
## Email notification settings
export email_notification="YES"                                             # either "YES" or "NO", If set to "YES", scripts in the repository will have line 5-6 changed to include your email address before submitting jobs.
export email_address="z5205618@ad.unsw.edu.au"                              # Set to your email address if you want notifications, otherwise leave it empty.
#export PROJECT="xl04"                                                      # This should already be automatically set to your project, but you can manually change it here if needed.

#====================================================================================#
# Pipeline settings, are you using 1 of the 4 available pipelines here?              #
# If not, set all of these to "NO" and set up the individual tool settings below     #
# Look at the README.md file for more info on each of the pipelines                  #
#====================================================================================#

export P1_trimmomatic_subread_bamcoverage="NO"                              # either "YES" or "NO", If set to "YES", the scripts will run Trimmomatic, Subread and bamCoverage in a single job.
export P2_trimmomatic_subread="NO"                                          # either "YES" or "NO", If set to "YES", the scripts will run Trimmomatic and Subread in a single job.
export P3_subread_bamcoverage="NO"                                          # either "YES" or "NO", If set to "YES", the scripts will run Subread and bamCoverage in a single job.
export P4_repeatmodeler_repeatmasker="NO"                                   # either "YES" or "NO", If set to "YES", the scripts will run RepeatModeler and RepeatMasker in a single job.

## Pipeline general settings - input list (needed for P1, P2, P3)
export P_input_list="${workingdir}/input_list.csv"                          # leave this as it is unless you didn't generate the input list with generate_input_list.sh

# Depending on which tools are included in your pipeline, set up the following tool-specific settings.
## Pipeline specific settings - trimmomatic
export P_trimming_option="CROP:95 HEADCROP:14 SLIDINGWINDOW:5:15 MINLEN:36" # an example of what this should look like

## Pipeline specific settings - subread
export P_genome="/path/to/genome.fa"                                        # ungzipped fasta file for genome is recommended, however gzipped format should also work for subread
export P_seqtype="DNA"                                                      # either "DNA" or "RNA", RNA is usually for P2

## Pipeline specific settings - bamCoverage
export P_binsize="20000"                                                    # the bin size for bamCoverage, 20kb works well in skinks with largest chromosome at ~300Mbp

## Pipeline specific settings - repeatmodeler
export P_repeatmodeler_genome="/path/to/genome.fa"                          # not sure if .fasta.gz is supported, use .fasta file to be safe
export P_repeatmodeler_prefix="prefix"                                      # A prefix for the repeatmodeler output, we recommend setting this to reflect the species. For example "PogVit" for Pogona vitticeps, "TilRug" for Tiliqua rugosa etc.

## Pipeline specific settings - repeatmasker



#=====================================================================================#
# Individual tool settings, which specific tool are you running? choose "YES" or "NO" #
# For now, only one tool can be launched (set to YES) at a time                       #
#=====================================================================================#

export trimmomatic="NO"                                                     # either "YES" or "NO", If set to "YES", the script will run Trimmomatic
export subread="NO"                                                         # either "YES" or "NO", If set to "YES", the script will run Subread
export bamCoverage="NO"                                                     # either "YES" or "NO", If set to "YES", the script will run bamCoverage
export trinity="NO"                                                         # either "YES" or "NO", If set to "YES", the script will run Trinity
export repeatmodeler="NO"                                                   # either "YES" or "NO", If set to "YES", the script will run RepeatModeler
export repeatmasker="NO"                                                    # either "YES" or "NO", If set to "YES", the script will run RepeatMasker

## Individual tool general settings - input list (needed for trimmomatic & subread)
export T_input_list="${workingdir}/input_list.csv"                          # leave this as it is unless you didn't generate the input list with generate_input_list.sh

# Depending on which tools you are launching, set up the following tool-specific settings.
## Individual tool specific settings - trimmomatic
export T_trimming_option="CROP:95 HEADCROP:14 SLIDINGWINDOW:5:15 MINLEN:36" # an example of what this should look like

## Individual tool specific settings - subread
export T_genome="/path/to/genome.fa"                                        # ungzipped fasta file for genome is recommended, however gzipped format should also work for subread
export T_seqtype="DNA"                                                      # either "DNA" or "RNA"

## Individual tool specific settings - bamCoverage
export T_binsize="20000"                                                    # the bin size for bamCoverage, 20kb works well in skinks with largest chromosome at ~300Mbp
export T_bamdir="/path/to/dir/with/bam/files"                               # the directory where the .bam files are located

## Individual tool specific settings - trinity
export T_trinity_input_list="/path/to/trinity.filelist"                     # ATTENTION, this file is different from input_list.csv, look in README.md for more info

# Individual tool specific settings - repeatmodeler
export T_repeatmodeler_genome="/path/to/genome.fa"                          # not sure if .fasta.gz is supported, use .fasta file to be safe
export T_repeatmodeler_prefix="prefix"                                      # A prefix for the repeatmodeler output, we recommend setting this to reflect the species. For example "PogVit" for Pogona vitticeps, "TilRug" for Tiliqua rugosa etc.

# Individual tool specific settings - repeatmasker
export T_repeatmasker_genome="/path/to/genome.fa"                           # input genome to repeat masking, recommend use .fa|.fasta file instead of gzipped fasta
export T_repeatmasker_lib="/path/to/repeatlibrary.fa"                       # path to a library containing the repeats to be masked, this is usually the output from RepeatModeler, but you can also use a custom library if you have one (e.g. a combined library with taxon-specific repeats + species-specific repeats)






#                              End of Configuration                              #
#                           Do not edit below this line                          #
#--------------------------------------------------------------------------------#

## Adding email to scripts if email_notification is set to "YES"
if [ "$email_notification" = "YES" ]; then
    echo -e "[LOG] \$email_notification set to: YES, now adding email to scripts"
    sed -i "5s|.*|#PBS -M ${email_address}|" ${repository_path}/scripts/DNA_processing/*.sh
    sed -i "5s|.*|#PBS -M ${email_address}|" ${repository_path}/scripts/RNA_processing/*.sh
    sed -i "6s|.*|#PBS -m ae|" ${repository_path}/scripts/DNA_processing/*.sh
    sed -i "6s|.*|#PBS -m ae|" ${repository_path}/scripts/RNA_processing/*.sh
elif [ "$email_notification" = "NO" ]; then
    echo -e "[LOG] \$email_notification set to: NO, moving on"
fi
mkdir -p ${workingdir}
mkdir -p ${workingdir}/LOG
mkdir -p ${workingdir}/OUTPUT
export directory_name=$(date | awk '{print $1"_"$3"_"$2"_"$6"_"$5"_"$4}' | sed 's/\:/_/g')
## Checking if only 1 pipeline is selected
selected_pipelines=0
[ "$P1_trimmomatic_subread_bamcoverage" = "YES" ] && selected_pipelines=$((selected_pipelines+1))
[ "$P2_trimmomatic_subread" = "YES" ] && selected_pipelines=$((selected_pipelines+1))
[ "$P3_subread_bamcoverage" = "YES" ] && selected_pipelines=$((selected_pipelines+1))

echo -e "[LOG] Checking if you are running a pipeline or individual tools"
if [ "$selected_pipelines" -gt 1 ]; then
    echo "Error: Multiple pipelines set to 'YES'. Please select only one"
    exit 1
elif [ "$selected_pipelines" -eq 1 ]; then
    echo "[LOG] A pipeline detected, running pipeline"
    if [ "$P1_trimmomatic_subread_bamcoverage" == "YES" ]; then
        echo "[LOG] Running pipeline: P1_trimmomatic_subread_bamcoverage"
        mkdir -p ${workingdir}/OUTPUT/bamcoverage_${directory_name}/raw
        mkdir -p ${workingdir}/OUTPUT/bamcoverage_${directory_name}/fixed
        export BAMCOVERAGE_DEPEND=$(qsub -P ${PROJECT} -W depend=on:1 -o ${workingdir}/LOG/P1_bamcoverage_${directory_name}.OU -v workingdir=${workingdir}/OUTPUT,input_path=${workingdir}/OUTPUT/subread/mapping_${directory_name},binsize=${P_binsize},directory_name=${directory_name} ${repository_path}/scripts/DNA_processing/P_bamcoverage.sh)
        mkdir -p ${workingdir}/OUTPUT/subread_${directory_name}
        export SUBREAD_DEPEND=$(qsub -P ${PROJECT} -W depend=on:1,depend=beforeok:${BAMCOVERAGE_DEPEND} -o ${workingdir}/LOG/P1_subread_${directory_name}.OU -v workingdir=${workingdir}/OUTPUT/subread_${directory_name},genome=${P_genome},input_list=FROM_TRIMMOMATIC,directory_name=${directory_name} ${repository_path}/scripts/DNA_processing/P_subread.sh)
        mkdir -p ${workingdir}/OUTPUT/trimmomatic_${directory_name}
        if [ "$P_seqtype" == "DNA" ]; then
            qsub -P ${PROJECT} -W depend=beforeok:${SUBREAD_DEPEND} -o ${workingdir}/LOG/P1_trimmomatic_${directory_name}.OU -v workingdir=${workingdir}/OUTPUT,repository_path=${repository_path},trimming_option=${P_trimming_option},input_list=${P_input_list},directory_name=${directory_name} ${repository_path}/scripts/DNA_processing/P_trimmomatic.sh
        elif [ "$P_seqtype" == "RNA" ]; then
            qsub -P ${PROJECT} -W depend=beforeok:${SUBREAD_DEPEND} -o ${workingdir}/LOG/P1_trimmomatic_${directory_name}.OU -v workingdir=${workingdir}/OUTPUT,repository_path=${repository_path},trimming_option=${P_trimming_option},input_list=${P_input_list},directory_name=${directory_name} ${repository_path}/scripts/RNA_processing/P_trimmomatic.sh
        else
            echo "[LOG] Error: Invalid sequence type. Please set P_seqtype to either 'DNA' or 'RNA'."
            qdel ${BAMCOVERAGE_DEPEND}
            qdel ${SUBREAD_DEPEND}
            exit 1
        fi

        ##LOG PURPOSES

    elif [ "$P2_trimmomatic_subread" == "YES" ]; then
        echo "[LOG] Running pipeline: P2_trimmomatic_subread"
        mkdir -p ${workingdir}/OUTPUT/subread_${directory_name}
        export SUBREAD_DEPEND=$(qsub -P ${PROJECT} -o ${workingdir}/LOG/P2_subread_${directory_name}.OU -v workingdir=${workingdir}/OUTPUT/subread_${directory_name},genome=${P_genome},input_list=FROM_TRIMMOMATIC,directory_name=${directory_name} ${repository_path}/scripts/DNA_processing/P_subread.sh)
        mkdir -p ${workingdir}/OUTPUT/trimmomatic_${directory_name}
        if [ "$P_seqtype" == "DNA" ]; then
            qsub -P ${PROJECT} -W depend=beforeok:${SUBREAD_DEPEND} -o ${workingdir}/LOG/P2_trimmomatic_${directory_name}.OU -v workingdir=${workingdir}/OUTPUT,repository_path=${repository_path},trimming_option=${P_trimming_option},input_list=${P_input_list},directory_name=${directory_name} ${repository_path}/scripts/DNA_processing/P_trimmomatic.sh
        elif [ "$P_seqtype" == "RNA" ]; then
            qsub -P ${PROJECT} -W depend=beforeok:${SUBREAD_DEPEND} -o ${workingdir}/LOG/P2_trimmomatic_${directory_name}.OU -v workingdir=${workingdir}/OUTPUT,repository_path=${repository_path},trimming_option=${P_trimming_option},input_list=${P_input_list},directory_name=${directory_name} ${repository_path}/scripts/RNA_processing/P_trimmomatic.sh
        else
            echo "[LOG] Error: Invalid sequence type. Please set P_seqtype to either 'DNA' or 'RNA'."
            exit 1
        fi

        ##LOG PURPOSES

    elif [ "$P3_subread_bamcoverage" == "YES" ]; then
        echo "[LOG] Running pipeline: P3_subread_bamcoverage"
        mkdir -p ${workingdir}/OUTPUT/bamcoverage_${directory_name}/raw
        mkdir -p ${workingdir}/OUTPUT/bamcoverage_${directory_name}/fixed
        export BAMCOVERAGE_DEPEND=$(qsub -P ${PROJECT} -W depend=on:1 -o ${workingdir}/LOG/P3_bamcoverage_${directory_name}.OU -v workingdir=${workingdir}/OUTPUT,binsize=${P_binsize},input_path=${T_bamdir},directory_name=${directory_name} ${repository_path}/scripts/DNA_processing/P_bamcoverage.sh)
        mkdir -p ${workingdir}/OUTPUT/subread_${directory_name}
        export SUBREAD_DEPEND=$(qsub -P ${PROJECT} -W depend=beforeok:${BAMCOVERAGE_DEPEND} -o ${workingdir}/LOG/P3_subread_${directory_name}.OU -v workingdir=${workingdir}/OUTPUT/subread_${directory_name},genome=${P_genome},input_list=${P_input_list},directory_name=${directory_name} ${repository_path}/scripts/DNA_processing/P_subread.sh)

        ##LOG PURPOSES

    fi
    exit 1
fi
echo "[LOG] Not running pipeline, moving on to individual tools"
