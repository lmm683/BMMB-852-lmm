SHELL := /bin/bash

ACCESSION := SRR12618190
FASTQ_DIR := fastq
READS_STAMP := $(FASTQ_DIR)/.$(ACCESSION).downloaded
STATS_FILE := $(FASTQ_DIR)/Z.balii_stats.txt
FASTQC_STAMP := $(FASTQ_DIR)/.$(ACCESSION).fastqc.done
RAW_R1 := $(FASTQ_DIR)/$(ACCESSION)_1.fastq
RAW_R2 := $(FASTQ_DIR)/$(ACCESSION)_2.fastq
TRIMMED_R1 := $(FASTQ_DIR)/$(ACCESSION)_1.trimmed.fastq
TRIMMED_R2 := $(FASTQ_DIR)/$(ACCESSION)_2.trimmed.fastq
BROWSER ?= xdg-open

.PHONY: all reads stats fastqc trim open opentrim clean

all: fastqc

$(READS_STAMP):
	@command -v fastq-dump >/dev/null || { echo "fastq-dump is required." >&2; exit 1; }
	@mkdir -p "$(FASTQ_DIR)"
	fastq-dump -X 1000 -F --outdir "$(FASTQ_DIR)" --split-files "$(ACCESSION)"
	@touch "$@"

reads: $(READS_STAMP)

$(STATS_FILE): $(READS_STAMP)
	@command -v seqkit >/dev/null || { echo "seqkit is required." >&2; exit 1; }
	seqkit stats $(FASTQ_DIR)/$(ACCESSION)*.fastq > "$@"

stats: $(STATS_FILE)
	@cat "$(STATS_FILE)"

$(FASTQC_STAMP): $(STATS_FILE)
	@command -v fastqc >/dev/null || { echo "fastqc is required." >&2; exit 1; }
	fastqc $(FASTQ_DIR)/$(ACCESSION)*.fastq --outdir "$(FASTQ_DIR)"
	@instance=1; for report in "$(FASTQ_DIR)"/*_fastqc.html; do test -e "$$report" || continue; filetype=$${report##*.}; mv "$$report" "$(FASTQ_DIR)/FastQC_Report_Z.balii_$${instance}.$$filetype"; instance=$$((instance + 1)); done
	@touch "$@"
	@rm -f "$(FASTQ_DIR)"/*_fastqc.zip "$(READS_STAMP)" "$(FASTQC_STAMP)"

fastqc: $(FASTQC_STAMP)

trim: $(RAW_R1) $(RAW_R2)
	@command -v fastp >/dev/null || { echo "fastp is required." >&2; exit 1; }
	@command -v fastqc >/dev/null || { echo "fastqc is required." >&2; exit 1; }
	fastp --in1 "$(RAW_R1)" --in2 "$(RAW_R2)" --out1 "$(TRIMMED_R1)" --out2 "$(TRIMMED_R2)" --average_qual 34 --qualified_quality_phred 34 --html "$(FASTQ_DIR)/fastp.trimmed.html" --json /dev/null
	fastqc "$(TRIMMED_R1)" "$(TRIMMED_R2)" --outdir "$(FASTQ_DIR)"
	@instance=1; for report in "$(FASTQ_DIR)"/*trimmed_fastqc.html; do test -e "$$report" || continue; filetype=$${report##*.}; mv "$$report" "$(FASTQ_DIR)/FastQC_Report_Z.balii_trimmed_$${instance}.$$filetype"; instance=$$((instance + 1)); done
	@rm -f "$(FASTQ_DIR)"/*trimmed_fastqc.zip

open: fastqc
	@command -v "$(BROWSER)" >/dev/null || { echo "Browser opener '$(BROWSER)' is required." >&2; exit 1; }
	@for report in "$(FASTQ_DIR)"/*.html; do test -e "$$report" || continue; "$(BROWSER)" "$$report" >/dev/null 2>&1 & done

opentrim: trim
	@command -v "$(BROWSER)" >/dev/null || { echo "Browser opener '$(BROWSER)' is required." >&2; exit 1; }
	@reports=$$(find "$(FASTQ_DIR)" -maxdepth 1 -type f -name 'FastQC_Report_Z.balii_trimmed_*.html' -print); test -n "$$reports" || { echo "Trimmed FastQC reports were not found." >&2; exit 1; }; while IFS= read -r report; do "$(BROWSER)" "$$report" >/dev/null 2>&1 & done <<< "$$reports"

clean:
	rm -rf "$(FASTQ_DIR)"
