# Week 10 Assignment - ChIP-seq Analysis

## Background

I used [this BioProject](https://www.ncbi.nlm.nih.gov/bioproject/1060698) for this assignment, an ATACseq dataset researching the default genomic state of S. cerevisiae (baker's yeast). Runinfo for the project can be found [here](https://www.ncbi.nlm.nih.gov/sra?LinkName=bioproject_sra_all&from_uid=1060698). This BioProject is used to support the data of [this paper](https://pubmed.ncbi.nlm.nih.gov/38448583/). 

There are 8 samples/runs used in the project, and it only looked at the HPRT1 loci, which in igv can be found on the chromosome NC_001144.5. It does not seem like there is a natural control sample used, since they use a synthetic version of the loci as a "control" according to the paper, which I am interpereting that the samples that have "integrated" in the name are the syntheic versions. 

Here is a list of the samples used and their identification:

<img width="1010" height="376" alt="image" src="https://github.com/user-attachments/assets/208313f8-583f-48d7-a935-92757c56dad9" />


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

This is the overall view of all the chromosomes, as you can see the data for this project is concentrated on the one chromosome:
<img width="2196" height="1590" alt="image" src="https://github.com/user-attachments/assets/d3b35889-390c-43f6-9d8b-04beead7e84e" />

When we look at just that chromosome, we can once again see the data is further concentrated to a certain region of the chromosome:
<img width="2196" height="1590" alt="image" src="https://github.com/user-attachments/assets/a4b07fc1-c8c8-472a-93a7-bdd6fcf74fbd" />

Very small peaks can be found across the whole chromosome, but this one location has the most notable data. When we zoom in on it, we can see it is more spread out:
<img width="2196" height="1590" alt="image" src="https://github.com/user-attachments/assets/be778112-e358-4f48-9f29-04368374ec8c" />

There are several areas that are more variable, as such:
<img width="2196" height="1590" alt="image" src="https://github.com/user-attachments/assets/e08e8695-3573-4a59-ab3e-0247acff70ae" />
<img width="2196" height="1590" alt="image" src="https://github.com/user-attachments/assets/e46cd1bb-0758-494e-9a92-14bb1ffb42f7" />

And then other areas that have more uniform shapes, as such:
<img width="2196" height="1590" alt="image" src="https://github.com/user-attachments/assets/f62b289b-9c7f-4669-b1fc-b9ebc706d3d7" />
<img width="2196" height="1590" alt="image" src="https://github.com/user-attachments/assets/8bfe3850-a10a-459c-8b6c-9bae9772e86f" />

Overall, the spikes are very closely in the same spots and same sizes.
<img width="2196" height="1590" alt="image" src="https://github.com/user-attachments/assets/76044e7e-f22d-4bd9-8d2f-3247e5dcdb58" />

However, you can also see that it is not perfect in all areas. For example sample GSM8001723 has noticeably lower peaks across the board in this   section:
<img width="2196" height="1590" alt="image" src="https://github.com/user-attachments/assets/0ce59d06-921d-40e7-9284-11fd2a896081" />

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
