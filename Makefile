
TARFILE = ../grimport-gridsvg-export-deposit-$(shell date +'%Y-%m-%d').tar.gz
# For building on my office desktop
# Rscript = ~/R/r-devel/BUILD/bin/Rscript
Rscript = Rscript

%.xml: %.cml %.bib
	# Protect HTML special chars in R code chunks
	$(Rscript) -e 't <- readLines("$*.cml"); writeLines(gsub("str>", "strong>", gsub("<rcode([^>]*)>", "<rcode\\1><![CDATA[", gsub("</rcode>", "]]></rcode>", t))), "$*.xml")'
	$(Rscript) toc.R $*.xml
	$(Rscript) bib.R $*.xml

%.Rhtml : %.xml
	# Transform to .Rhtml
	xsltproc knitr.xsl $*.xml > $*.Rhtml

%.html : %.Rhtml
	# Use knitr to produce HTML
	$(Rscript) knit.R $*.Rhtml

docker:
	cp ../../grImport2_0.2-0.tar.gz .
	sudo docker build -t pmur002/grimport-gridsvg-export .
	sudo docker run -v $(shell pwd):/home/work/ -w /home/work --rm pmur002/grimport-gridsvg-export make grimport-gridsvg-export.html

web:
	make docker
	cp -r ../grimport-gridsvg-export-report/* ~/Web/Reports/grImport/grimport-gridsvg-export/

zip:
	make docker
	tar zcvf $(TARFILE) ./*
