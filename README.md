# skink-codes
This repository contains useful scripts to streamline necessary processing of data for sex chromosome analysis. There are 2 important files in this repository which you should get familiar with if you are planning to use some of the code:
1. **launch.sh** Your config file, run this to launch jobs
2. **generate_input_list.sh** Generate input list to tell trimmomatic or subread what input files to use.

# Dependency
Scripts here are designed to run on NCI gadi and uses a lot of modules in project if89, they will need adjustment if running on other HPC system.
To get started, clone the repository somewhere where you have access:
```
cd /path/to/somewhere/you/like
git clone https://github.com/kango2/skink-codes.git
```
That's it, you now have all the scripts available, to launch them, read the next section

# generate_input_list.sh
This file helps you generate a list of input files with their full path into your `${workingdir}`, this list is used by trimmomatic and subread to access your data.
Usage is simple, first fill in generate_input_list.sh with with your variables. Then run it with:
```
#Edit generate_input_list.sh
cd /path/to/your/copy/of/the/repository
./generate_input_list.sh
```
If you want to merge the bam files (e.g. samples with multiple lanes), you can specify this in the input.csv file
The file is a 4 column comma separated file with:
1. merged_samplename
2. unmerged_samplename
3. full path to left (R1) fastq file
4. full path to right (R2) fastq file

Each sample should only take 1 line unless it needs lane merging.
In which case, all lines with the same column 1 entry will be merged together.
For samples that don't need merging, Please keep column 1 and column 2 the same.
Example of `input.csv` with 4 samples below, sample 1 and 4 will be merged:
```
Sample1,Sample1_L001,/path/to/Sample1_L001_R1.fastq.gz,/path/to/Sample1_L001_R2.fastq.gz
Sample1,Sample1_L002,/path/to/Sample1_L002_R1.fastq.gz,/path/to/Sample1_L002_R2.fastq.gz
Sample2,Sample2,/path/to/Sample2_R1.fastq.gz,/path/to/Sample2_R2.fastq.gz
Sample3,Sample3,/path/to/Sample3_R1.fastq.gz,/path/to/Sample3_R2.fastq.gz
Sample4,Sample4_L001,/path/to/Sample4_L001_R1.fastq.gz,/path/to/Sample4_L001_R2.fastq.gz
Sample4,Sample4_L002,/path/to/Sample4_L002_R1.fastq.gz,/path/to/Sample4_L002_R2.fastq.gz
Sample4,Sample4_L003,/path/to/Sample4_L003_R1.fastq.gz,/path/to/Sample4_L003_R2.fastq.gz
Sample4,Sample4_L004,/path/to/Sample4_L004_R1.fastq.gz,/path/to/Sample4_L004_R2.fastq.gz
```

# launch.sh
This is the file that controls all (almost all) of the settings in the job you want to run. Usage is simple, first edit the file with the settings you need within the double quotes. Then run it with:
```
# Edit launch.sh
cd /path/to/your/copy/of/the/repository
./launch.sh
```
scripts for 4 pipelines/streamline and 6 individual tools are launchable from this file. You can only launch one pipeline/individual tool each time, this is to avoid conflict with directory name, there will be internal checks.

# trinity.filelist
This is the same file needed in https://github.com/kango2/pogo
This file is only needed if you are launching a de novo transcriptome assembly job using trinity. It is a 5 column tab separated file with:
1. Unique name of assembly (identifier, prefix)
2. Sequencing type (SE or PE)
3. Strandedness of RNAseq (RF|FR|US for PE, R|F|US for SE)
4. Full path to left (R1) fastq file, comma separated if there are multiple lanes
5. Full path to right (R2) fastq file, comma separated if there are multiple lanes

For SE samples, only 4 columns are needed (NO trailing whitespaces!!!)
For column 3, specify One of `RF/FR/US` denoting strandedness of the paired end RNAseq data for that sample. `FR` is where `R1` reads are in sense orientation to the RNA and `R2` reads are antisense. `RF` is the opposite where `R1` is antisense and `R2` is sense relative to the RNA. `US` represents unstranded library. Similarly `F` `R` and `US` for single end data.  
Example of `trinity.filelist` with 4 samples below:
```
PEsample1_SingleLane	PE	RF	/path/to/sample1_R1.fq.gz	/path/to/sample1_R2.fq.gz
PEsample2_MultiLane	PE	RF	/path/to/sample2_R1_L001.fq.gz,/path/to/sample2_R1_L002.fq.gz	/path/to/sample2_R2_L001.fq.gz,/path/to/sample2_R2_L002.fq.gz
SEsample3_SingleLane	SE	R	/path/to/sample3_R1.fq.gz
SEsample4_MultiLane	SE	US	/path/to/sample4_R1_L001.fq.gz,/path/to/sample4_R1_L002.fq.gz
```

# Additional info
## pipeline P1
This trims your raw data with trimmomatic, then map the trimmed data to your genome with subread, and finally calculate read depth coverage in `${P_binsize}` basepair non-overlapping sliding windows.
`${directory_name}` will be automatically set to the exact time when you launched the job.
outputs are stored in:
```
├── ${workingdir}/OUTPUT
│   └── trimmomatic_${directory_name}
│   └── subread_${directory_name}
│   └── bamcoverage_${directory_name}/fixed
```

## Pipeline P2
This trimms your raw data with trimmomatic, then map the trimmed data to your genome with subread.
`${directory_name}` will be automatically set to the exact time when you launched the job.
outputs are stored in:
```
├── ${workingdir}/OUTPUT
│   └── subread_${directory_name}
│   └── trimmomatic_${directory_name}
```

## Pipeline P3
This maps your raw data to your genome with subread, then calculate read depth coverage in `${P_binsize}` basepair non-overlapping sliding windows.
`${directory_name}` will be automatically set to the exact time when you launched the job.
outputs are stored in:
```
├── ${workingdir}/OUTPUT
│   └── subread_${directory_name}
│   └── bamcoverage_${directory_name}
```

## Pipeline P4
This generates a species-specific TE library from your genome with RepeatModeler, then soft-mask the genome using the generated TE library with RepeatMasker.
`${directory_name}` will be automatically set to the exact time when you launched the job.
outputs are stored in:
```
├── ${workingdir}/OUTPUT
│   └── repeatmodeler_${directory_name}
│   └── repeatmasker_${directory_name}
```
