COMPILER=xelatex
SPELLER=aspell -t -c
BIBTEX=bibtex
REFERENCES=report.bib # bibtex .bib files
report_TEX=report.tex # report .tex file
BIB_AUX=report.aux # .aux files
WC=texcount
# get just the text word count (no headings, citations, etc)
WC_AFTER=| grep text | head -1 | cut -d ' ' -f 4 
# file to store word count
WC_FILE=wordcount

spell: 
		make bibtex
		make $(WC_FILE)
		$(SPELLER) $(report_TEX) 

nospell: 
		make bibtex
		make $(WC_FILE)
		make compile

compile: $(report_TEX)
		$(COMPILER) $(report_TEX)

printwordcount:
		@make $(WC_FILE)
		cat $(WC_FILE)

$(WC_FILE): $(report_TEX)
		@$(WC) $(report_TEX) $(WC_AFTER) > $(WC_FILE)

bibtex: $(REFRENCES)
		make compile
		$(BIBTEX) $(BIB_AUX)
		make compile
