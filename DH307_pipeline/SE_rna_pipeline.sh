#!/bin/bash

# Step 1: Quality control using FastQC
fastqc ERR7454544.fastq.gz -o output1
																																																																																																																																																									

# Step 2: Trim adapters and low-quality bases using Trimmomatic

java -jar Trimmomatic-0.39/trimmomatic-0.39.jar SE -threads 4 -phred33 ERR7454544.fastq.gz \
    output_1.fastq.gz \
    ILLUMINACLIP:Trimmomatic-0.39/adapters/TruSeq3-SE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36     
    
# Step 3: Alignment using HISAT2
hisat2 -q -x ~/Desktop/Hemant_DH307/E-MTAB-11222/grch38/genome -U output_1.fastq.gz -S output_alignment.sam																																																																																																																																																																																																																																																																																																												

# Step 4: Convert SAM to BAM and sort
samtools view -bS output_alignment.sam | samtools sort -o output_alignment_sorted.bam

# Step 5: Index the sorted BAM file
samtools index output_alignment_sorted.bam

# Step 6: Assemble transcripts and quantify using StringTie
stringtie output_alignment_sorted.bam -G ~/Desktop/Hemant_DH307/E-MTAB-11222/grch38/genome.gtf -o output_transcripts.gtf

# Step 7: Run differential expression analysis using DESeq2 in R for SE

# End of RNA-Seq Pipeline
