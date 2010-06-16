all:
	@echo " II Publishing documentation to pub/doc"
	@emacs -batch -Q -l ../src/org-batch.el -e '(org-publish-batch-project "autorg-docs" t)'

clean:
	rm -f *~
