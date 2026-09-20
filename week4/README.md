# Week 4 - Obtaining FASTQ Files from SRA and Analyzing Their Quality

## Before Getting Started

### Steps I took

1. I went to [NIH's SRA](https://www.ncbi.nlm.nih.gov/sra) and searched for my genome "Zygosaccharomyces bailii", and found that there are 40 datasets available

2. I chose [this data set](https://trace.ncbi.nlm.nih.gov/Traces/index.html?view=run_browser&acc=SRR12618190&display=metadata&search=1-20) with the accession number SRR12618190

3. I used VS Code to create a makefile that downloads and prepares the fastq files for analysis, and gives you the option to quality control the data

### Other Discussion of Datasets

I would say this genome is somewhat popular given the number of datasets. I wouldn't call it too popular, however, since I imagine that a more popular data set would have hundreds or thousands of datasets. For the list of assay types that came up, there is one AMPLICON assay, 21 RNA-seq, and 18 WGS (whole genome sequence). The data set I selected is a WGS. The platform is ILLUMNIA for all of the datasets except for the AMPLICON assay, which uses DNBSEQ. 

The list of sources for the DNA is very interesting, most of the sources are a fermented liquid of some sort, but some others come from oak galls which surprises me. 

## Makefile Information

### Before Using the Makefile

must have NCBI SRA Toolkit installed

```
pixi add bioconda::sra-tools
```

You also should have xdg-utils for the make open command

```
sudo apt install xdg-utils
```

Make sure that [fastp](https://github.com/OpenGene/fastp#quality-filter) is installed

### Using the Makefile

```
# downloads and preps the files for viewing based on the accession number in the makefile
make

# opens the report in your browser
make open

# quality controls for scores above 34
make trim

# opens the newly quality controlled reports
make opentrim
```

### Discussion of QC Methods

I used the quality control method of filtering for quality scores of 25 or higher. This created the slightest difference in the graphs, but it was not enough to change the per base sequence quality overall assessment (X or check). I then changed the quality filter to 34 or higher, which caused a significant enough change in the second fastq file that the per base sequence quality went from an X to an ! and visually looks much stronger. Other than that, no significant change occured for any other part of either report. 

<img width="2766" height="1590" alt="image" src="https://github.com/user-attachments/assets/bf018716-eac7-4ea1-94c8-eef9ed512137" />

<img width="2768" height="1590" alt="image" src="https://github.com/user-attachments/assets/808c00a8-1b43-46d8-889b-d608fe511bc8" />
