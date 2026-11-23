#!/usr/bin/env Rscript

script_arg <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
if (length(script_arg) != 1L) {
  stop("Could not determine the script location.")
}

project_dir <- normalizePath(
  file.path(dirname(sub("^--file=", "", script_arg)), ".."),
  mustWork = TRUE
)
sim_dir <- file.path(project_dir, "sim1")
args <- commandArgs(trailingOnly = TRUE)
if (length(args) > 2L) {
  stop("Usage: Rscript classify_simulated_edger.r [input.csv] [output.csv]")
}

input_file <- if (length(args) >= 1L) {
  args[1]
} else {
  file.path(sim_dir, "simulated_edger.csv")
}
output_file <- if (length(args) >= 2L) {
  args[2]
} else {
  file.path(sim_dir, "simulated_edger_classified.csv")
}

results <- read.csv(
  input_file,
  check.names = FALSE,
  stringsAsFactors = FALSE
)
required_columns <- c("id", "status", "FDR")
if (!all(required_columns %in% names(results))) {
  stop("Input must contain id, status, and FDR columns.")
}
if (nrow(results) == 0L || anyNA(results$id) ||
    any(!nzchar(results$id)) || anyDuplicated(results$id)) {
  stop("Input must contain unique, non-empty gene IDs.")
}
if (anyNA(results$status) ||
    any(!results$status %in% c("changed", "unchanged"))) {
  stop("The status column must contain only 'changed' or 'unchanged'.")
}
if (!is.numeric(results$FDR) || anyNA(results$FDR) ||
    any(!is.finite(results$FDR)) ||
    any(results$FDR < 0 | results$FDR > 1)) {
  stop("The FDR column must contain finite values between 0 and 1.")
}

significant <- results$FDR < 0.05
results$classification <- ifelse(
  results$status == "changed",
  ifelse(significant, "TP", "FN"),
  ifelse(significant, "FP", "TN")
)

counts <- table(factor(results$classification, levels = c("TP", "FP", "TN", "FN")))
output_dir <- dirname(output_file)
if (!dir.exists(output_dir) &&
    !dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)) {
  stop("Could not create output directory: ", output_dir)
}
write.csv(results, output_file, row.names = FALSE, quote = FALSE)
cat("# Saved classified results to:", output_file, "\n")

cat("# Confusion matrix (FDR < 0.05)\n")
for (label in names(counts)) {
  cat(sprintf("# %s: %d\n", label, counts[[label]]))
}
