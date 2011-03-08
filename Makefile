PREFIX=algorithmik
CHECKSUM=checksum.aux

all: tex

tex:
	pdflatex $(PREFIX).tex
	
	@# have an index file?
	@if [ -e "$(PREFIX).idx" ]; \
	then \
		makeindex $(PREFIX).idx; \
	fi

	@# run pdflatex again?
	@sum=`cat *.toc *.idx|md5sum`; \
	oldsum=`cat $(CHECKSUM)`; \
	if [ "$$sum" != "$$oldsum" ]; \
	then \
		pdflatex $(PREFIX).tex; \
		cat *.toc *.idx|md5sum > $(CHECKSUM); \
	fi

clean:
	rm -f *.toc *.aux *.log *.ilg *.ind *.out *.idx
