#########################################################################################################
#
# Makefile for obtaining "UserManualPdf100" dataset.
#
# Run 'make' (GNU Make) from the directory with this Makefile.
# This will download PDF files for UserManualPdf100 dataset and place them into "pdf" directory, 
# and check the files against their expected checksum.
#
# See LICENSE file for terms and conditions for use.
#
# (c) 2017, IHS Markit Ltd.
#
#########################################################################################################

DATADIR=data
PDFDIR=pdf
MD5SUM_DIR=md5sum-check
PDFLINKS_FILE=$(DATADIR)/pdf-links.txt

.PHONY: download_pdf produce_png

all: download_pdf

# generate download dependencies from links file
download_pdf: $(addprefix $(PDFDIR)/, $(shell cut -f 1 "$(DATADIR)/pdf-links.txt" | tr "\n" " "))

# download pdf file
$(PDFDIR)/%.pdf:
	mkdir -p "$(@D)" && \
	touch "$@" && \
	awk -v Target="$(@F)" 'BEGIN {FS="\t"} $$1==Target {print $$2; exit(0)}' < "$(PDFLINKS_FILE)" | \
	while read Url ; do \
		if wget -U Mozilla/5.0 --no-cache --proxy --no-check-certificate -q -O "$@".inprogress "$${Url}" ; then \
			mv "$@".inprogress "$@" ; \
		fi \
	done && \
	md5sum -c "$(MD5SUM_DIR)/$(@F).md5sum"
