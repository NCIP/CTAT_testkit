


build_genome_lib:
	../ctat-genome-lib-builder/prep_genome_lib.pl --genome_fa minigenome.fa --gtf minigenome.gtf --fusion_annot_lib CTAT_HumanFusionLib.mini.dat.gz --annot_filter_rule AnnotFilterRule.pm
	touch build_genome_lib


STAR_FUSION_BASIC: build_genome_lib
	../STAR-Fusion/STAR-Fusion --left_fq rnaseq_1.fastq.gz --right_fq rnaseq_2.fastq.gz --genome_lib_dir ctat_genome_lib_build_dir


STAR_FUSION_FULL_MONTY: build_genome_lib
	../STAR-Fusion/STAR-Fusion --left_fq rnaseq_1.fastq.gz --right_fq rnaseq_2.fastq.gz --genome_lib_dir ctat_genome_lib_build_dir --FusionInspector validate --denovo_reconstruct --examine_coding_effect 

FusionInspector: build_genome_lib
	../FusionInspector/FusionInspector --fusions fusion.targets --left_fq rnaseq_1.fastq.gz --right_fq rnaseq_2.fastq.gz  --genome_lib_dir ctat_genome_lib_build_dir --vis


