SWE_TEX := targets/swe/swe.tex
PL_TEX := targets/pl/pl.tex
CLOUD_TEX := targets/cloud/cloud.tex
CUSTOM_TEX := targets/custom/custom.tex
COVER_LETTERS_TEX := $(wildcard cover-letters/*.tex) $(wildcard cover-letters/*/*.tex)
COVER_LETTERS_PDF := $(patsubst %.tex,%.pdf,$(COVER_LETTERS_TEX))
COVER_LETTERS_TOPLEVEL_PDF := $(notdir $(COVER_LETTERS_PDF))
COVER_LETTERS_TARGETS := $(basename $(notdir $(COVER_LETTERS_TEX)))

.PHONY: all swe cloud custom pl cover-letters $(COVER_LETTERS_TARGETS) tidy clean

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
	@for tex in $(COVER_LETTERS_TEX); do \
		latexmk -pdf -output-directory=$$(dirname $$tex) $$tex; \
		cp $${tex%.tex}.pdf .; \
	done
	$(MAKE) tidy

define COVER_LETTER_TARGET
$(basename $(notdir $(1))): $(1)
	latexmk -pdf -output-directory=$(dir $(1)) $(1)
	cp $(patsubst %.tex,%.pdf,$(1)) .
	$$(MAKE) tidy
endef

$(foreach tex,$(COVER_LETTERS_TEX),$(eval $(call COVER_LETTER_TARGET,$(tex))))

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
	$(RM) targets/swe/swe.pdf targets/pl/pl.pdf targets/cloud/cloud.pdf targets/custom/custom.pdf swe.pdf pl.pdf cloud.pdf custom.pdf $(COVER_LETTERS_PDF) $(COVER_LETTERS_TOPLEVEL_PDF)
