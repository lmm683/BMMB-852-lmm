# Assessment of a student's repository

I am reviewing Susan Sharpe's repository: [appbio-2026](repository/README.md).

## Security Check

I inspected the Week 02 Makefile and README instructions. The workflow downloads FASTA and GFF3 files from NCBI E-utilities with `curl`; it does not execute downloaded files. The URLs point to NCBI, a trusted source for this assignment.

The `clean` target removes only the local `fasta/` and `gff/` directories. That is appropriate for a disposable data-download directory, but users should understand that it deletes downloaded data.

## README Evaluation

The README clearly identifies the TMV accession, explains genome completeness, documents the expected output files, and records the IGV observations. The embedded reading-frame images make the visualization result easy to inspect.

The Makefile is concise and reproducible. It creates separate output directories, uses explicit accession-based filenames, and uses `curl --fail --location --retry 3`. The main improvement I would suggest is adding a small `count` target for the GFF3 feature count described in the README, so the documented check is also available through `make`.

## Comparison With My Work

Susan's workflow is shorter and easier to read than a workflow that includes unnecessary intermediate archive files. The variables are grouped clearly, and the output paths are predictable. The README also explains the biological interpretation rather than only recording commands.

## Proposed Edits

- Add a Makefile target that counts non-comment GFF3 features.
- Add a short message when downloaded files already exist and no work is needed.
- Keep the existing trusted-source URLs and failed-download handling.

## Pull Request

I would submit these suggestions as a pull request to the forked repository after confirming the proposed Makefile changes. No pull request was created as part of this local review.
