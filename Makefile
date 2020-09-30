.PHONY:clean

main.pdf: main.tex
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