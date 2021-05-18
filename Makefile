.PHONY: clean report test FORCE_MAKE

REPORT  = main

report: $(REPORT).pdf

$(REPORT).pdf: FORCE_MAKE
	xelatex $(REPORT)
	bibtex $(REPORT)
	xelatex $(REPORT)
	xelatex $(REPORT)
clean:
	rm -f *.aux
	rm -f *.log
	rm -f *.toc
	rm -f *.bbl
	rm -f *.blg
	rm -f *.out
	rm -f *.thm