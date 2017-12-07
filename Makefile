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
IMAGEDIR=images
MD5SUM_DIR=md5sum-check
PDFLINKS_FILE=$(DATADIR)/pdf-links.txt
PDFPAGES_LANG_ANNOTATION_FILE=$(DATADIR)/pdf-page-lang-annotation.txt

.PHONY: download_pdf produce_png

all: download_pdf

# generate download dependencies from links file
download_pdf: $(addprefix $(PDFDIR)/, $(shell cut -f 1 "$(DATADIR)/pdf-links.txt" | tr "\n" " "))

# download pdf files
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
	
# generate page dependencies
produce_png: $(addprefix $(IMAGEDIR)/, $(shell awk '/^[^#]/ && $$3==$$4 && 3==length($$3) { printf " %s/%s.%03d.png", $$3, $$1, $$2 }' < "$(PDFPAGES_LANG_ANNOTATION_FILE)"))

$(IMAGEDIR)/%.png:
	pdf_file=`printf "%s\n" "$(@F)" | cut -d "." -f 1,2` && \
	page_num=`printf "%s\n" "$(@F)" | cut -d "." -f 3` && \
	target_noExt=`printf "%s\n" "$@" | sed 's/\.png$$//'` && \
	mkdir -p "$(@D)" && \
	pdftocairo -png -r 300 -f $${page_num} -l $${page_num} -singlefile "$(PDFDIR)/$${pdf_file}" "$${target_noExt}"
