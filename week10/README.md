# Week 10 Assignment - ChIP-seq Analysis

## Background

I used [this BioProject](https://www.ncbi.nlm.nih.gov/bioproject/1060698) for this assignment, an ATACseq dataset researching the default genomic state of S. cerevisiae (baker's yeast). Runinfo for the project can be found [here](https://www.ncbi.nlm.nih.gov/sra?LinkName=bioproject_sra_all&from_uid=1060698). This BioProject is used to support the data of [this paper](https://pubmed.ncbi.nlm.nih.gov/38448583/). 

There are 8 samples/runs used in the project, and it only looked at the HPRT1 loci, which in igv can be found on the chromosome NC_001144.5. It does not seem like there is a natural control sample used, since they use a synthetic version of the loci as a "control" according to the paper, which I am interpereting that the samples that have "integrated" in the name are the syntheic versions. 

Here is a list of the samples used and their identification:

## IGV View & Analysis

Total peaks for each sample:
1. GSM8001719 - 485616
2. GSM8001720 - 573322
3. GSM8001721 - 624662
4. GSM8001722 - 559135
5. GSM8001723 - 472637
6. GSM8001724 - 510309
7. GSM8001725 - 543319
8. GSM8001726 - 472503

After filtering, they all end up in the 300000-350000 range

## Using the Makefile 

### Prerequisites

Ensure you are in your bioinfo environment and have deepTools and macs3 installed

### Commands

```
# Displays the assignments of the variables and the main commands
make usage

# Downloads the FASTA genome file
make genome

# Downloads the GFF file
make gff

# Reads the csv file for sample name and run SRR, generates FASTQ, BAM, and BW files for each
make batch

# Analyzes the peaks for the current selected/default sample 
make peaks

# Downloads the genome, then generates FASTQ, BAM, and BW files for the current selected/default sample
make all

# Removes all of the generated files, while keeping the main genome file
make clean
```
