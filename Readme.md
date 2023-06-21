Sequencing was done by PacBio Hifi method.

Assembly process:

Pre-assembly stats uses jellyfish and nanoplot
Assembly uses hifiasm and purged haplotigs
Evaluation of assembly uses minimap2 and quast
Workflow is made using Snakemake. To run the process:

conda activate snakemake
snakemake-j xx rule_you_want_to_run


