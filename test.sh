


export S3_DEPEND=$(qsub -P xl04 -W depend=on:1 s3.sh)
export S2_DEPEND=$(qsub -P xl04 -W depend=on:1,beforeok:${S3_DEPEND} s2.sh)
qsub -P xl04 -W depend=beforeok:${S2_DEPEND} s1.sh