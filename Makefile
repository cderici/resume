SWE_TEX := targets/swe/swe.tex
PL_TEX := targets/pl/pl.tex
CLOUD_TEX := targets/cloud/cloud.tex
CUSTOM_TEX := targets/custom/custom.tex
COVER_LETTERS_TEX := $(filter-out cover-letters/shared/%.tex,$(wildcard cover-letters/*/*.tex))

all:  swe cloud pl

swe: $(SWE_TEX)
	latexmk -pdf -output-directory=targets/swe $(SWE_TEX)
	cp targets/swe/swe.pdf swe.pdf
	$(MAKE) tidy

cloud: $(CLOUD_TEX)
	latexmk -pdf -output-directory=targets/cloud $(CLOUD_TEX)
	cp targets/cloud/cloud.pdf cloud.pdf
	$(MAKE) tidy

custom: $(CUSTOM_TEX)
	latexmk -pdf -output-directory=targets/custom $(CUSTOM_TEX)
	cp targets/custom/custom.pdf custom.pdf
	$(MAKE) tidy

pl: $(PL_TEX)
	latexmk -pdf -output-directory=targets/pl $(PL_TEX)
	cp targets/pl/pl.pdf pl.pdf
	$(MAKE) tidy

cover-letters: $(COVER_LETTERS_TEX)
	@for tex in $(COVER_LETTERS_TEX); do latexmk -pdf -output-directory=$$(dirname $$tex) $$tex; done
	$(MAKE) tidy

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
	$(RM) targets/swe/swe.pdf targets/pl/pl.pdf targets/cloud/cloud.pdf targets/custom/custom.pdf swe.pdf pl.pdf cloud.pdf custom.pdf
