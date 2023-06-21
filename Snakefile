rule preassembly:
    conda: "env-jellyfish.yml"
    shell: """
        jellyfish count -C -m 21 -s 5400000 -t 8 m64069_220815_155249.hifi_reads.fasta -o reads.jf
        jellyfish histo -t 8 reads.jf > reads.histo
    """

rule nanoplot:
    conda: "env-nanoplot.yml"
    shell: """
        NanoPlot -t 2 --fastq m64069_220815_155249.hifi_reads.fastq.gz --color green -f png --plots kde dot hex --N50 -o nanoplot --tsv_stats --info_in_report
    """
    
rule assembly:
    conda: "env-assembly.yml"
    shell: """
        hifiasm -o hapla.asm -t32 m64069_220815_155249.hifi_reads.fastq.gz 2> hapla.asm.log

    """

rule minimap:
    conda: "env-minimap2.yml"
    shell: """
        minimap2 -t14 -a -x map-pb hapla.asm.bp.p_ctg.fa m64069_220815_155249.hifi_reads.fasta.gz | samtools sort -m 2G -o aligned.bam -T tmp.ali

    """

rule purge_haplotigs:
    conda: "env-purgehaplotigs.yml"
    shell: """
        purge_haplotigs hist -b aligned1.bam -g hapla.asm.bp.p_ctg.fa -t 10
        purge_haplotigs cov -i aligned1.bam.gencov -low 15 -mid 80 -high 195 -o coverage_stats.csv
        purge_haplotigs purge -g hapla.asm.bp.p_ctg.fa -c coverage_stats.csv -d -b aligned1.bam -o purged

    """

rule quast:
    conda: "env-quast.yml"
    shell: """
        quast purged_hapla_assembly.fasta -1 m64069_220815_155249.hifi_reads.fastq.gz -o quast_test_output
    """
    
