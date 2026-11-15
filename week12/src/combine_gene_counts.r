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
output_file <- file.path(output_dir, "gene_counts.csv")

design <- read.csv(design_file, check.names = FALSE, stringsAsFactors = FALSE)
if (!"sample" %in% names(design)) {
  stop("design.csv must contain a 'sample' column.")
}

samples <- design$sample
if (length(samples) == 0L || anyNA(samples) || any(!nzchar(samples)) ||
    anyDuplicated(samples)) {
  stop("design.csv must contain unique, non-empty sample names.")
}

gene_ids <- NULL
sample_counts <- setNames(vector("list", length(samples)), samples)

for (sample in samples) {
  count_file <- file.path(counts_dir, paste0(sample, ".txt"))
  if (!file.exists(count_file)) {
    stop("Missing featureCounts file: ", count_file)
  }

  counts <- read.delim(
    count_file,
    header = TRUE,
    comment.char = "#",
    check.names = FALSE,
    stringsAsFactors = FALSE
  )
  if (!"Geneid" %in% names(counts)) {
    stop("No Geneid column in ", count_file)
  }

  count_columns <- which(basename(names(counts)) == paste0(sample, ".bam"))
  if (length(count_columns) != 1L) {
    stop("Expected one count column for ", sample, " in ", count_file)
  }

  current_ids <- counts$Geneid
  if (anyNA(current_ids) || anyDuplicated(current_ids)) {
    stop("Geneid values must be non-empty and unique in ", count_file)
  }
  if (is.null(gene_ids)) {
    gene_ids <- current_ids
  } else if (!setequal(gene_ids, current_ids)) {
    stop("Geneid values differ between featureCounts files (", sample, ").")
  }

  values <- suppressWarnings(as.numeric(counts[[count_columns]]))
  if (anyNA(values)) {
    stop("Non-numeric counts found in ", count_file)
  }
  sample_counts[[sample]] <- values[match(gene_ids, current_ids)]
}

gtf <- read.delim(
  gtf_file,
  header = FALSE,
  sep = "\t",
  comment.char = "#",
  quote = "",
  stringsAsFactors = FALSE
)
gene_rows <- gtf[gtf[[3]] == "gene", , drop = FALSE]

get_gtf_attribute <- function(attributes, key) {
  pattern <- paste0(key, ' "([^"]+)"')
  matches <- regmatches(attributes, regexec(pattern, attributes, perl = TRUE))
  values <- vapply(
    matches,
    function(match) if (length(match) >= 2L) match[[2]] else NA_character_,
    character(1)
  )
  if (anyNA(values)) {
    stop("Missing ", key, " attribute on one or more GTF gene records.")
  }
  values
}

annotation_ids <- get_gtf_attribute(gene_rows[[9]], "gene_id")
annotation_names <- get_gtf_attribute(gene_rows[[9]], "gene_name")
if (anyDuplicated(annotation_ids)) {
  stop("The GTF contains duplicate gene_id values.")
}

gene_names <- annotation_names[match(gene_ids, annotation_ids)]
if (anyNA(gene_names)) {
  stop("Could not find a gene_name in the GTF for every counted gene.")
}

result <- data.frame(
  gene = gene_ids,
  name = gene_names,
  as.data.frame(sample_counts, check.names = FALSE),
  check.names = FALSE
)
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
write.csv(result, output_file, row.names = FALSE)
message("Wrote ", nrow(result), " genes and ", length(samples),
        " sample columns to ", output_file)
