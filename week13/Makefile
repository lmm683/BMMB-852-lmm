# Download the simulated counts
download:
	mkdir -p src
	
	curl -fsSL https://data.biostarhandbook.com/rscript/simulate_counts.2026.r > \
	src/simulate_counts.r

	Rscript src/simulate_counts.r

# Run deseq2 on the simulated counts and classify the results
deseq:
	Rscript src/deseq2.r -d simulated_design.csv -c simulated_counts.csv --output simulated_deseq2.csv

	Rscript src/classify_simulated_edger.r simulated_deseq2.csv simulated_deseq2_classified.csv

# Run edger on the simulated counts and classify the results
edger:
	Rscript src/edger.r -c simulated_counts.csv -d simulated_design.csv --output simulated_edger.csv

	Rscript src/classify_simulated_edger.r simulated_edger.csv simulated_edger_classified.csv

# Display the deseq2 results in a table
deseqsummary:
	Rscript -e 'd <- read.csv(commandArgs(TRUE)[1]); n <- table(factor(d$$classification, levels=c("TP","FP","TN","FN"))); print(data.frame(category=names(n), count=as.integer(n), percent=round(100*as.integer(n)/nrow(d), 2)))' simulated_deseq2_classified.csv

# Display the edger results in a table
edgersummary:
	Rscript -e 'd <- read.csv(commandArgs(TRUE)[1]); n <- table(factor(d$$classification, levels=c("TP","FP","TN","FN"))); print(data.frame(category=names(n), count=as.integer(n), percent=round(100*as.integer(n)/nrow(d), 2)))' simulated_edger_classified.csv

# Display the deseq2 results in a table using xan
deseqxan:
	xan view simulated_deseq2_classified.csv -s id,status,filter,FDR,classification

# Display the edger results in a table using xan
edgerxan:
	xan view simulated_edger_classified.csv -s id,status,filter,FDR,classification

# Run all the steps in order
all: download deseq edger deseqsummary edgersummary
