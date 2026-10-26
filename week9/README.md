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

# Downloads the genome and gff files, then makes fastq, bam, and vcf files for the default strain
make all

# Removes the FASTQ, BAM, and VCF files 
make clean
```

## IGV Visualization 

### Some Examples of the Resulting IGV View

IGV Summary View of All Chromosomes

<img width="1098" height="795" alt="image" src="https://github.com/user-attachments/assets/f5c7a52f-9270-4a50-8326-cea03cbcb91e" />

Some Example Views

<img width="412" height="298" alt="image" src="https://github.com/user-attachments/assets/3e85291b-ed29-446a-af9d-21c044e14479" />
<img width="412" height="298" alt="image" src="https://github.com/user-attachments/assets/6d6ae0f5-8c40-4672-aa24-6d4258c2ca40" />
<img width="412" height="298" alt="image" src="https://github.com/user-attachments/assets/077f2c3f-96aa-4119-a030-6c0ef7bbac61" />
<img width="412" height="298" alt="image" src="https://github.com/user-attachments/assets/5e370813-031d-40e7-a795-e13a9ed36497" />

### Interesting Sections of the Genome 

The last example view has something very interesting going on. There is no variation across any of the samples in specific regions that align with Ribosomal RNA encoding genes, but variation in between the rRNA genes:

<img width="1098" height="795" alt="image" src="https://github.com/user-attachments/assets/26001a92-1e73-4325-840d-8ce22692f4f1" />

The rRNA genes must be highly conserved across strains, which makes sense since rRNA is highly conserved in general. 

Next to the rRNA genes, there is a deletion across all 10 strains, which leads me to think that the reference genome may have an insertion at this location:

<img width="1098" height="795" alt="image" src="https://github.com/user-attachments/assets/837021e6-937a-40f3-bfb5-e08931dcae28" />


Another section of a different chromosome exhibits something similar to the rRNA, with zero variation on a gene encoding for a retrotransposon:

<img width="1098" height="795" alt="image" src="https://github.com/user-attachments/assets/8d03e58a-bc63-40ab-91e9-bb74ad6b97fb" />

Once again this must be highly conserved across strains. 
