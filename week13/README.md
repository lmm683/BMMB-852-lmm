# Week 13 Assignment - Evaluate Simulations

## Simulation Results

### First simulation Results

simulated_deseq2_classified.csv 
Confusion matrix (FDR < 0.05)
TP: 68
FP: 14
TN: 2698
FN: 72

simulated_edger_classified.csv 
Confusion matrix (FDR < 0.05)
TP: 62
FP: 6
TN: 2118
FN: 51

### Second simulation Results

simulated_deseq2_classified.csv 
Confusion matrix (FDR < 0.05)
TP: 72
FP: 11
TN: 2599
FN: 73

simulated_edger_classified.csv 
Confusion matrix (FDR < 0.05)
TP: 62
FP: 6
TN: 2118
FN: 51

## Commands

### Makefile Commands

```bash
# Download the simulated counts
make download

# Run deseq2 on the simulated counts and classify the results
make deseq

# Run edger on the simulated counts and classify the results
make edger

# Display the deseq2 results in a table
make deseqsummary

# Display the edger results in a table
make edgersummary

# Display the deseq2 results in a table using xan
make deseqxan

# Display the edger results in a table using xan
make edgerxan

# Run all the steps in order (download deseq edger deseqsummary edgersummary)
make all
```

### Raw Commands

```bash
Rscript src/deseq2.r -d simulated_design.csv -c simulated_counts.csv --output simulated_deseq2.csv

Rscript src/classify_simulated_edger.r simulated_deseq2.csv simulated_deseq2_classified.csv

xan view simulated_deseq2_classified.csv -s id,status,filter,FDR,classification

CSVNAME=simulated_deseq2_classified.csv
Rscript -e 'd <- read.csv(commandArgs(TRUE)[1]); n <- table(factor(d$classification, levels=c("TP","FP","TN","FN"))); print(data.frame(category=names(n), count=as.integer(n), percent=round(100*as.integer(n)/nrow(d), 2)))' "$CSVNAME"

xan search 'GENE-1511' simulated_deseq2_classified.csv | xan view -s id,status,filter,FDR,A1,A2,A3,B1,B2,B3,classification

Rscript src/edger.r -c simulated_counts.csv -d simulated_design.csv --output simulated_edger.csv

Rscript src/classify_simulated_edger.r simulated_edger.csv simulated_edger_classified.csv

xan view simulated_edger_classified.csv -s id,status,filter,FDR,classification

CSVNAME=simulated_edger_classified.csv
Rscript -e 'd <- read.csv(commandArgs(TRUE)[1]); n <- table(factor(d$classification, lev
els=c("TP","FP","TN","FN"))); print(data.frame(category=names(n), count=as.integer(n), p
ercent=round(100*as.integer(n)/nrow(d), 2)))' "$CSVNAME"

xan search 'GENE-1511' simulated_edger_classified.csv | xan view -s id,status,filter,FDR,A1,A2,A3,B1,B2,B3,classification
```

## Comments

### Accuracy

It seems like deseq2 has higher variation and is not the same when I rerun the simulation, while edger has lower variation, being the same between the two simulation runs. Therefore I would say edger is probably more accurate than deseq2. Between the two methods, the percentage of each category (TP,FP,TN, and FN) remains roughly the same, although deseq2 has a larger number of counts overall in comparison to edger. When it comes down to it, however, I still believe edger is more accurate. If you break down the ratio of TP to FP individually, edger's TP to FP is 10.3:1 while deseq2's average is 5.6:1. That's roughly twice as many false positives in deseq2 as in edger. The TN to FN ratio isn't better, with edger having a 41.5:1 and deseq2 having an average of 36.5:1. This means that deseq2 spits out more errors than edger does and has more variability than edger in general. 

### Gene Examples

┌───┬───────────┬─────────┬────────┬────────┬──────┬──────┬──────┬────┬──────┬──────┬────────────────┐
│ - │ id        │ status  │ filter │ FDR    │ A1   │ A2   │ A3   │ B1 │ B2   │ B3   │ classification │
├───┼───────────┼─────────┼────────┼────────┼──────┼──────┼──────┼────┼──────┼──────┼────────────────┤
│ 0 │ GENE-1511 │ changed │ pass   │ 0.2011 │ 40.2 │ 49.3 │ 45.5 │ 30 │ 27.2 │ 27.7 │ FN             │
└───┴───────────┴─────────┴────────┴────────┴──────┴──────┴──────┴────┴──────┴──────┴────────────────┘
Gene-1511 is considered a false negative (by edger and deseq2) since even though it looks like there was a change, the FDR is higher than 0.05 and therefore cannot be significantly considered a change. Deseq2 has an even higher FDR for this gene as well, despite showing a similar range of expression for A and B that edger shows.

┌───┬───────────┬───────────┬────────┬───────────┬────┬────┬────┬──────┬──────┬──────┬────────────────┐
│ - │ id        │ status    │ filter │ FDR       │ A1 │ A2 │ A3 │ B1   │ B2   │ B3   │ classification │
├───┼───────────┼───────────┼────────┼───────────┼────┼────┼────┼──────┼──────┼──────┼────────────────┤
│ 0 │ GENE-2246 │ unchanged │ pass   │ 0.0009453 │  0 │  0 │  1 │ 56.1 │ 28.2 │ 28.7 │ FP             │
└───┴───────────┴───────────┴────────┴───────────┴────┴────┴────┴──────┴──────┴──────┴────────────────┘
Gene-2246 is considered a false positive (by edger and deseq) since even though it was considered unchanged, the FDR is much lower than 0.05. It is strange to me that this was not picked up because of the drastic 0 to 56 or 28 expression levels, but it seems like with these programs, if there are zeros on A or B, the program considers it unchanged. 

┌───┬───────────┬───────────┬────────┬─────────┬───────┬───────┬───────┬────────┬────────┬────────┬────────────────┐
│ - │ id        │ status    │ filter │ FDR     │ A1    │ A2    │ A3    │ B1     │ B2     │ B3     │ classification │
├───┼───────────┼───────────┼────────┼─────────┼───────┼───────┼───────┼────────┼────────┼────────┼────────────────┤
│ 0 │ GENE-7054 │ unchanged │ pass   │ 0.01108 │ 563.4 │ 509.3 │ 367.2 │ 1395.2 │ 1157.6 │ 1145.2 │ FP             │
└───┴───────────┴───────────┴────────┴─────────┴───────┴───────┴───────┴────────┴────────┴────────┴────────────────┘
Gene-7054 is another false positive (by edger and deseq2), although it was once again strangely considered to be unchanged, given the drastic differences in expression levels between A and B. Maybe because the expression is high regardless it didn't register to the system as changed? What's interesting though is that the FDR for edger is 0.011 while the FDR for deseq2 is 3.1e-07, which is MUCH smaller than the FDR for edger. 

### Potential Performance Score Formulas

I think that the ratio of TP to FP should never be higher than 10:1, meaning that the amount of FPs should never be higher than 10% of the amount of TPs. Edger passes this requirement while deseq2 does not.

Furthermore, I think that the ratio of TN to FN should never be higher than 33:1, meaning that the amount of FNs should never be higher than 3% of the amount of TNs. Both edger and deseq2 pass this requirement.