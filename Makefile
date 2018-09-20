# Update this to give whichever name you want. This may be set on the command line:
# > make build OUT_FILE=./outfile.zip
OUT_FILE?=./dist.zip
BUILDDIR=./out

### Below this point it should not need to be changed
# get absolute path of zipfile to deliver
DELIVERABLE=$(abspath $(OUT_FILE))

# Install all the libs locally
install:
	pipenv install --three

# Destroy the virtualenv
uninstall:
	pipenv --rm

# Run the import
run:
	pipenv run python ./hello_lambda.py

# Clean delivrable
clean:
	rm -f ${DELIVERABLE}

# Rebuild the deliverable
# see https://github.com/pypa/pipenv/issues/986#issuecomment-394741582
build:
	mkdir -p $(BUILDDIR)
	$(pipenv) lock -r > $(BUILDDIR)/requirements.txt
	cp -R $(SRCDIR)/* $(BUILDDIR)
	$(pipenv) run pip install --isolated --disable-pip-version-check -r $(BUILDDIR)/requirements.txt -t $(BUILDDIR) -U
