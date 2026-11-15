script_arg <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
if (length(script_arg) != 1L) {
  stop("Could not determine the script location.")
}

project_dir <- normalizePath(
  file.path(dirname(sub("^--file=", "", script_arg)), ".."),
  mustWork = TRUE
)
design_file <- file.path(project_dir, "design.csv")
matrix_file <- file.path(project_dir, "results", "gene_counts.csv")

design <- read.csv(design_file, check.names = FALSE, stringsAsFactors = FALSE)
if (!all(c("sample", "group") %in% names(design))) {
  stop("design.csv must contain 'sample' and 'group' columns.")
}
if (nrow(design) == 0L || anyNA(design$sample) || anyNA(design$group) ||
    any(!nzchar(design$sample)) || any(!nzchar(design$group)) ||
    anyDuplicated(design$sample)) {
  stop("design.csv must contain unique sample names and non-empty groups.")
}

counts <- read.csv(matrix_file, check.names = FALSE, stringsAsFactors = FALSE)
if (nrow(counts) == 0L) {
  stop("The gene count matrix contains no genes.")
}
if (!all(design$sample %in% names(counts))) {
  stop("The gene count matrix is missing one or more samples from design.csv.")
}

count_matrix <- as.matrix(counts[, design$sample, drop = FALSE])
storage.mode(count_matrix) <- "numeric"
if (anyNA(count_matrix) || any(!is.finite(count_matrix)) ||
    any(count_matrix < 0)) {
  stop("Gene counts must be finite, non-negative numeric values.")
}

groups <- unique(design$group)
group_means <- vapply(groups, function(group) {
  group_samples <- design$sample[design$group == group]
  rowMeans(count_matrix[, group_samples, drop = FALSE])
}, numeric(nrow(count_matrix)))
if (is.null(dim(group_means))) {
  group_means <- matrix(group_means, ncol = 1L, dimnames = list(NULL, groups))
}
colnames(group_means) <- groups

summary_rows <- rbind(
  "not expressed" = colSums(group_means == 0),
  expressed = colSums(group_means > 0)
)
bin_rows <- rbind(
  "0" = colSums(group_means == 0),
  "<1" = colSums(group_means > 0 & group_means < 1),
  "1-9" = colSums(group_means >= 1 & group_means < 10),
  "10-99" = colSums(group_means >= 10 & group_means < 100),
  "100-999" = colSums(group_means >= 100 & group_means < 1000),
  "1000+" = colSums(group_means >= 1000)
)

print_table <- function(values) {
  row_labels <- rownames(values)
  label_width <- max(nchar(row_labels))
  column_widths <- pmax(nchar(colnames(values)), nchar(as.character(values[1, ])))
  cat(strrep(" ", label_width + 1L))
  for (column in seq_len(ncol(values))) {
    cat(format(colnames(values)[column], width = column_widths[column],
               justify = "right"))
    if (column < ncol(values)) cat(" ")
  }
  cat("\n")

  for (row in seq_len(nrow(values))) {
    cat(format(row_labels[row], width = label_width, justify = "left"), " ")
    for (column in seq_len(ncol(values))) {
      cat(format(as.integer(values[row, column]),
                 width = column_widths[column], justify = "right"))
      if (column < ncol(values)) cat(" ")
    }
    cat("\n")
  }
}

print_table(summary_rows)
cat("\n")
print_table(bin_rows)
