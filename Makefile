
PELICAN=pelican
PELICANOPTS=None

THEME=amazium

BASEDIR=$(PWD)
INPUTDIR=$(BASEDIR)/src
OUTPUTDIR=$(BASEDIR)/output
CONFFILE=$(BASEDIR)/pelican.conf.py

SSH_HOST=zara
SSH_USER=jan
SSH_TARGET_DIR=/var/www/blog.hoeja.de/

USER=jan
TARGET_DIR=/var/www/blog.hoeja.de/
HOST=zara

help:
	@echo 'Makefile for a pelican Web site                                       '
	@echo '                                                                      '
	@echo 'Usage:                                                                '
	@echo '   make html                        (re)generate the web site         '
	@echo '   make clean                       remove the generated files        '
	@echo '   ssh_upload                       upload the web site using SSH     '
	@echo '   rsync_upload                       upload the web site using SSH     '
	@echo '                                                                      '


html: clean $(OUTPUTDIR)/index.html
	@echo 'Done'

$(OUTPUTDIR)/%.html:
	$(PELICAN) $(INPUTDIR) -t themes/$(THEME) -o $(OUTPUTDIR) -s $(CONFFILE)

clean:
	rm -fr $(OUTPUTDIR)
	mkdir $(OUTPUTDIR)

ssh_upload: $(OUTPUTDIR)/index.html
	scp -r $(OUTPUTDIR)/* $(SSH_USER)@$(SSH_HOST):$(SSH_TARGET_DIR)

rsync_upload: $(OUTPUTDIR)/index.html
	rsync -r $(OUTPUTDIR)/* $(USER)@$(HOST):$(TARGET_DIR)

.PHONY: html help clean ssh_upload rsync_upload
    
