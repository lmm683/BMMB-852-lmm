# Week 9 Assignment - Automating a Workflow

## Background Information

### Genome Used

For this assignment, in order to find sufficient data, I switched my genome of choice to _Saccharomyces cerevisiae_, more commonly known as "Brewer's Yeast," a very widely used yeast in intentional fermentation of goods. The FASTA and GFF files can be found [here](https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_000146045.2/).

### BioProject Used

The BioProject I used to source the samples can be found [here](https://www.ncbi.nlm.nih.gov/bioproject/750521). This BioProject was done in support of [this paper](https://pubmed.ncbi.nlm.nih.gov/23376951/), which is an exploration of yeast heritability, taking the sequence of the offspring of a cross between two yeast strains. The bioproject is made up of 270 samples, 10 of which were randomly selected to include chronological lifespan data. For this assignment, I focused on those 10 randomly selected strains. 

## Using The Workflow

### How Does This Work?

This workflow utilizes a csv file to source the run and sample information to generate fastq, bam, and vcf files. As a default, the SRR accession and the sample name are "EMPTY" in the makefile, and assigned through the contents of the csv file. The csv file used was sourced from [this page](https://www.ncbi.nlm.nih.gov/sra?LinkName=bioproject_sra_all&from_uid=750521) by clicking "Send To," then selecting "File," then switching the format to Runinfo. 

The Makefile then calls information from this csv file to fill in the SRR accession and the Sample Name for each of the runs that are contained in the csv file to generate FASTQ, BAM, and VCF files. 

### Makefile Commands

```
# Displays the assignments of the variables and the main commands
make usage

# Downloads the FASTA genome file
make genome

# Downloads the GFF file
make gff

# Reads the csv file for sample name and run SRR, generates FASTQ, BAM, and VCF files for each
make batch

# Merges the VCF files into one, and separately merges the BAM files into one VCF file. 
make merge

# Downloads the genome and gff files, runs the batch and merge commands
make all

# Removes the FASTQ, BAM, and VCF files 
make clean
```

## IGV Visualization 

### Some Examples of the Resulting IGV View

### Interesting Sections of the Genome 
