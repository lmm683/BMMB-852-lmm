Must be in bioinfo in designated directory

Files were loaded manually into IGV

Size of FASTA file: 21,007 KB
I am specifically observing the ZBAI_A_scaffold_001 chromosome, which is 41kb
There are no annotations to this file, besides a GFF3 file if that counts. 
It seems like there 85 chromosomes, some chromosomes only have side recorded and others have both. 
This genomic build honestly does not seem very refined, there is not much described besides the nucleotides and amino acids (or so it seems), and the number of chromosomes is not super clear.

You can run the makefile by using the command 'make' 
This will download two folders, a fasta folder and a gff folder, each folder containing respective files to use in igv. 
You can clean up the folders & files by using the command 'make clean'

The genes are roughly 200-2,000 bp apart

Switched translation to mitochondrial yeast, since Z.bailii is a yeast

Selected coordinate:
ZBAI_A_scaffold_001:24,509
This base pair could be a part of the codon for I, T, or Y on one side of the chromosome
When you flip the strand, the other side of this base pair could be a part of the codon for K, N, or M.
It is an A-T base pair. 

The data displayed on the two available tracks is the raw sequence of base pairs (FASTA file data)
and the amino acids that the codons likely code for (GFF3 file data).

The gene that contains my selected coordinate is a protein encoding gene that likely is subunit 16 of a protein that  mediates RNA polymerase II transcription.
