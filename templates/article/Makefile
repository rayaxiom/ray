all: pdf
FILENAME = template
pdf: $(FILENAME).tex bib.bib
	pdflatex $(FILENAME)
	bibtex $(FILENAME)
	pdflatex $(FILENAME)
	pdflatex $(FILENAME)

clean:
	rm -f $(FILENAME).aux $(FILENAME).log $(FILENAME).toc $(FILENAME).lot $(FILENAME).bbl $(FILENAME).blg $(FILENAME).pdf $(FILENAME).lof

run:
	gnome-open $(FILENAME).pdf


