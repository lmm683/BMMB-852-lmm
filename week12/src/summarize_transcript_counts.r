script_arg <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
if (length(script_arg) != 1L) {
  stop("Could not determine the script location.")
}

project_dir <- normalizePath(
  file.path(dirname(sub("^--file=", "", script_arg)), ".."),
  mustWork = TRUE
)
design_file <- file.path(project_dir, "design.csv")
counts_dir <- file.path(project_dir, "counts")
gtf_file <- file.path(project_dir, "gtf", "chr22.gtf")
output_dir <- file.path(project_dir, "results")
output_file <- file.path(output_dir, "transcript_counts.csv")

design <- read.csv(design_file, check.names = FALSE, stringsAsFactors = FALSE)
if (!"sample" %in% names(design)) {
  stop("design.csv must contain a 'sample' column.")
}

samples <- design$sample
if (length(samples) == 0L || anyNA(samples) || any(!nzchar(samples)) ||
    anyDuplicated(samples)) {
  stop("design.csv must contain unique, non-empty sample names.")
}

transcript_ids <- NULL
sample_counts <- setNames(vector("list", length(samples)), samples)

for (sample in samples) {
  quant_file <- file.path(counts_dir, sample, "quant.sf")
  if (!file.exists(quant_file)) {
    stop("Missing Salmon quantification file: ", quant_file)
  }

  quant <- read.delim(
    quant_file,
    header = TRUE,
    check.names = FALSE,
    stringsAsFactors = FALSE
  )
  if (!all(c("Name", "NumReads") %in% names(quant))) {
    stop("Expected Name and NumReads columns in ", quant_file)
  }
  if (anyNA(quant$Name) || any(!nzchar(quant$Name)) ||
      anyDuplicated(quant$Name)) {
    stop("Transcript IDs must be non-empty and unique in ", quant_file)
  }

  if (is.null(transcript_ids)) {
    transcript_ids <- quant$Name
  } else if (!setequal(transcript_ids, quant$Name)) {
    stop("Transcript IDs differ between Salmon files (", sample, ").")
  }

  values <- suppressWarnings(as.numeric(quant$NumReads))
  if (anyNA(values) || any(!is.finite(values)) || any(values < 0)) {
    stop("NumReads must contain finite, non-negative counts in ", quant_file)
  }
  sample_counts[[sample]] <- values[match(transcript_ids, quant$Name)]
}

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

annotation_ids <- get_gtf_attribute(transcript_rows[[9]], "transcript_id")
annotation_names <- get_gtf_attribute(transcript_rows[[9]], "gene_name")
if (anyDuplicated(annotation_ids)) {
  stop("The GTF contains duplicate transcript_id values.")
}

gene_names <- annotation_names[match(transcript_ids, annotation_ids)]
if (anyNA(gene_names)) {
  stop("Could not find a gene_name in the GTF for every quantified transcript.")
}

result <- data.frame(
  transcript = transcript_ids,
  gene_name = gene_names,
  as.data.frame(sample_counts, check.names = FALSE),
  check.names = FALSE
)
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
write.csv(result, output_file, row.names = FALSE)
message("Wrote ", nrow(result), " transcripts and ", length(samples),
        " sample columns to ", output_file)
