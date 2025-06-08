#!/bin/bash

# For more info on how to set up this launch file, please refer to the README.md file in the github repository.

#====================================================================================#
# General setting, please set these variables to your own values                     #
# These are the settings that will be used by all scripts in the repository          #
#====================================================================================#

## The path to your copy of the repository
export repository_path="/g/data/xl04/jc4878/github/skink-codes"                                             # do not put trailing "/" at the end
## The path to the directory everything will be written to (your working directory, where the output will be stored)
export workingdir="/g/data/xl04/jc4878/workingdir"                                                          # do not put trailing "/" at the end                  
## Email notification settings
export email_notification="NO"                                                                             # either "YES" or "NO", If set to "YES", scripts in the repository will have line 5-6 changed to include your email address before submitting jobs.
export email_address="z5205618@ad.unsw.edu.au"                                                              # Set to your email address if you want notifications, otherwise leave it empty.
#export PROJECT="xl04"                                                                                      # This should already be automatically set to your project, but you can manually change it here if needed.



#====================================================================================#
# Pipeline settings, are you using 1 of the 5 available pipelines here?              #
# If not, set all of these to "NO" and set up the individual tool settings below     #
# Look at the README.md file for more info on each of the pipelines                  #
#====================================================================================#

export P1_trimmomatic_subread_bamcoverage="NO"                                                              # either "YES" or "NO", If set to "YES", the scripts will run Trimmomatic, Subread and bamCoverage sequentially
export P2_trimmomatic_subread="NO"                                                                          # either "YES" or "NO", If set to "YES", the scripts will run Trimmomatic and Subread sequentially
export P3_subread_bamcoverage="NO"                                                                          # either "YES" or "NO", If set to "YES", the scripts will run Subread and bamCoverage sequentially
export P4_repeatmodeler_repeatmasker="NO"                                                                   # either "YES" or "NO", If set to "YES", the scripts will run RepeatModeler and RepeatMasker sequentially
export P5_trinity_blastxtranslation="NO"                                                                    # either "YES" or "NO", If set to "YES", the scripts will run Trinity and blastxtranslation sequentially

## Pipeline general settings - input list (needed for P1, P2, P3)
export P_input_list="${workingdir}/inputs.csv"                                                              # leave this as it is unless you didn't generate the input list with generate_input_list.sh

# Depending on which tools are included in your pipeline, set up the following tool-specific settings.
## Pipeline specific settings - trimmomatic
export P_trimming_option="CROP:95 HEADCROP:14 SLIDINGWINDOW:5:15 MINLEN:36"                                 # an example of what this should look like

## Pipeline specific settings - subread
export P_genome="/path/to/genome.fa"                                                                        # ungzipped fasta file for genome is recommended, however gzipped format should also work for subread
export P_seqtype="DNA"                                                                                      # either "DNA" or "RNA", RNA is usually for P2

## Pipeline specific settings - bamCoverage
export P_binsize="20000"                                                                                    # the bin size for bamCoverage, 20kb works well in skinks with largest chromosome at ~300Mbp

## Pipeline specific settings - repeatmodeler & repeatmasker
export P_repeatmodeler_genome="/path/to/genome.fa"                                                          # not sure if .fasta.gz is supported, use .fasta file to be safe
export P_repeatmodeler_prefix="prefix"                                                                      # A prefix for the repeatmodeler output, we recommend setting this to reflect the species. For example "PogVit" for Pogona vitticeps, "TilRug" for Tiliqua rugosa etc.

## Pipeline specific settings - trinity & blastxtranslation
export P_trinity_input_list="/path/to/trinity.filelist"                                                     # ATTENTION, this file is different from input_list.csv, look in README.md for more info
export P_blastxtranslation_uniprotfasta="/g/data/xl04/jc4878/database/uniprot_sprot.fasta"                  # full path to the uniprot_sprot.fasta file. The pre-defined one was last accessed on 2024 Feb 28th with diamond 2.1.9
export P_blastxtranslation_uniprotfastadb="/g/data/xl04/jc4878/database/uniprot_sprot.diamond.db.dmnd"      # full path to the uniprot_sprot.fasta.dmnd file. The pre-defined one was last accessed on 2024 Feb 28th with diamond 2.1.9



