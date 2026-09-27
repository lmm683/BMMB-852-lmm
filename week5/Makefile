# URL of the reference genome
FASTA_URL = http://ftp.ensemblgenomes.org/pub/fungi/release-63/fasta/fungi_ascomycota1_collection/zygosaccharomyces_bailii_isa1307_gca_000530735/dna/Zygosaccharomyces_bailii_isa1307_gca_000530735.Z_bailii_ISA1307_version_3.dna.toplevel.fa.gz

# Name of the reference genome
GENOME_NAME = Zygosaccharomyces_bailii_ISA1307

# Genome fasta file
GENOME_FASTA = fasta/$(GENOME_NAME).fasta

# SRR accession number
SRR=SRR12618190

# Number of reads to download
N = 813121

# Fastq files
FASTQ_1 = fastq/$(SRR)_1.fastq
FASTQ_2 = fastq/$(SRR)_2.fastq

# Sample name (must not contain spaces)
SAMPLE_NAME = DAOMC_209005

# BAM file derived from the sample name
BAM = bam/$(SAMPLE_NAME).bam

# BWA index sentinel
INDEX = $(GENOME_FASTA).bwt

usage:
	@echo " # Read the source code"

# Run all steps.
all: genome fastq index align

# Download the genome.
genome: $(GENOME_FASTA)

$(GENOME_FASTA):
	mkdir -p $(dir $@)
	curl -fsSL $(FASTA_URL) | gunzip > $@
	seqkit stats $@

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

$(BAM): $(INDEX) $(FASTQ_1) $(FASTQ_2)
	mkdir -p $(dir $@)
	bwa mem $(GENOME_FASTA) $(FASTQ_1) $(FASTQ_2) | samtools sort -o $@
	samtools index $@
	samtools flagstat $@

# Display BAM summary
stats: $(BAM)
	samtools flagstat $(BAM)

# Remove some of the generated files.
clean:
	rm -rf $(FASTQ_1) $(FASTQ_2) $(BAM) $(BAM).bai

# Removes all generated files.
cleanall: clean
	rm -rf $(GENOME_FASTA) $(INDEX)

.PHONY: usage all genome fastq index align clean cleanall stats