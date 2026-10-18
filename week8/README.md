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