#=====================================================================================#
# Individual tool settings, which specific tool are you running? choose "YES" or "NO" #
# For now, only one tool can be launched (set to YES) at a time                       #
#=====================================================================================#

export trimmomatic="NO"                                                                                     # either "YES" or "NO", If set to "YES", the script will run Trimmomatic
export subread="NO"                                                                                         # either "YES" or "NO", If set to "YES", the script will run Subread
export bamCoverage="NO"                                                                                     # either "YES" or "NO", If set to "YES", the script will run bamCoverage
export trinity="NO"                                                                                         # either "YES" or "NO", If set to "YES", the script will run Trinity
export blastxtranslation="NO"                                                                               # either "YES" or "NO", If set to "YES", the script will run blastxtranslation
export repeatmodeler="NO"                                                                                   # either "YES" or "NO", If set to "YES", the script will run RepeatModeler
export repeatmasker="NO"                                                                                    # either "YES" or "NO", If set to "YES", the script will run RepeatMasker

## Individual tool general settings - input list (needed for trimmomatic & subread)
export T_input_list="${workingdir}/input_list.csv"                                                          # leave this as it is unless you didn't generate the input list with generate_input_list.sh

# Depending on which tools you are launching, set up the following tool-specific settings.
## Individual tool specific settings - trimmomatic
export T_trimming_option="CROP:95 HEADCROP:14 SLIDINGWINDOW:5:15 MINLEN:36"                                 # an example of what this should look like

## Individual tool specific settings - subread
export T_genome="/path/to/genome.fa"                                                                        # ungzipped fasta file for genome is recommended, however gzipped format should also work for subread
export T_seqtype="DNA"                                                                                      # either "DNA" or "RNA"

## Individual tool specific settings - bamCoverage
export T_binsize="20000"                                                                                    # the bin size for bamCoverage, 20kb works well in skinks with largest chromosome at ~300Mbp
export T_bamdir="/path/to/dir/with/bam/files"                                                               # the directory where the .bam files are located

## Individual tool specific settings - trinity
export T_trinity_input_list="/path/to/trinity.filelist"                                                     # ATTENTION, this file is different from input_list.csv, look in README.md for more info

# Individual tool specific settings - blastxtranslation
export T_blastxtranslation_input_directory="/path/to/input/dir"                                             # The directory where the trinity .fasta output files are located. trinity output format must be in .trinity.Trinity.fasta
export T_blastxtranslation_uniprotfasta="/g/data/xl04/jc4878/database/uniprot_sprot.fasta"                  # full path to the uniprot_sprot.fasta file. The pre-defined one was last accessed on 2024 Feb 28th with diamond 2.1.9
export T_blastxtranslation_uniprotfastadb="/g/data/xl04/jc4878/database/uniprot_sprot.diamond.db.dmnd"      # full path to the uniprot_sprot.fasta.dmnd file. The pre-defined one was last accessed on 2024 Feb 28th with diamond 2.1.9   

# Individual tool specific settings - repeatmodeler
export T_repeatmodeler_genome="/path/to/genome.fa"                                                          # not sure if .fasta.gz is supported, use .fasta file to be safe
export T_repeatmodeler_prefix="prefix"                                                                      # A prefix for the repeatmodeler output, we recommend setting this to reflect the species. For example "PogVit" for Pogona vitticeps, "TilRug" for Tiliqua rugosa etc.

# Individual tool specific settings - repeatmasker
export T_repeatmasker_genome="/path/to/genome.fa"                                                           # input genome to repeat masking, recommend use .fa|.fasta file instead of gzipped fasta
export T_repeatmasker_lib="/path/to/repeatlibrary.fa"                                                       # path to a library containing the repeats to be masked, this is usually the output from RepeatModeler, but you can also use a custom library if you have one (e.g. a combined library with taxon-specific repeats + species-specific repeats)






#                              End of Configuration                              #
#                           Do not edit below this line                          #
#--------------------------------------------------------------------------------#
#                             launch.sh version 1.1                              #
#                                                                                #

