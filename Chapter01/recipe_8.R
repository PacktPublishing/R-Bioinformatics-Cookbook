region_of_interest <- GRanges(seqnames = c("17"), ranges = IRanges(79478301, 79478361))

bam_folder <- file.path(getwd(), "datasets", "ch1", "allele_expression")

reads <- impBamGAL(bam_folder, region_of_interest, verbose = FALSE)

vcf_file <-file.path( getwd(), "datasets", "ch1", "allele_expression","ERP000101.vcf" )

variant_positions <- granges(VariantAnnotation::readVcf(vcf_file), "hg19" )

allele_counts <- getAlleleCounts(reads, variant_positions, verbose=FALSE)

ase.vcf <- ASEsetFromCountList(rowRanges = variant_positions, allele_counts)

reference_sequence <- file.path(getwd(), "datasets", "ch1", "allele_expression", "hg19.chr17.subset.fa")


ref(ase.vcf) <- refAllele(ase.vcf,fasta=reference_sequence)
alt(ase.vcf) <- inferAltAllele(ase.vcf)

binom.test(ase.vcf, n="*")