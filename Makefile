TEXFILES := $(wildcard *.tex)

all:  main

main: $(TEXFILES)
	latexmk -pdf main.tex

cloud: $(TEXFILES)
	latexmk -pdf cloud.tex

tidy:
	find . -type f \( \
	-name "*.log" -o \
	-name "*.aux" -o \
	-name "*.acn" -o \
	-name "*.acr" -o \
	-name "*.alg" -o \
	-name "*-blx.bib" -o \
	-name "*.ist" -o \
	-name "*.synctex.gz" -o \
	-name "*.cfg" -o \
	-name "*.glo" -o \
	-name "*.glg" -o \
	-name "*.glsdefs" -o \
	-name "*.idx" -o \
	-name "*.toc" -o \
	-name "*.ilg" -o \
	-name "*.ind" -o \
	-name "*.out" -o \
	-name "*.lof" -o \
	-name "*.lot" -o \
	-name "*.bbl" -o \
	-name "*.blg" -o \
	-name "*.gls" -o \
	-name "*.cut" -o \
	-name "*.hd" -o \
	-name "*.dvi" -o \
	-name "*.ps" -o \
	-name "*.thm" -o \
	-name "*.tgz" -o \
	-name "*.zip" -o \
	-name "*.rpi" -o \
	-name "*.fdb_latexmk" -o \
	-name "*.fls" \
	\) -delete


clean: tidy
	$(RM) main.pdf