## Checking if anything is set to "YES" at all, exit if nothing is set to "YES"
if [ "$P1_trimmomatic_subread_bamcoverage" = "YES" ] || [ "$P2_trimmomatic_subread" = "YES" ] || [ "$P3_subread_bamcoverage" = "YES" ] || [ "$P4_repeatmodeler_repeatmasker" = "YES" ] || [ "$P5_trinity_blastxtranslation" = "YES" ] || [ "$trimmomatic" = "YES" ] || [ "$subread" = "YES" ] || [ "$bamCoverage" = "YES" ] || [ "$trinity" = "YES" ] || [ "$blastxtranslation" = "YES" ] || [ "$repeatmodeler" = "YES" ] || [ "$repeatmasker" = "YES" ]; then
    echo -e "//===========================\\\\\\\\\n||          WELCOME          ||\n||           v1.1            ||\n\\\\\\===========================//"
    export current_time=$(date)
    echo -e "${current_time}\n"
    export directory_name=$(echo ${current_time} | awk '{print $1"_"$3"_"$2"_"$6"_"$5"_"$4}' | sed 's/\:/_/g')
else
    echo -e "//===========================\\\\\\\\\n||          WELCOME          ||\n||           v1.1            ||\n\\\\\\===========================//"
    export current_time=$(date)
    messages=(
    "[LOG] No tasks found. Taking a well-deserved nap... zzz"
    "[LOG] No tasks detected. System entering idle mode..."
    "[LOG] No tasks available. Initiating self-destruct sequence... Just kidding!"
    "[LOG] No tasks to process. Time for a coffee break!"
    "[LOG] No tasks detected. System is now in power-saving mode..."
    "[LOG] No tasks found. Enjoying a virtual vacation..."
    "[LOG] No tasks available. Playing solitaire until further notice..."
    "[LOG] No quests accepted. Returning to the main menu..."
    "[LOG] No tasks detected. Summoning cat videos instead..."
    )
    random_index=$((RANDOM % ${#messages[@]}))
    echo -e "${current_time}\n\n[LOG] Nothing set to 'YES'. Now exiting...\n${messages[$random_index]}"
    exit 0
fi

## Adding email to scripts if email_notification is set to "YES"
if [ "$email_notification" = "YES" ]; then
    echo -e "[LOG] \$email_notification set to: YES, now adding email to scripts"
    sed -i "5s|.*|#PBS -M ${email_address}|" ${repository_path}/scripts/DNA_processing/*.sh
    sed -i "5s|.*|#PBS -M ${email_address}|" ${repository_path}/scripts/RNA_processing/*.sh
    sed -i "6s|.*|#PBS -m ae|" ${repository_path}/scripts/DNA_processing/*.sh
    sed -i "6s|.*|#PBS -m ae|" ${repository_path}/scripts/RNA_processing/*.sh
elif [ "$email_notification" = "NO" ]; then
    echo -e "[LOG] \$email_notification set to: NO, now removing email from scripts"
    sed -i "5s|.*||" ${repository_path}/scripts/DNA_processing/*.sh
    sed -i "5s|.*||" ${repository_path}/scripts/RNA_processing/*.sh
    sed -i "6s|.*||" ${repository_path}/scripts/DNA_processing/*.sh
    sed -i "6s|.*||" ${repository_path}/scripts/RNA_processing/*.sh
fi
#creating working directory and subdirectories if they don't already exist
mkdir -p ${workingdir}
mkdir -p ${workingdir}/LOG
mkdir -p ${workingdir}/LOG/log_${directory_name}
mkdir -p ${workingdir}/OUTPUT
## Checking if only 1 pipeline is selected
selected_pipelines=0
[ "$P1_trimmomatic_subread_bamcoverage" = "YES" ] && selected_pipelines=$((selected_pipelines+1))
[ "$P2_trimmomatic_subread" = "YES" ] && selected_pipelines=$((selected_pipelines+1))
[ "$P3_subread_bamcoverage" = "YES" ] && selected_pipelines=$((selected_pipelines+1))
[ "$P4_repeatmodeler_repeatmasker" = "YES" ] && selected_pipelines=$((selected_pipelines+1))
[ "$P5_trinity_blastxtranslation" = "YES" ] && selected_pipelines=$((selected_pipelines+1))

echo -e "[LOG] Checking if you are running a pipeline or individual tools"
if [ "$selected_pipelines" -gt 1 ]; then
    echo "Error: Multiple pipelines set to 'YES'. Please select only one to launch at a time."
    exit 1
elif [ "$selected_pipelines" -eq 1 ]; then
    echo "[LOG] A pipeline detected, running pipeline"
    if [ "$P1_trimmomatic_subread_bamcoverage" == "YES" ]; then
        echo "[LOG] Running pipeline: P1_trimmomatic_subread_bamcoverage"
        mkdir -p ${workingdir}/OUTPUT/bamcoverage_${directory_name}
        mkdir -p ${workingdir}/OUTPUT/bamcoverage_${directory_name}/raw
        export BAMCOVERAGE_DEPEND=$(qsub -P ${PROJECT} -W depend=on:1 -o ${workingdir}/LOG/log_${directory_name}/P1_bamcoverage.OU -v workingdir=${workingdir}/OUTPUT,input_path=${workingdir}/OUTPUT/subread_${directory_name}/mapping,binsize=${P_binsize},directory_name=${directory_name},repository_path=${repository_path} ${repository_path}/scripts/DNA_processing/P_bamcoverage.sh)
        mkdir -p ${workingdir}/OUTPUT/subread_${directory_name}
        export SUBREAD_DEPEND=$(qsub -P ${PROJECT} -W depend=on:1,depend=beforeok:${BAMCOVERAGE_DEPEND} -o ${workingdir}/LOG/log_${directory_name}/P1_subread.OU -v workingdir=${workingdir}/OUTPUT,genome=${P_genome},input_list=${P_input_list},directory_name=${directory_name},FROM_TRIMMOMATIC=YES ${repository_path}/scripts/DNA_processing/P_subread.sh)
        mkdir -p ${workingdir}/OUTPUT/trimmomatic_${directory_name}
        if [ "$P_seqtype" == "DNA" ]; then
            qsub -P ${PROJECT} -W depend=beforeok:${SUBREAD_DEPEND} -o ${workingdir}/LOG/log_${directory_name}/P1_trimmomatic.OU -v workingdir=${workingdir}/OUTPUT,repository_path=${repository_path},trimming_option=${P_trimming_option},input_list=${P_input_list},directory_name=${directory_name},repository_path=${repository_path} ${repository_path}/scripts/DNA_processing/P_trimmomatic.sh
        elif [ "$P_seqtype" == "RNA" ]; then
            qsub -P ${PROJECT} -W depend=beforeok:${SUBREAD_DEPEND} -o ${workingdir}/LOG/log_${directory_name}/P1_trimmomatic.OU -v workingdir=${workingdir}/OUTPUT,repository_path=${repository_path},trimming_option=${P_trimming_option},input_list=${P_input_list},directory_name=${directory_name},repository_path=${repository_path} ${repository_path}/scripts/RNA_processing/P_trimmomatic.sh
        else
            echo "[LOG] Error: Invalid sequence type. Please set \$P_seqtype to either 'DNA' or 'RNA'."
            qdel ${BAMCOVERAGE_DEPEND}
            qdel ${SUBREAD_DEPEND}
            exit 1
        fi

        ##LOG PURPOSES
        head -n100 "$0" > ${workingdir}/LOG/log_${directory_name}/P1_trimmomatic_subread_bamcoverage.launch.settings
        exit 0

    elif [ "$P2_trimmomatic_subread" == "YES" ]; then
        echo "[LOG] Running pipeline: P2_trimmomatic_subread"
        mkdir -p ${workingdir}/OUTPUT/subread_${directory_name}
        export SUBREAD_DEPEND=$(qsub -P ${PROJECT} -W depend=on:1 -o ${workingdir}/LOG/log_${directory_name}/P2_subread.OU -v workingdir=${workingdir}/OUTPUT,genome=${P_genome},input_list=${P_input_list},directory_name=${directory_name},FROM_TRIMMOMATIC=YES ${repository_path}/scripts/DNA_processing/P_subread.sh)
        mkdir -p ${workingdir}/OUTPUT/trimmomatic_${directory_name}
        if [ "$P_seqtype" == "DNA" ]; then
            qsub -P ${PROJECT} -W depend=beforeok:${SUBREAD_DEPEND} -o ${workingdir}/LOG/log_${directory_name}/P2_trimmomatic.OU -v workingdir=${workingdir}/OUTPUT,repository_path=${repository_path},trimming_option=${P_trimming_option},input_list=${P_input_list},directory_name=${directory_name},repository_path=${repository_path} ${repository_path}/scripts/DNA_processing/P_trimmomatic.sh
        elif [ "$P_seqtype" == "RNA" ]; then
            qsub -P ${PROJECT} -W depend=beforeok:${SUBREAD_DEPEND} -o ${workingdir}/LOG/log_${directory_name}/P2_trimmomatic.OU -v workingdir=${workingdir}/OUTPUT,repository_path=${repository_path},trimming_option=${P_trimming_option},input_list=${P_input_list},directory_name=${directory_name},repository_path=${repository_path} ${repository_path}/scripts/RNA_processing/P_trimmomatic.sh
        else
            echo "[LOG] Error: Invalid sequence type. Please set \$P_seqtype to either 'DNA' or 'RNA'."
            exit 1
        fi

        ##LOG PURPOSES
        head -n100 "$0" > ${workingdir}/LOG/log_${directory_name}/P2_trimmomacit_subread.launch.settings
        exit 0

    elif [ "$P3_subread_bamcoverage" == "YES" ]; then
        echo "[LOG] Running pipeline: P3_subread_bamcoverage"
        mkdir -p ${workingdir}/OUTPUT/bamcoverage_${directory_name}
        mkdir -p ${workingdir}/OUTPUT/bamcoverage_${directory_name}/raw
        export BAMCOVERAGE_DEPEND=$(qsub -P ${PROJECT} -W depend=on:1 -o ${workingdir}/LOG/log_${directory_name}/P3_bamcoverage.OU -v workingdir=${workingdir}/OUTPUT,input_path=${workingdir}/OUTPUT/subread_${directory_name}/mapping,binsize=${P_binsize},directory_name=${directory_name},repository_path=${repository_path} ${repository_path}/scripts/DNA_processing/P_bamcoverage.sh)
        mkdir -p ${workingdir}/OUTPUT/subread_${directory_name}
        export SUBREAD_DEPEND=$(qsub -P ${PROJECT} -W depend=beforeok:${BAMCOVERAGE_DEPEND} -o ${workingdir}/LOG/log_${directory_name}/P3_subread.OU -v workingdir=${workingdir}/OUTPUT,genome=${P_genome},input_list=${P_input_list},directory_name=${directory_name} ${repository_path}/scripts/DNA_processing/P_subread.sh)

        ##LOG PURPOSES
        head -n100 "$0" > ${workingdir}/LOG/log_${directory_name}/P3_subread_bamcoverage.launch.settings
        exit 0

    elif [ "$P4_repeatmodeler_repeatmasker" == "YES" ]; then
        echo "[LOG] Running pipeline: P4_repeatmodeler_repeatmasker"
        mkdir -p ${workingdir}/OUTPUT/repeatmodeler_${directory_name}
        mkdir -p ${workingdir}/OUTPUT/repeatmasker_${directory_name}
        module use /g/data/if89/apps/modulefiles
        module load exonerate/2.4.0
        ##LOG PURPOSES
        head -n100 "$0" > ${workingdir}/LOG/log_${directory_name}/P4_repeatmodeler_repeatmasker.launch.settings
        cd ${workingdir}/OUTPUT/repeatmasker_${directory_name}
        mkdir chunk
        mkdir RMout
        mkdir Merged
        cd chunk
        fastasplit -f ${P_repeatmodeler_genome} -o . -c 8
        export N_CHUNKS=$(ls *chunk* | wc -l)
        export REPEATMODELER_JOBID=$(qsub -P ${PROJECT} -o ${workingdir}/LOG/log_${directory_name}/P4_repeatmodeler.OU -v workingdir=${workingdir}/OUTPUT,genome=${P_repeatmodeler_genome},species=${P_repeatmodeler_prefix},directory_name=${directory_name},repository_path=${repository_path} ${repository_path}/scripts/DNA_processing/P_repeatmodeler.sh)
        export REPEATMASKER_MERGE_JOBID=$(qsub -P ${PROJECT} -W depend=on:${N_CHUNKS} -o ${workingdir}/LOG/log_${directory_name}/P4_repeatmasker2.OU -v workingdir=${workingdir}/OUTPUT,original_fasta=${P_repeatmodeler_genome},chunk=${workingdir}/OUTPUT/repeatmasker_${directory_name}/chunk,RMout=${workingdir}/OUTPUT/repeatmasker_${directory_name}/RMout,Merged_out=${workingdir}/OUTPUT/repeatmasker_${directory_name}/Merged,repository_path=${repository_path} ${repository_path}/scripts/DNA_processing/P_processrmout.sh)
        for chunk in ${workingdir}/OUTPUT/repeatmasker_${directory_name}/chunk/*chunk*; do
            qsub -P ${PROJECT} -W depend=afterok:${REPEATMODELER_JOBID},beforeok:${REPEATMASKER_MERGE_JOBID} -o ${workingdir}/LOG/log_${directory_name}/P4_repeatmasker_$(basename ${chunk}).OU -v inputgenome=${chunk},rmlib=${workingdir}/OUTPUT/repeatmodeler_${directory_name}/database/${P_repeatmodeler_prefix}-families.fa,outputdir=${workingdir}/OUTPUT/repeatmasker_${directory_name}/RMout ${repository_path}/scripts/DNA_processing/repeatmasker.sh
        done
        exit 0

    elif [ "$P5_trinity_blastxtranslation" == "YES" ]; then
        echo "[LOG] Running pipeline: P5_trinity_blastxtranslation"
        mkdir -p ${workingdir}/OUTPUT/trinity_${directory_name}
        mkdir -p ${workingdir}/OUTPUT/blastxtranslation_${directory_name}
        mkdir -p ${workingdir}/OUTPUT/blastxtranslation_${directory_name}/diamond
        export N_RNASEQ=$(cat ${P_trinity_input_list} | wc -l)
        while IFS=$'\t' read -r col1 col2 col3 col4 col5
        do
            export base=${col1}
            export TRANSLATION_JOBID=$(qsub -P ${PROJECT} -W depend=on:${N_RNASEQ} -o ${workingdir}/LOG/log_${directory_name}/P_blastxtranslation_${base}.OU -v workingdir=${workingdir}/OUTPUT,trinity_out=${workingdir}/OUTPUT/trinity_${directory_name}/${base}.trinity.Trinity.fasta,blastxtranslation_uniprotfastadb=${P_blastxtranslation_uniprotfastadb},blastxtranslation_uniprotfasta=${P_blastxtranslation_uniprotfasta},directory_name=${directory_name},repository_path=${repository_path} ${repository_path}/scripts/RNA_processing/blastxtranslation.sh)
            export ALL_TRANSLATION_JOBID=${TRANSLATION_JOBID}:${ALL_TRANSLATION_JOBID}
        done < ${P_trinity_input_list}
        
        cat ${P_trinity_input_list} | \
        xargs -l bash -c 'command qsub -j oe -W depend=beforeok:${ALL_TRANSLATION_JOBID} -o ${workingdir}/LOG/log_${director_name}/P_trinity_${0}.OU \
        -v outputdir=${workingdir}/OUTPUT/trinity_${directory_name},fileid=\"$0\",seqtype=\"$1\",sstype=\"$2\",leftfq=\"$3\",rightfq=\"$4\" \
        ${repository_path}/scripts/RNA_processing/trinity.sh'

        ##LOG PURPOSES
        head -n100 "$0" > ${workingdir}/LOG/log_${directory_name}/P5_trinity_blastxtranslation.launch.settings
        echo -e "P_trinity running\nPackage version:\n\t- trinity/2.12.0" >> ${workingdir}/LOG/log_${directory_name}/P.packageVersion.txt
        echo -e "P_blastxtranslation running\nPackage version:\n\t- diamond/2.1.9\n\t- perl/5.26.3" >> ${workingdir}/LOG/log_${directory_name}/P.packageVersion.txt
        exit 0

    fi
    exit 1
fi
echo "[LOG] Not running pipeline, moving on to individual tools"





selected_tools=0
[ "$trimmomatic" = "YES" ] && selected_tools=$((selected_tools+1))
[ "$subread" = "YES" ] && selected_tools=$((selected_tools+1))
[ "$bamCoverage" = "YES" ] && selected_tools=$((selected_tools+1))
[ "$trinity" = "YES" ] && selected_tools=$((selected_tools+1))
[ "$blastxtranslation" = "YES" ] && selected_tools=$((selected_tools+1))
[ "$repeatmodeler" = "YES" ] && selected_tools=$((selected_tools+1))
[ "$repeatmasker" = "YES" ] && selected_tools=$((selected_tools+1))

echo -e "[LOG] Checking if you are running an individual tool"
if [ "$selected_tools" -gt 1 ]; then
    echo "Error: Multiple tools set to 'YES'. Please select only one to launch at a time."
    exit 1
elif [ "$selected_tools" -eq 1 ]; then
    echo "[LOG] A tool detected, running tool"
    if [ "$trimmomatic" == "YES" ]; then
        echo "[LOG] Running tool: trimmomatic"
        mkdir -p ${workingdir}/OUTPUT/trimmomatic_${directory_name}
        if [ "$T_seqtype" == "DNA" ]; then
            qsub -P ${PROJECT} -o ${workingdir}/LOG/log_${directory_name}/T_trimmomatic.OU -v workingdir=${workingdir}/OUTPUT,repository_path=${repository_path},trimming_option=${T_trimming_option},input_list=${T_input_list},directory_name=${directory_name},repository_path=${repository_path} ${repository_path}/scripts/DNA_processing/T_trimmomatic.sh
        elif [ "$T_seqtype" == "RNA" ]; then
            qsub -P ${PROJECT} -o ${workingdir}/LOG/log_${directory_name}/T_trimmomatic.OU -v workingdir=${workingdir}/OUTPUT,repository_path=${repository_path},trimming_option=${T_trimming_option},input_list=${T_input_list},directory_name=${directory_name},repository_path=${repository_path} ${repository_path}/scripts/RNA_processing/T_trimmomatic.sh
        else
            echo "[LOG] Error: Invalid sequence type. Please set \$T_seqtype to either 'DNA' or 'RNA'."
            exit 1
        fi

        ##LOG PURPOSES
        head -n100 "$0" > ${workingdir}/LOG/log_${directory_name}/T_trimmomatic.launch.settings
        exit 0

    elif [ "$subread" == "YES" ]; then
        echo "[LOG] Running tool: subread"
        mkdir -p ${workingdir}/OUTPUT/subread_${directory_name}
        qsub -P ${PROJECT} -o ${workingdir}/LOG/log_${directory_name}/T_subread.OU -v workingdir=${workingdir}/OUTPUT,genome=${T_genome},input_list=${T_input_list},directory_name=${directory_name} ${repository_path}/scripts/DNA_processing/T_subread.sh

        ##LOG PURPOSES
        head -n100 "$0" > ${workingdir}/LOG/log_${directory_name}/T_subread.launch.settings
        exit 0

    elif [ "$bamCoverage" == "YES" ]; then
        echo "[LOG] Running tool: bamCoverage"
        mkdir -p ${workingdir}/OUTPUT/bamcoverage_${directory_name}
        mkdir -p ${workingdir}/OUTPUT/bamcoverage_${directory_name}/raw
        qsub -P ${PROJECT} -o ${workingdir}/LOG/log_${directory_name}/T_bamcoverage.OU -v workingdir=${workingdir}/OUTPUT,input_path=${T_bamdir},binsize=${T_binsize},directory_name=${directory_name},repository_path=${repository_path} ${repository_path}/scripts/DNA_processing/T_bamcoverage.sh
        
        ##LOG PURPOSES
        head -n100 "$0" > ${workingdir}/LOG/log_${directory_name}/T_bamcoverage.launch.settings
        exit 0

    elif [ "$trinity" == "YES" ]; then
        echo "[LOG] Running tool: trinity"
        mkdir -p ${workingdir}/OUTPUT/trinity_${directory_name}
        cat ${T_trinity_input_list} | \
        xargs -l bash -c 'command qsub -j oe -o ${workingdir}/LOG/log_${directory_name}/T_trinity_${0}.OU \
        -v outputdir=${workingdir}/OUTPUT/trinity_${directory_name},fileid=\"$0\",seqtype=\"$1\",sstype=\"$2\",leftfq=\"$3\",rightfq=\"$4\" \
        ${repository_path}/scripts/RNA_processing/trinity.sh'

        ##LOG PURPOSES
        head -n100 "$0" > ${workingdir}/LOG/log_${directory_name}/T_trinity.launch.settings
        echo -e "T_trinity running\nPackage version:\n\t- trinity/2.12.0" >> ${workingdir}/LOG/log_${directory_name}/T.packageVersion.txt
        exit 0

    elif [ "$blastxtranslation" == "YES" ]; then
        echo "[LOG] Running tool: blastxtranslation"
        mkdir -p ${workingdir}/OUTPUT/blastxtranslation_${directory_name}
        mkdir -p ${workingdir}/OUTPUT/blastxtranslation_${directory_name}/diamond
        for i in $(ls ${T_blastxtranslation_input_directory}/*.fasta); do
            export base=$(basename ${i} .trinity.Trinity.fasta)
            qsub -P ${PROJECT} -o ${workingdir}/LOG/log_${directory_name}/T_blastxtranslation_${base}.OU -v workingdir=${workingdir}/OUTPUT,trinity_out=${i},blastxtranslation_uniprotfastadb=${T_blastxtranslation_uniprotfastadb},blastxtranslation_uniprotfasta=${T_blastxtranslation_uniprotfasta},directory_name=${directory_name},repository_path=${repository_path} ${repository_path}/scripts/RNA_processing/blastxtranslation.sh
        done

        ##LOG PURPOSES
        head -n100 "$0" > ${workingdir}/LOG/log_${directory_name}/T_blastxtranslation.launch.settings
        echo -e "T_blastxtranslation running\nPackage version:\n\t- diamond/2.1.9\n\t- perl/5.26.3" >> ${workingdir}/LOG/log_${directory_name}/T.packageVersion.txt
        exit 0
        
    elif [ "$repeatmodeler" == "YES" ]; then
        echo "[LOG] Running tool: repeatmodeler"
        mkdir -p ${workingdir}/OUTPUT/repeatmodeler_${directory_name}
        qsub -P ${PROJECT} -o ${workingdir}/LOG/log_${directory_name}/T_repeatmodeler.OU -v workingdir=${workingdir}/OUTPUT,genome=${T_repeatmodeler_genome},species=${T_repeatmodeler_prefix},directory_name=${directory_name},repository_path=${repository_path} ${repository_path}/scripts/DNA_processing/T_repeatmodeler.sh

        ##LOG PURPOSES
        head -n100 "$0" > ${workingdir}/LOG/log_${directory_name}/T_repeatmodeler.launch.settings
        exit 0

    elif [ "$repeatmasker" == "YES" ]; then
        echo "[LOG] Running tool: repeatmasker"
        mkdir -p ${workingdir}/OUTPUT/repeatmasker_${directory_name}
        module use /g/data/if89/apps/modulefiles
        module load exonerate/2.4.0
        ##LOG PURPOSES
        head -n100 "$0" > ${workingdir}/LOG/log_${directory_name}/T_repeatmasker.launch.settings
        cd ${workingdir}/OUTPUT/repeatmasker_${directory_name}
        mkdir chunk
        mkdir RMout
        mkdir Merged
        cd chunk
        fastasplit -f ${T_repeatmasker_genome} -o . -c 8
        export N_CHUNKS=$(ls *chunk* | wc -l)
        export REPEATMASKER_MERGE_JOBID=$(qsub -P ${PROJECT} -W depend=on:${N_CHUNKS} -o ${workingdir}/LOG/log_${directory_name}/T_repeatmasker2.OU -v workingdir=${workingdir}/OUTPUT,original_fasta=${T_repeatmasker_genome},chunk=${workingdir}/OUTPUT/repeatmasker_${directory_name}/chunk,RMout=${workingdir}/OUTPUT/repeatmasker_${directory_name}/RMout,Merged_out=${workingdir}/OUTPUT/repeatmasker_${directory_name}/Merged,repository_path=${repository_path} ${repository_path}/scripts/DNA_processing/T_processrmout.sh)
        for chunk in ${workingdir}/OUTPUT/repeatmasker_${directory_name}/chunk/*chunk*; do
            qsub -P ${PROJECT} -W depend=beforeok:${REPEATMASKER_MERGE_JOBID} -o ${workingdir}/LOG/log_${directory_name}/T_repeatmasker_$(basename ${chunk}).OU -v inputgenome=${chunk},rmlib=${T_repeatmasker_lib},outputdir=${workingdir}/OUTPUT/repeatmasker_${directory_name}/RMout ${repository_path}/scripts/DNA_processing/repeatmasker.sh
        done

    fi
fi



