How to determine N:

My reference genome for z. bailii is 21,141,148 bases.
Sequencing reads from the FASTQ files are about 260 bases on average
21,141,148 x 10 = 211,411,480 
211,411,480 / 260 = 813,121 reads should be downloaded

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
![alt text](image-1.png)
B 21
A 44


Chromosome examples with low coverage 
B 77
B 38
A 1
![alt text](image.png)