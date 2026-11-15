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

design <- read.csv(design_file, check.names = FALSE, stringsAsFactors = FALSE)
if (!all(c("sample", "group") %in% names(design))) {
  stop("design.csv must contain 'sample' and 'group' columns.")
}
if (nrow(design) == 0L || anyNA(design$sample) || anyNA(design$group) ||
    any(!nzchar(design$sample)) || any(!nzchar(design$group)) ||
    anyDuplicated(design$sample)) {
  stop("design.csv must contain unique sample names and non-empty groups.")
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
shared_genes <- gene_counts$gene[gene_counts$gene %in% rownames(transcript_gene_samples)]
if (length(shared_genes) == 0L) {
  stop("No genes are shared between the gene and transcript count matrices.")
}

genome_by_group <- vapply(unique(design$group), function(group) {
  rowMeans(genome_samples[
    match(shared_genes, gene_counts$gene),
    design$sample[design$group == group],
    drop = FALSE
  ])
}, numeric(length(shared_genes)))
transcript_by_group <- vapply(unique(design$group), function(group) {
  rowMeans(transcript_gene_samples[
    shared_genes,
    design$sample[design$group == group],
    drop = FALSE
  ])
}, numeric(length(shared_genes)))

groups <- unique(design$group)
if (is.null(dim(genome_by_group))) {
  genome_by_group <- matrix(genome_by_group, ncol = 1L, dimnames = list(NULL, groups))
  transcript_by_group <- matrix(
    transcript_by_group,
    ncol = 1L,
    dimnames = list(NULL, groups)
  )
}
colnames(genome_by_group) <- groups
colnames(transcript_by_group) <- groups
rownames(genome_by_group) <- shared_genes
rownames(transcript_by_group) <- shared_genes

comparison <- do.call(rbind, lapply(seq_along(groups), function(column) {
  genome <- genome_by_group[, column]
  transcript <- transcript_by_group[, column]
  abs_error <- abs(genome - transcript)
  rel_error <- ifelse(
    genome == 0 & transcript == 0,
    0,
    abs_error / ((genome + transcript) / 2)
  )
  data.frame(
    gene = shared_genes,
    name = gene_counts$name[match(shared_genes, gene_counts$gene)],
    group = groups[column],
    genome = genome,
    transcript = transcript,
    abs_error = abs_error,
    rel_error = rel_error,
    stringsAsFactors = FALSE
  )
}))

summary_rows <- lapply(groups, function(group) {
  group_comparison <- comparison[comparison$group == group, , drop = FALSE]
  data.frame(
    group = group,
    genes = nrow(group_comparison),
    mean_abs_error = mean(group_comparison$abs_error),
    median_abs_error = median(group_comparison$abs_error),
    mean_rel_error = mean(group_comparison$rel_error),
    median_rel_error = median(group_comparison$rel_error)
  )
})
summary_table <- do.call(rbind, summary_rows)

cat("# abs error = |genome - transcript|\n")
cat("# rel error = abs error / mean(genome, transcript); 0 when both are 0\n")
summary_output <- rbind(
  genes = summary_table$genes,
  "mean abs error" = sprintf("%.2f", summary_table$mean_abs_error),
  "median abs error" = sprintf("%.2f", summary_table$median_abs_error),
  "mean rel error" = sprintf("%.2f", summary_table$mean_rel_error),
  "median rel error" = sprintf("%.2f", summary_table$median_rel_error)
)
colnames(summary_output) <- groups
print(noquote(summary_output), quote = FALSE, right = TRUE)

top_comparison <- comparison[
  comparison$genome > 0 | comparison$transcript > 0,
  ,
  drop = FALSE
]
top_comparison <- top_comparison[
  order(-top_comparison$abs_error, top_comparison$gene, top_comparison$group),
  ,
  drop = FALSE
]
top_comparison <- head(top_comparison, 8L)

cat("\n# Most dissimilar expression levels\n")
top_output <- data.frame(
  gene = top_comparison$gene,
  name = top_comparison$name,
  group = top_comparison$group,
  genome = sprintf("%.2f", top_comparison$genome),
  transcript = sprintf("%.2f", top_comparison$transcript),
  abs_error = sprintf("%.2f", top_comparison$abs_error),
  rel_error = sprintf("%.2f", top_comparison$rel_error),
  check.names = FALSE
)
print(top_output, row.names = FALSE, right = TRUE)
