I went to [NIH's SRA](https://www.ncbi.nlm.nih.gov/sra) and searched for my genome "Zygosaccharomyces bailii"

There are 40 datasets available

I chose [this data set](https://trace.ncbi.nlm.nih.gov/Traces/index.html?view=run_browser&acc=SRR12618190&display=metadata&search=1-20)

I would say this genome is somewhat popular given the number of datasets

For the assay types, there is one AMPLICON assay, 21 RNA-seq, and 18 WGS (whole genome sequence)

The platform is ILLUMNIA for all of the datasets except for the AMPLICON assay, which uses DNBSEQ

The list of sources for the DNA is very interesting, most of the sources are a fermented liquid of some sort, but some others come from oak galls which surprises me. 

## Before Using the Makefile

must have NCBI SRA Toolkit installed

```
pixi add bioconda::sra-tools
```

You also should have xdg-utils for the make open command

```
sudo apt install xdg-utils
```

Make sure that [fastp](https://github.com/OpenGene/fastp#quality-filter) is installed

## Using the Makefile

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

I used the quality control method of filtering for quality scores of 25 or higher. This created the slightest difference in the graphs, but it was not enough to change the per base sequence quality overall assessment (X or check). I then changed the quality filter to 34 or higher, which caused a significant enough change in the second fastq file that the per base sequence quality went from an X to an ! and visually looks much stronger. Other than that, no significant change occured for any other part of either report. 
