.PHONY: render preview check

render:
	python3 scripts/validate_sources.py
	Rscript scripts/validate_r.R
	quarto render
	python3 scripts/validate_site.py

preview:
	quarto preview

check:
	python3 scripts/validate_sources.py
	Rscript scripts/validate_r.R
	python3 scripts/validate_site.py
