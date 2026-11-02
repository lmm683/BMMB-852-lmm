# Name of the reference genome
NAME = S.cerevisiae

# Genome fasta file
FASTA = fna/$(NAME).fna

# GFF annotation file
GFF = gff/$(NAME).gff.gz

# SRR accession number
SRR = SRR27410791

# Sample name 
SAMPLE = ATACseq_GSM8001720

# Number of reads to download
N = 10000000

# Read 1 in fastq format. 
# This run is single end sequencing.
R1 = fastq/$(SRR)_1.fastq

# BAM file derived from the sample name
BAM = bam/$(SAMPLE).bam

# BigWig coverage file
BW = bw/$(SAMPLE).bw

# BWA index sentinel
INDEX = $(FASTA).bwt

# Background sample name
BKG = $(SAMPLE)

# Background BAM file
BAM_BKG = bam/$(BKG).bam

# The output Peak file
PEAKS = peaks/$(SAMPLE)_peaks.broadPeak

# Current directory
DIR = $(shell pwd)

# Netcat command to send commands to IGV
NC = nc localhost 60151

# The design file
DESIGN = SraRunInfoATACseq.csv

# Run two jobs at a time since the alignment is already multithreadedwith 4 threads, thus using 2x4=8 cores
PARALLEL = parallel --eta --colsep , --header : --jobs 2 --lb


# --- All definitions above this line. All code below this line ---

usage:
	@echo "#"
	@echo "# ATAC-seq analysis with MACS3"
	@echo "#"
	@echo "# SRR=$(SRR)"
	@echo "# NAME=$(NAME)"
	@echo "# SAMPLE=$(SAMPLE)"
	@echo "# N=$(N)"
	@echo "#"
	@echo "# BW=$(BW)"
	@echo "# FASTA=$(FASTA)"
	@echo "# GFF=$(GFF)"
	@echo "#"
	@echo "# BAM=$(BAM)"
	@echo "# PEAKS=$(PEAKS)"
	@echo "#"
	@echo "# make all"
	@echo "#"
	@echo "# make genome"
	@echo "# make gff"
	@echo "# make fastq"
	@echo "# make align"
	@echo "# make peaks"
	@echo "# make clean"
	@echo "#"

# Download the genome.
genome: $(FASTA)

$(FASTA):
	mkdir -p $(dir $@)
	datasets download genome accession GCF_000146045.2 --include genome --filename $@.zip
	unzip -p $@.zip 'ncbi_dataset/data/GCF_000146045.2/*_genomic.fna' > $@.tmp
	mv $@.tmp $@
	rm -f $@.zip
	seqkit stats $@

# Download the GFF annotation.
gff: $(GFF)
	ls -lh $(GFF)

# We need to unzip, sort and re-compress the GFF annotation.
# To be readable IGV and other bioinformatics tools.
$(GFF):
	mkdir -p $(dir $@)
	datasets download genome accession GCF_000146045.2 --include gff3 --filename $@.zip
	unzip -p $@.zip 'ncbi_dataset/data/GCF_000146045.2/genomic.gff' > $@.tmp
	mv $@.tmp $@
	rm -f $@.zip

# Download the fastq files.
fastq: $(R1)
	@ls -lh $(R1)

$(R1):
	mkdir -p $(dir $@)
	fastq-dump -X $(N) --split-files -O $(dir $@) $(SRR)
	seqkit stats $@

# Index the genome.
index: $(INDEX)

$(INDEX): $(FASTA)
	bwa index $<

# Align the fastq files to the genome.
align: $(BAM) $(BW)
	@ls -lh $(BAM)
	@ls -lh $(BW)

$(BAM): $(INDEX) $(R1)
	mkdir -p $(dir $@)
	bwa mem $(FASTA) $(R1) | samtools sort -o $@
	samtools index $@
	samtools flagstat $@

${BW}: $(BAM)
	mkdir -p $(dir $@)
	bamCoverage --binSize 1 --bam $< -o $@

$(PEAKS): $(BAM)
	macs3 callpeak --broad -g 3E8 --broad-cutoff 0.01 -n $(SAMPLE) -t ${BAM} -c ${BAM_BKG} --outdir peaks

peaks: $(PEAKS)
	@ls -lh $(PEAKS)

# Run all steps.
all: genome align 

# Visualize with IGV 
igv: 
	echo "new" | ${NC}
	echo "genome ${DIR}/$(FASTA)" | ${NC}
	echo "load ${DIR}/$(GFF)" | ${NC}
	# Loads up the coverage files for each sample.
	cat $(DESIGN) | $(PARALLEL) 'echo "load ${DIR}/bw/{sample}.bw" | ${NC}'

batch:
	cat $(DESIGN) | $(PARALLEL) make SRR={Run} SAMPLE=ATAC_{SampleName} all
	
# Remove some of the generated files.
clean:
	for dir in bam bw fastq peaks; do \
		if [ -d "$$dir" ]; then find "$$dir" -mindepth 1 -delete; fi; \
	done

.PHONY: usage all genome gff fastq index align clean peaks igv