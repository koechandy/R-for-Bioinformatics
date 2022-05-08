#!/usr/bin/env Rscript
usage <- function () {
	cat("Applicationname by Detlef Groth, University of Potsdam\n")
	cat("Usage: ./appname arg1 arg2\n")
}
main <- function () {
	args=commandArgs(trailingOnly=TRUE)
	if (length(args) == 0) {
		usage()
	} else {
		# do your work
	}
}

if (sys.nframe() == 0 & !interactive()) {
	main()
}
