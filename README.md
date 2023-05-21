# Genome Assembly of Plant Parasitic Nematode _Meloiogyne hapla_

Sequencing was done by PacBio Hifi method. 

Assembly process: 

- Pre-assembly stats uses [jellyfish](https://github.com/gmarcais/Jellyfish) and [nanoplot](https://github.com/wdecoster/NanoPlot)
- Assembly uses [hifiasm](https://github.com/chhylp123/hifiasm) and [purged haplotigs](https://github.com/skingan/purge_haplotigs_multiBAM/blob/master/README.md)
- Evaluation of assembly uses [minimap2](https://github.com/lh3/minimap2) and [quast](https://github.com/ablab/quast)

Workflow is made using Snakemake. To run the process:

```
conda activate snakemake
snakemake-j xx rule_you_want_to_run

```
