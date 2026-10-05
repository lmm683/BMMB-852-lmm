# Week 6 - Evaluating Structural Variants
## Resources

Samples attained from [Biostar Handbook](https://www.biostarhandbook.com/courses/2026/appbio/work/evaluate-structural-variants/)

[IGV user guide](https://igv.org/doc/desktop/#UserGuide/tracks/alignments/paired_end_alignments/) was referenced 

## Assessment of Samples

### Samples 1 and 2

Samples 1 and 2 both have insertions of the same sizes at the same locations, with a 3 base insertion towards the beginning of the genome and a 1 base insertion towards the end of the genome. They also both have low coverage at the same base, base 7958, due to an indel. There are also sporatic larger and smaller than expected reads that are in the same places between the two, but Sample 2 is riddled with more (at least double the amount of) inconsistancies. Sample 2 also has a significant amount of low quality or mismatched bases, which could be due to the insertions, indel, greater inconsistency with expected read sizes causing frameshifts, but could also be due to a generally larger amount of point mutations. 

### Sample 3

Sample 3 has three duplications, between bases 1,606 and 5,934. This is also shown in the coverage display. I believe they are inversion duplications, since the duplicated area has a RL read. the middle section may have been duplicated twice, even, since the read coverage is about 3 times the amount of the normally covered areas. 

### Sample 4

Sample 4 has an inversion, between bases 4947 and 6387. This can be determined by looking at the orientation of the reads, there is a section of RR reads and a section of LL reads. These reads cover the same area and are roughly double the length of the other reads in the paired reads display, but when you unpair the reads they alternate sections in 4 different chunks. The ungrouped view also highly reflects IGV's paired end alignment guide

### Sample 5

Sample 5 has a translocation. I believe it is a translocation and not a complete deletion, because while a deletion is present, there is a RL read that covers the area where the deletion is indicated. Since there is a deletion indicated, that tells me that that section of the genome is lacking something in that area, but since the RL read is shown, it seems that the information for that section is present elsewhere, which is why there is still coverage for that area, it was just moved to a different spot in the genome. 