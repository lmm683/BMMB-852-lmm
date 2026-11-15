# Week 12 Assignment - Generate a Count Matrix

## Running The Scripts

```bash
# Start with these following commands
    # Index the genome, generating fasta, fastq, and gtf files
    make -f GenomeBased.mk index
    # Align each sample, generating bam, bw, and counts files
    make -f GenomeBased.mk batch
    # Generate Salmon transcript counts quant.sf files
    make -f TranscriptomeBased.mk batch

# Combine featureCounts gene counts and generate the gene_counts.csv
Rscript src/combine_gene_counts.r

# View the gene_counts.csv
xan view results/gene_counts.csv

# Display a summary of gene expression by group
Rscript src/summarize_gene_counts.r

# Create the transcript count matrix and generate the transcript_counts.csv
Rscript src/summarize_transcript_counts.r

# View the transcript_counts.csv
xan view results/transcript_counts.csv

# Display a comparison of genome and transcript gene counts
Rscript src/compare_gene_counts.r

# Compare UHR and HBR expression and generate the UHR_vs_HBR_expression_summary.csv
Rscript src/compare_group_expression.r

# View expression differences between UHR and HBR
xan select name,genome_UHR_minus_HBR,transcript_UHR_minus_HBR results/UHR_vs_HBR_expression_summary.csv | xan view --limit 99

# View compared expression results for a specific gene (replace NAME with a gene name)
xan filter 'name eq "NAME"' results/UHR_vs_HBR_expression_summary.csv | xan select name,genome_UHR_minus_HBR,transcript_UHR_minus_HBR | xan view
```

## Experience of Coding This With AI

I did not have too difficult of a time using the AI assistant to code these scripts and verify them. I am using VS code for everything, and their AI assistant system is quite reliable and nicely integrated into the workspace, allowing for easy fixes by prompting changes and help with errors.

The biggest thing I use the assistant for, besides generating code I do not know how to write, is finding and correcting errors. I think the most challenging part of using AI is if the AI formats something differently from how I wanted it, forgets or misplaces a value (like the gene name in this assignment), or if it wants to use a different coding language I don't want it to use. On multiple occasions, the AI has wanted to use python to code something instead of linux, which leads me to remind it to stay within linux commands. 