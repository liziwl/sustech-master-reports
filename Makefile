LATEXMK = latexmk
SHELL  := /bin/bash

REPORT  = main-example

# make deletion work on Windows
ifdef SystemRoot
	RM = del /Q
else
	RM = rm -f
endif

.PHONY: all clean cleanall thesis viewthesis wordcount FORCE_MAKE

report: $(REPORT).pdf

all: report

$(REPORT).pdf: FORCE_MAKE
	$(LATEXMK) $(REPORT)

clean:
	$(LATEXMK) -c $(REPORT)

cleanall: clean
	-@$(RM) $(REPORT).pdf

wordcount : $(REPORT).tex
	@if grep -v ^% $< | grep -q '\\documentclass\[[^\[]*english'; then \
		texcount $< -inc -char-only | awk '/total/ {getline; print "英文字符数\t\t\t:",$$4}'; \
	else \
		texcount $< -inc -ch-only   | awk '/total/ {getline; print "纯中文字数\t\t\t:",$$4}'; \
	fi
	@texcount $< -inc -chinese | awk '/total/ {getline; print "总字数（英文单词 + 中文字）\t:",$$4}'