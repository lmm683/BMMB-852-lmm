script_arg <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
if (length(script_arg) != 1L) {
  stop("Could not determine the script location.")
}

project_dir <- normalizePath(
  file.path(dirname(sub("^--file=", "", script_arg)), ".."),
  mustWork = TRUE
)
design_file <- file.path(project_dir, "design.csv")
gene_matrix_file <- file.path(project_dir, "results", "gene_counts.csv")
transcript_matrix_file <- file.path(project_dir, "results", "transcript_counts.csv")
gtf_file <- file.path(project_dir, "gtf", "chr22.gtf")
output_file <- file.path(
  project_dir,
  "results",
  "UHR_vs_HBR_expression_summary.csv"
)

design <- read.csv(design_file, check.names = FALSE, stringsAsFactors = FALSE)
if (!all(c("sample", "group") %in% names(design))) {
  stop("design.csv must contain 'sample' and 'group' columns.")
}
if (nrow(design) == 0L || anyNA(design$sample) || anyNA(design$group) ||
    any(!nzchar(design$sample)) || any(!nzchar(design$group)) ||
    anyDuplicated(design$sample)) {
  stop("design.csv must contain unique sample names and non-empty groups.")
}
if (!all(c("HBR", "UHR") %in% design$group)) {
  stop("design.csv must contain both HBR and UHR groups.")
}

gene_counts <- read.csv(
  gene_matrix_file,
  check.names = FALSE,
  stringsAsFactors = FALSE
)
transcript_counts <- read.csv(
  transcript_matrix_file,
  check.names = FALSE,
  stringsAsFactors = FALSE
)
if (!all(c("gene", "name", design$sample) %in% names(gene_counts))) {
  stop("The gene matrix must contain gene, name, and all design sample columns.")
}
if (!all(c("transcript", design$sample) %in% names(transcript_counts))) {
  stop("The transcript matrix must contain transcript and all design sample columns.")
}
if (anyDuplicated(gene_counts$gene) || anyDuplicated(transcript_counts$transcript)) {
  stop("Gene and transcript IDs must be unique in their count matrices.")
}

read_count_matrix <- function(data, columns, label) {
  values <- as.matrix(data[, columns, drop = FALSE])
  storage.mode(values) <- "numeric"
  if (anyNA(values) || any(!is.finite(values)) || any(values < 0)) {
    stop(label, " must contain finite, non-negative counts.")
  }
  values
}

genome_samples <- read_count_matrix(gene_counts, design$sample, "Gene counts")
transcript_samples <- read_count_matrix(
  transcript_counts,
  design$sample,
  "Transcript counts"
)

gtf <- read.delim(
  gtf_file,
  header = FALSE,
  sep = "\t",
  comment.char = "#",
  quote = "",
  stringsAsFactors = FALSE
)
transcript_rows <- gtf[gtf[[3]] == "transcript", , drop = FALSE]

get_gtf_attribute <- function(attributes, key) {
  pattern <- paste0(key, ' "([^"]+)"')
  matches <- regmatches(attributes, regexec(pattern, attributes, perl = TRUE))
  values <- vapply(
    matches,
    function(match) if (length(match) >= 2L) match[[2]] else NA_character_,
    character(1)
  )
  if (anyNA(values)) {
    stop("Missing ", key, " attribute on one or more GTF transcript records.")
  }
  values
}

annotation_transcripts <- get_gtf_attribute(transcript_rows[[9]], "transcript_id")
annotation_genes <- get_gtf_attribute(transcript_rows[[9]], "gene_id")
if (anyDuplicated(annotation_transcripts)) {
  stop("The GTF contains duplicate transcript_id values.")
}

transcript_gene <- annotation_genes[
  match(transcript_counts$transcript, annotation_transcripts)
]
if (anyNA(transcript_gene)) {
  stop("Could not map every quantified transcript to a gene in the GTF.")
}

transcript_gene_samples <- rowsum(
  transcript_samples,
  group = transcript_gene,
  reorder = FALSE
)
transcript_gene_samples <- transcript_gene_samples[
  match(gene_counts$gene, rownames(transcript_gene_samples)),
  ,
  drop = FALSE
]
rownames(transcript_gene_samples) <- gene_counts$gene
transcript_gene_samples[is.na(transcript_gene_samples)] <- 0

group_mean <- function(values, group) {
  samples <- design$sample[design$group == group]
  rowMeans(values[, samples, drop = FALSE])
}

genome_hbr <- group_mean(genome_samples, "HBR")
genome_uhr <- group_mean(genome_samples, "UHR")
transcript_hbr <- group_mean(transcript_gene_samples, "HBR")
transcript_uhr <- group_mean(transcript_gene_samples, "UHR")

result <- data.frame(
  gene = gene_counts$gene,
  name = gene_counts$name,
  genome_HBR = genome_hbr,
  genome_UHR = genome_uhr,
  genome_UHR_minus_HBR = genome_uhr - genome_hbr,
  transcript_HBR = transcript_hbr,
  transcript_UHR = transcript_uhr,
  transcript_UHR_minus_HBR = transcript_uhr - transcript_hbr,
  check.names = FALSE
)

sort_order <- order(
  -pmax(
    abs(result$genome_UHR_minus_HBR),
    abs(result$transcript_UHR_minus_HBR)
  ),
  result$gene
)
result <- result[sort_order, , drop = FALSE]

write.csv(result, output_file, row.names = FALSE)
message("Wrote expression comparisons for ", nrow(result),
        " genes to ", output_file)
