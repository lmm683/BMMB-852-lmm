# Week 7 - Generate a VCF File

## Before We Begin
I changed the FASTQ file I chose to get solid coverage of the genome for this assignment. New Run information can be found [here](https://trace.ncbi.nlm.nih.gov/Traces/?view=run_browser&acc=SRR38342019&display=metadata)

This read has much better coverage:
<img width="2250" height="1186" alt="image" src="https://github.com/user-attachments/assets/09db261e-f866-44c2-8775-c67eb81d380d" />

## Analysis Questions

### How many variants were called?

Using the following command:

```
echo 'Variant records:' && bcftools view -H vcf/PGY799.vcf.gz | wc -l && echo '---' && bcftools stats vcf/PGY799.vcf.gz | grep '^SN\s'| head -n 20
```

I get an output of:
```
SN      0       number of samples:      1
SN      0       number of records:      72700
SN      0       number of no-ALTs:      0
SN      0       number of SNPs: 68892
SN      0       number of MNPs: 0
SN      0       number of indels:       3808
SN      0       number of others:       0
SN      0       number of multiallelic sites:   288
SN      0       number of multiallelic SNP sites:       60
```

Looking at the number of records, it seems that 72700 variant instances were called. 

### What kinds of variants are present?

Looking at the same report, it seems that most of the variants called are SNPs, or single nucleotide polymorphisms (subsitutions). There were also a significant amount of indels. I can also see on the visualized vcf file that there are multiple insertions, but this is not explicitly stated in the list of variants called. 

### Which calls look like true variants, and which look like errors?

I am only looking at chromosome 1a, since it has the best FASTA genome coverage. On this chromosome, almost all of the variants called look like true variants, there are a couple that are marked as heterozygous and have about half variation half perfect match to the original, so those could be errors or they could be heterozygous. 

Possible heterozygote example, where the dark blue line is in both rows:
<img width="2278" height="1590" alt="image" src="https://github.com/user-attachments/assets/5670117f-21d2-47b2-9863-6f2e585a0a96" />


### Are the calls supported by the alignments?

Yes, very much so. The sample that I chose to do this comparison for has a significant amount of very clearly demonstrated SNP variants, and all of the variants shown in chromosome 1a are clearly supported across basically all of the reads. 

Visualization of VCF file:
<img width="2278" height="1590" alt="image" src="https://github.com/user-attachments/assets/9ccefd59-caa6-4da2-ba8a-29934db70f78" />

## Makefile Commands and Uses

```
# lists files used and term definitions
make usage

# prepares FASTA, FASTQ, and BAM files
make all

# individually downloads the FASTA file
make genome

# individually downloads the FASTQ file
make fastq

# individually indexes the FASTA genome file
make index

# individually aligns and prepares the BAM file
make align

# displays the statistics of the BAM file
make bamstats

# prepares the VCF file
make vcf

# displays the statistics of the VCF file
make vcfstats

# cleans up the FASTQ, BAM, and VCF files
make clean
