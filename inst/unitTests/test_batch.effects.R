# The NanoStringNorm package is copyright (c) 2012 Ontario Institute for Cancer Research (OICR)
# This package and its accompanying libraries is free software; you can redistribute it and/or modify it under the terms of the GPL
# (either version 1, or at your option, any later version) or the Artistic License 2.0.  Refer to LICENSE for the full license text.
# OICR makes no representations whatsoever as to the SOFTWARE contained herein.  It is experimental in nature and is provided WITHOUT
# WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE OR ANY OTHER WARRANTY, EXPRESS OR IMPLIED. OICR MAKES NO REPRESENTATION
# OR WARRANTY THAT THE USE OF THIS SOFTWARE WILL NOT INFRINGE ANY PATENT OR OTHER PROPRIETARY RIGHT.
# By downloading this SOFTWARE, your Institution hereby indemnifies OICR against any loss, claim, damage or liability, of whatsoever kind or
# nature, which may arise from your Institution's respective use, handling or storage of the SOFTWARE.
# If publications result from research using this SOFTWARE, we ask that the Ontario Institute for Cancer Research be acknowledged and/or
# credit be given to OICR scientists, as scientifically appropriate.

test.batch.effects <- function(date.input = '2011-11-04', date.checked.output = '2011-11-04'){
	
	# go to test data directory
	path.to.input.files <- '../NanoStringNorm/extdata/input';
	path.to.output.files <- '../NanoStringNorm/extdata/output';

	# read input files
	x             <- read.table(paste(path.to.input.files, 'mRNA_TCDD_matrix.txt', sep = ''), sep = '\t', header = TRUE, as.is = TRUE);
	anno          <- read.table(paste(path.to.input.files, 'mRNA_TCDD_anno.txt', sep = ''), sep = '\t', header = TRUE, as.is = TRUE);
	trait         <- read.table(paste(path.to.input.files, 'mRNA_TCDD_strain_info.txt', sep = ''), sep = '\t', header = TRUE, as.is = TRUE);

	# read *checked output*
	checked.output.batch <- dget(file = gzfile(paste(path.to.output.files, 'mRNA_TCDD_Batch_effects.txt.gz', sep = '')));
	checked.output.sample.summary <- dget(file = gzfile(paste(path.to.output.files, 'mRNA_TCDD_Sample_Summary.txt.gz', sep = '')));

	# run function to get *test output* 
	test.output.batch      <- NanoStringNorm:::get.batch.effects(x, anno, sample.summary.stats = checked.output.sample.summary, traits = trait);

	### check1 - compare checked output == test output
	check1.1 <- checkEquals(checked.output.batch, test.output.batch);

	### check2 - check garbage input
	#check2.1 <- checkException(NanoStringNorm:::get.batch.effects(x, anno, traits = 'mean'));

	checks <- c(check1.1 = check1.1);
	if (!all(checks)) print(checks[checks == FALSE]);

	return(all(checks))

	}
