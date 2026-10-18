# Week 8 Assignment - Predicting Variant Effects

## Background Info

I used four different strains to see variance against this [Z.bailii genome](https://www.ncbi.nlm.nih.gov/datasets/genome/GCA_000530735.1/), which is in the snpEff database and can be found using these commands:

```
# Install snpEff
pixi add snpeff

# Dump the databases to a file.
snpEff databases > database.txt

# Search for the specific genome
cat database.txt | grep 000530735
```

The strains used are as follows:
1. [PGY799](https://www.ncbi.nlm.nih.gov/sra/SRX33176764[accn]) SRR = SRR38342019
2. [PGY797](https://www.ncbi.nlm.nih.gov/sra/SRX33176759[accn]) SRR = SRR38342024	
3. [PGY767](https://www.ncbi.nlm.nih.gov/sra/SRX33176703[accn]) SRR = SRR38342080	
4. [PGY774](https://www.ncbi.nlm.nih.gov/sra/SRX33176709[accn]) SRR = SRR38342074	

## Analysis

### Reference Tables
<img width="510" height="510" alt="image" src="https://github.com/user-attachments/assets/e9a88b5e-7d59-4f2d-b2b0-fbbde2ef9d3b" />
<img width="434" height="564" alt="image" src="https://github.com/user-attachments/assets/5bd8e1e6-2ef4-4a52-96ba-52a09ee1e889" />

### A Few (Of Thousands) Z.bailii Variants 

First I am looking at a couple of variants on the following gene of chromosome 1.1, this gene is related to Autophagy-related protein 2.
<img width="960" height="795" alt="image" src="https://github.com/user-attachments/assets/24a2311b-9349-4c5d-a044-bfb8df1014c2" />

The variant on the left up close:
<img width="840" height="795" alt="image" src="https://github.com/user-attachments/assets/e0e67ebb-747c-42be-8ce3-8572c36a3a9f" />
This variant is at position 7387 and the initial codon is AAC, which codes for asparagine. This variant, which is on samples PGY767, PGY774, and PGY797, has a T in place of the C, but this is a silent mutation since the codon still codes for asparagine. 

The variants on the right up close:
<img width="960" height="795" alt="image" src="https://github.com/user-attachments/assets/6f64865f-4e94-478c-a9e1-8ea4018dff87" />
These variants are at positions 8440 and 8452 and the initial codons are GGA and AAG, which code for glycine and lysine respectively. This variant on sample PGY799 changes the codons to GGG and AAA respectively, but this change still codes for glycine and lysine and is therefore also silent. 

The next gene I am looking at, on chromosome 118.1, is an uncharacterized protein with several variants.
<img width="992" height="795" alt="image" src="https://github.com/user-attachments/assets/f5a673ce-01d6-49bd-bf5d-4d4d98afec87" />

I am focusing on the variants directly next to each other in between the two info panels shown:
<img width="992" height="795" alt="image" src="https://github.com/user-attachments/assets/df0bda40-9121-44af-a0a6-7c12462b68f4" />
These variants are at positions 47303 and 47304 and the initial codon they are meant to produce together is TGA, which is supposed to code for a stop. On samples PGY774 and PGY799, the G is substituted for an A, which produces TAA, which continues to code for a stop. However, on sample PGY767, the G is substituted for an A _and_ the A is substituted for a T, which changes the produced codon to TAT, which codes for tyrosine. 

The last gene area I am looking at has three genes in the same part of the chromosome, on chromosome 104.1, and is used for tRNA generation.
<img width="1099" height="795" alt="image" src="https://github.com/user-attachments/assets/fc73404d-739c-4d78-a65d-0e567e9a85b5" />

The summary for the variant is shown below:
<img width="1099" height="795" alt="image" src="https://github.com/user-attachments/assets/1503e2e8-2596-4e1f-8514-3eb5f0336166" />
The GFF3 data doesn't clarify which codon is used, but any which way, the variant on PGY774 causes the codon to change what it codes for. It could be TGG, GGC, or GCA initially, but this variant swaps a G for an A, changing the codons to TGA, GAC, or ACA. This would change the codes from tryptophan to stop, glycine to aspartic acid, or alanine to threonine respectively. If the first codon is the reading frame that is used, this variant would be detrimental to tRNA production for the strain, because of the premature stop codon. 


## Using The Makefile 

```
# To generate the FNA and GFF3 files and folders for the Z.bailii genome and the FASTQ, BAM, and VCF files and folders for the current sample
make bcftools.2026.mk all

# To generate the FASTQ, BAM, and VCF files for the next sample
make bcftools.2026.mk strainadd

# To remove the FASTQ, BAM, and VCF files for the current sample 
make bcftools.2026.mk clean
```

To switch to the next sample to download, swap out the SRR number and the strain name either through a command or manually in the makefile before rerunning the strainadd command. I opted to manually change the information each time.

## Further Steps 

```
# To create the merged VCF file 
bcftools merge --write-index -O z -o vcf/merged-VCF.vcf.gz \
    vcf/PGY767.vcf.gz \
    vcf/PGY774.vcf.gz \
    vcf/PGY797.vcf.gz \
    vcf/PGY799.vcf.gz

# To create the merged VCF file from BAM files
bcftools mpileup -d 100 --annotate 'INFO/AD,FORMAT/DP,FORMAT/AD,FORMAT/ADF,FORMAT/ADR,FORMAT/SP' -O u -f fna/Zbailii.fna \
    bam/PGY767.bam \
    bam/PGY774.bam \
    bam/PGY797.bam \
    bam/PGY799.bam | \
    bcftools call --ploidy 1 --annotate 'FORMAT/GQ'  -mv -O u | \
    bcftools norm -f fna/Zbailii.fna -d all -O u | \
    bcftools sort --write-index -O z -o vcf/merged-BAM.vcf.gz

# Commands used to annotate each sample

# PGY767
snpEff Zygosaccharomyces_bailii_isa1307_gca_000530735  vcf/PGY767.vcf.gz > vcf/PGY767.annotated.vcf

# PGY774
snpEff Zygosaccharomyces_bailii_isa1307_gca_000530735  vcf/PGY774.vcf.gz > vcf/PGY774.annotated.vcf

# PGY797
snpEff Zygosaccharomyces_bailii_isa1307_gca_000530735  vcf/PGY797.vcf.gz > vcf/PGY797.annotated.vcf

# PGY799
snpEff Zygosaccharomyces_bailii_isa1307_gca_000530735  vcf/PGY799.vcf.gz > vcf/PGY799.annotated.vcf
```

