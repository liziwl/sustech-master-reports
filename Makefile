.PHONY: clean FORCE_MAKE

main.pdf: main.tex FORCE_MAKE
	xelatex main.tex
	bibtex main.aux
	xelatex main.tex
	xelatex main.tex
clean:
	rm -f *.aux
	rm -f *.log
	rm -f *.toc
	rm -f *.bbl
	rm -f *.blg
	rm -f *.out
	rm -f *.thm