# Week 5 - Generating a BAM File

## Before Creating the Makefile

### Variables Needed for Generation

### How to Determine "N"

Start by finding the number of bases in your reference genome and the average number of bases for each sequencing read. Then multiply the number of reference genome bases by the amount of coverage you are aiming for. We will use x10 coverage:

  ```reference genome bases number x 10 ```

Next, divide this number by the average number of bases per sequencing read from the FASTQ files:

  ```10(reference genome bases number) / average sequencing read bases number```

The result is the number of reads that should be downloaded, or "N"

My reference genome for z. bailii is 21,141,148 bases.
Sequencing reads from the FASTQ files are about 260 bases on average

  ```21,141,148 x 10 = 211,411,480 ```
  
  ```211,411,480 / 260 = 813,121 reads should be downloaded```

## Using the Makefile

## Z.bailii BAM Analysis

166126 + 0 in total (QC-passed reads + QC-failed reads)
135414 + 0 primary
0 + 0 secondary
30712 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
161560 + 0 mapped (97.25% : N/A)
130848 + 0 primary mapped (96.63% : N/A)
135414 + 0 paired in sequencing
67707 + 0 read1
67707 + 0 read2
123832 + 0 properly paired (91.45% : N/A)
130490 + 0 with itself and mate mapped
358 + 0 singletons (0.26% : N/A)
6588 + 0 with mate mapped to a different chr
6007 + 0 with mate mapped to a different chr (mapQ>=5)

The project I chose seems to not actually cover that much of the genome, there is a lot of space in between reads, even with the x10 coverage. 
Chromosome examples that have a lot of extra coverage (in certain spots)
A 13
B 21
A 44

Visual of Chromosome A 13
<img width="2256" height="1196" alt="image" src="https://github.com/user-attachments/assets/60bef575-1f62-4678-9abe-2c4f2d40e1c3" />



Chromosome examples with low coverage 
B 77
B 38
A 1

Visual of Chromosome A 1
<img width="2244" height="1150" alt="image" src="https://github.com/user-attachments/assets/67933735-e651-43aa-bcec-a6f9d4d91780" />
