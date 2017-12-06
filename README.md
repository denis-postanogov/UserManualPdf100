# UserManualPdf100

Collection of multilingual User Manuals (PDF documents) to be used as test dataset for different projects.

## How to obtain PDF files

Run `make` or `make download_pdf` from UserManualPdf100 directory. This will download PDF files from their internet links listed in `data/pdf-links.txt`.

This will download 100 PDF files and place them into 'pdf' directory. Each file will be checked against its expected checksum.

NOTE: to make the downloading faster, run `make -j 10` to enable 10 download jobs simultaneously.

## Language Annotations for Pages

As some projects require information about the languages used in the document, or the language of the document page, the file `data/pdf-page-lang-annotation.txt` contains 
annotation of mono-lingual pages of 100 documents.

E.g., the following line:

        UMP100-00536704.pdf   4   eng   eng
     
means that document "UMP100-00536704.pdf" has page #4 with "English" language identified by 
human annotator (based on viewing the document), and "English" language detected (based on automatic 
analysis of text extracted from page).

