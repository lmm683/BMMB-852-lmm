# Name of the reference genome
GENOME_NAME = S.cerevisiae

# Genome fasta file
GENOME_FASTA = fna/$(GENOME_NAME).fna

# GFF annotation file
GFF = gff/$(GENOME_NAME).gff

# SRR accession number
SRR = SRR15292980

# Number of reads to download
N = 20000

# Fastq files
FASTQ_1 = fastq/$(SRR)_1.fastq
FASTQ_2 = fastq/$(SRR)_2.fastq

# Sample name 
SAMPLE_NAME = 10-F1

# BAM file derived from the sample name
BAM = bam/$(SAMPLE_NAME).bam

# BWA index sentinel
INDEX = $(GENOME_FASTA).bwt

# The output VCF file.
VCF=vcf/$(SAMPLE_NAME).vcf.gz

# Annotation parameters for the mpileup command
ANN=-d 100 --annotate 'INFO/AD,FORMAT/DP,FORMAT/AD,FORMAT/ADF,FORMAT/ADR,FORMAT/SP'

# Call parameters for the call command
CALL=--ploidy 2 --annotate 'FORMAT/GQ' 

# Current directory
DIR = $(shell pwd)

# Netcat command to send commands to IGV
NC = nc localhost 60151

# The name of the design file
DESIGN = SraRunInfo.csv

# The parallel command to run the workflow with
PARALLEL = parallel --colsep , --header : --eta --lb -j 4 


# --- All definitions above this line. All code below this line ---

usage:
	@echo "#"
	@echo "# Variant calling with bcftools"
	@echo "#"
	@echo "# GENOME_NAME=$(GENOME_NAME)"
	@echo "# GENOME_FASTA=$(GENOME_FASTA)"
	@echo "# SAMPLE_NAME=$(SAMPLE_NAME)"
	@echo "#"
	@echo "# DESIGN=$(DESIGN)"
	@echo "#"
	@echo "# SRR=$(SRR)"
	@echo "# N=$(N)"
	@echo "#"
	@echo "# BAM=$(BAM)"
	@echo "# VCF=$(VCF)"
	@echo "#"
	@echo "#" make all runs: 
	@echo "#"
	@echo "#" make genome
	@echo "#" make gff
	@echo "#" make strainadd
	@echo "#"
	@echo "#" To use a design file, use the following commands:
	@echo "#" 
	@echo "#" make batch
	@echo "#" make merge
	@echo "#"


# Download the genome.
genome: $(GENOME_FASTA)

$(GENOME_FASTA):
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
fastq: $(FASTQ_1) $(FASTQ_2)

$(FASTQ_1) $(FASTQ_2):
	mkdir -p $(dir $@)
	fastq-dump -X $(N) --split-files -O $(dir $@) $(SRR)
	seqkit stats $(FASTQ_1) $(FASTQ_2)

# Index the genome.
index: $(INDEX)

$(INDEX): $(GENOME_FASTA)
	bwa index $<

# Align the fastq files to the genome.
align: $(BAM)
	ls -lh $(BAM)

$(BAM): $(INDEX) $(FASTQ_1) $(FASTQ_2)
	mkdir -p $(dir $@)
	bwa mem $(GENOME_FASTA) $(FASTQ_1) $(FASTQ_2) | samtools sort -o $@
	samtools index $@
	samtools flagstat $@

# Call the variants.
call: $(VCF)
	ls -lh $(VCF)

# Create the VCF file
$(VCF): $(BAM) $(GENOME_FASTA)
	# Create the directory for the VCF file.
	mkdir -p $(dir $@)

	# Run the variant calling process.
	bcftools mpileup ${ANN} -O u -f $(GENOME_FASTA) $(BAM) | \
		bcftools call $(CALL) -mv -O u | \
		bcftools norm -f $(GENOME_FASTA) -d all -O u | \
		bcftools sort --write-index -O z -o $(VCF)

# Run all steps.
all: genome gff strainadd

# Visualize with IGV 
igv: fastq align ${BAM} $(GFF)
	echo "new" | ${NC}
	echo "genome ${DIR}/$(GENOME_FASTA)" | ${NC}
	echo "load ${DIR}/$(BAM)" | ${NC}
	echo "load ${DIR}/$(VCF)" | ${NC}
	echo "load ${DIR}/$(GFF)" | ${NC}
	
# Manually add a new strain's fastq, bam, and vcf
strainadd: fastq index align call

# Batch processing using the design file.
batch: 
	cat $(DESIGN) | $(PARALLEL) make \
        SRR={Run} \
        SAMPLE_NAME={SampleName} \
        strainadd

# Merge VCF files from multiple samples into a single VCF file.
merge:
	bcftools merge --write-index -O z -o vcf/merged-VCF.vcf.gz vcf/*.vcf.gz
	
	bcftools mpileup -d 100 --annotate 'INFO/AD,FORMAT/DP,FORMAT/AD,FORMAT/ADF,FORMAT/ADR,FORMAT/SP' -O u -f fna/S.cerevisiae.fna \
    	bam/*.bam | \
    	bcftools call --ploidy 1 --annotate 'FORMAT/GQ' -mv -O u | \
    	bcftools norm -f fna/S.cerevisiae.fna -d all -O u | \
    	bcftools sort --write-index -O z -o vcf/merged-BAM.vcf.gz


# Remove some of the generated files.
clean:
	rm -f fastq/*.fastq bam/*.bam bam/*.bai vcf/*.vcf.gz vcf/*.tbi vcf/*.csi

.PHONY: usage all genome fastq index align clean call igv strainadd gff
