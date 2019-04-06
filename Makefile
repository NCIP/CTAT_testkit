


build_genome_lib:
	../ctat-genome-lib-builder/prep_genome_lib.pl --genome_fa minigenome.fa --gtf minigenome.gtf --fusion_annot_lib CTAT_HumanFusionLib.mini.dat.gz --annot_filter_rule AnnotFilterRule.pm
	touch build_genome_lib


STAR_FUSION: build_genome_lib
	../STAR-Fusion/STAR-Fusion --left_fq rnaseq_1.fastq.gz --right_fq rnaseq_2.fastq.gz --genome_lib_dir ctat_genome_lib_build_dir
	touch STAR_FUSION

STAR_FUSION_FULL: build_genome_lib
	../STAR-Fusion/STAR-Fusion --left_fq rnaseq_1.fastq.gz --right_fq rnaseq_2.fastq.gz --genome_lib_dir ctat_genome_lib_build_dir --FusionInspector validate --denovo_reconstruct --examine_coding_effect 

FusionInspector: build_genome_lib
	../FusionInspector/FusionInspector --fusions fusion.targets --left_fq rnaseq_1.fastq.gz --right_fq rnaseq_2.fastq.gz  --genome_lib_dir ctat_genome_lib_build_dir --vis


FusionInspector_FULL: build_genome_lib
	../FusionInspector/FusionInspector --fusions fusion.targets --left_fq rnaseq_1.fastq.gz --right_fq rnaseq_2.fastq.gz  --genome_lib_dir ctat_genome_lib_build_dir --vis --include_Trinity --examine_coding_effect



TrinityFusion: build_genome_lib STAR_FUSION
	../TrinityFusion/TrinityFusion --left_fq rnaseq_1.fastq.gz --right_fq rnaseq_2.fastq.gz  --chimeric_junctions STAR-Fusion_outdir/Chimeric.out.junction --aligned_bam STAR-Fusion_outdir/Aligned.out.bam --genome_lib_dir ctat_genome_lib_build_dir --output_dir trinity_fusion




clean:
	rm -rf ./STAR-Fusion_outdir
	rm -rf ./__loc_chkpts
	rm -f ./ref_annot.cdsplus*
	rm -f ./ref_annot.cdna*
	rm -f ./pipeliner*
	rm -f ./Log.out
	rm -rf ./FI
	rm -f ./STAR_FUSION
	rm -rf ./trinity_fusion

purge: clean
	rm -rf ./ctat_genome_lib_build_dir
	rm -f ./build_genome_lib

