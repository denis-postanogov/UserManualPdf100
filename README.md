# UserManualPdf100 Dataset

Collection of language-annotated multilingual User Manuals (PDF documents) to use as a test dataset for different projects. Each user manual is a multipage document, in most of the cases having the same text data written in many languages. The table of contents page usually lists all the languages, that is why it was easier to annotate pages with language identifiers. Language annotation is done per-page, and located in `data/pdf-page-lang-annotation.txt` file.

The user manuals are shared as web links to PDF files, so you may download them from internet based on `data/pdf-links.txt` list using any tool you want. Alternatively you may use the GNU Make script from this project to download and check the files with one command in Linux. Additionally, for testing OCR projects, you can extract images with specific make target, if you have all dependencies installed on your machine.

## How to obtain PDF files

From the project's directory, run:

    make

or (to run 10 download jobs simultaneously):

    make -j 10

This will download 100 PDF files from their original internet links listed in `data/pdf-links.txt`, and place them into 'pdf' directory. Total download size is expected 479,018,455 bytes in 100 files. Each file will be checked against its expected checksum. Please report the author if download fails.

## Language annotations for pages

As some projects require information about the languages used in the document, or the language of the document page, the file `data/pdf-page-lang-annotation.txt` contains annotation of mono-lingual pages of 100 documents.

E.g., the following line:

        UMP100-00536704.pdf   4   eng   eng
     
means that the document "UMP100-00536704.pdf" has page #4 with "English" language identified by 
human annotator (based on viewing the document), and "English" language detected (based on automatic 
analysis of text extracted from page using langdetect system described in \[1\]).

Language annotation statistics:

|Language|Annotated pages|Detected pages|Annotated=Detected pages|
|-|-|-|-|
|ara|81|43|34|
|bos|0|1|0|
|bul|108|101|98|
|ces|137|132|123|
|dan|253|252|238|
|deu|492|536|477|
|ell|194|196|181|
|eng|1181|1265|1159|
|est|102|100|89|
|fas|8|8|8|
|fin|175|172|162|
|fra|461|493|436|
|heb|6|3|3|
|hin|2|2|2|
|hrv|96|116|82|
|hun|168|164|155|
|ind|18|18|18|
|isl|2|2|2|
|ita|372|420|358|
|jpn|138|145|117|
|kaz|41|41|41|
|kor|140|147|132|
|lav|99|93|86|
|lit|96|90|83|
|mkd|17|21|17|
|nld|309|305|294|
|nor|163|161|150|
|pol|302|311|292|
|por|226|248|211|
|ron|116|122|113|
|rus|721|759|708|
|slk|108|110|103|
|slv|121|128|117|
|spa|521|528|484|
|srp|74|45|45|
|swe|265|276|261|
|tha|17|17|17|
|tur|163|166|158|
|ukr|94|96|94|
|vie|6|6|6|
|zho|147|246|144|
|zlm|6|4|4|

Total pages: 8,478.

## How to obtain image files for PDF pages

Some projects (e.g. to test an OCR system), require image files produced from pages with known languages. 

Run:

    make produce_png
    
or (to run 10 simultaneous jobs on your powerfull server):

    make -j 10 produce_png
    
This will create directory 'images' and generate 7,302 PNG image files in PNG format from the pages of PDF documents with definitely known language. The image files will be distributed in directories according to language code (ara, bul, ces, dan, deu, ell, eng, ...) and named as follows:

        images/eng/UMP100-00536704.pdf.004.png 

This file is English language page #4 from PDF file "UMP100-00536704.pdf". 

The number of generated PNG files in each folder is given in the last column of above table. Resolution for generated PNG files is 300 dpi, with total size 3,816,705,512 bytes in 7,302 files.

### Dependency 

Make sure that `pdftocairo` tool is available on your system. This is available in "poppler-utils" package for Ubuntu and Debian. 

Use the following command to install 'pdftocairo' on Ubuntu Linux:

    sudo yum install poppler-utils

Use the following command to install 'pdftocairo' on Debian Linux:

    sudo apt-get install poppler-utils
    
## References

1. N. Stefanovitch. [Robust Multilingual Document Identification](http://elib.bsu.by/bitstream/123456789/160177/1/Stefanovitch.pdf). International congress on Computer Science: Information Systems and Technologies (CSIST'2016). Minsk, October 24–27, 2016.

## Author

Denis Postanogov, email: {firstname}.{lastname}@ihsmarkit.com

(c) Copyright 2017 IHS Markit Ltd.
