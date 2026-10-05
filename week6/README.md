# Week 6 - Evaluating Structural Variants
## Resources

Samples attained from [Biostar Handbook](https://www.biostarhandbook.com/courses/2026/appbio/work/evaluate-structural-variants/)

[IGV user guide](https://igv.org/doc/desktop/#UserGuide/tracks/alignments/paired_end_alignments/) was referenced 

## Assessment of Samples

### Samples 1 and 2

Samples 1 and 2 both have insertions of the same sizes at the same locations, with a 3 base insertion towards the beginning of the genome and a 1 base insertion towards the end of the genome. They also both have low coverage at the same base, base 7958, due to an indel. There are also sporatic larger and smaller than expected reads that are in the same places between the two, but Sample 2 is riddled with more (at least double the amount of) inconsistancies. Sample 2 also has a significant amount of low quality or mismatched bases, which could be due to the insertions, indel, greater inconsistency with expected read sizes causing frameshifts, but could also be due to a generally larger amount of point mutations. 

Samples 1 & 2
<img width="2774" height="936" alt="image" src="https://github.com/user-attachments/assets/b73aab41-bf29-43b1-88cf-f984dac5e1c3" />

### Sample 3

Sample 3 has three duplications, between bases 1,606 and 5,934. This is also shown in the coverage display. I believe they are inversion duplications, since the duplicated area has a RL read. the middle section may have been duplicated twice, even, since the read coverage is about 3 times the amount of the normally covered areas. 

Sample 3
<img width="1246" height="542" alt="image" src="https://github.com/user-attachments/assets/4d400a02-a9e6-4b18-9cec-6138980109cc" />

### Sample 4

Sample 4 has an inversion, between bases 4947 and 6387. This can be determined by looking at the orientation of the reads, there is a section of RR reads and a section of LL reads. These reads cover the same area and are roughly double the length of the other reads in the paired reads display, but when you unpair the reads they alternate sections in 4 different chunks. The ungrouped view also highly reflects IGV's paired end alignment guide

Sample 4 RR Reads Paired
<img width="1612" height="370" alt="image" src="https://github.com/user-attachments/assets/a0c43de2-fe70-49fb-b9b6-01520ab8cbc0" />

Sample 4 LL Reads Paired
<img width="1524" height="358" alt="image" src="https://github.com/user-attachments/assets/b1ee9fa3-622e-4477-bcc6-9a9e4a29dc86" />

Sample 4 RR and LL Reads Unpaired
<img width="2466" height="928" alt="image" src="https://github.com/user-attachments/assets/7bc7bb41-3f25-499c-8472-2c4a3223eb96" />

Sample 4 As it Appears Normally
<img width="2440" height="924" alt="image" src="https://github.com/user-attachments/assets/dbeceea4-b4be-4915-a2e6-5250f18fd80e" />

### Sample 5

Sample 5 has a translocation. I believe it is a translocation and not a complete deletion, because while a deletion is present, there is a RL read that covers the area where the deletion is indicated. Since there is a deletion indicated, that tells me that that section of the genome is lacking something in that area, but since the RL read is shown, it seems that the information for that section is present elsewhere, which is why there is still coverage for that area, it was just moved to a different spot in the genome. 

Sample 5 RL Reads
<img width="2542" height="356" alt="image" src="https://github.com/user-attachments/assets/ba2ae983-4ee7-4cf9-91ee-8b32abc78e33" />

Sample 5 Paired Reads
<img width="1714" height="746" alt="image" src="https://github.com/user-attachments/assets/ea4cfd93-2fae-42f4-bfb8-f5b2f475a1a5" />

Sample 5 As it Appears Normally
<img width="2792" height="842" alt="image" src="https://github.com/user-attachments/assets/d55c9e15-4c30-48b1-bb93-d1be3db9e8d4" />

