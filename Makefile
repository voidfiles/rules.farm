site:
	pipenv run python makesite.py

watch:
	pipenv run honcho start

watchsite:
	watchexec -w makesite.py -w layout/ -w static/ -w content/ make site

serve: site
	pipenv run python -m http.server --directory _site

pipenv:
	pipenv install

setup:
	brew install watchexec

test: FORCE
	pipenv run python -m unittest -bv

coverage:
	pipenv run coverage run --branch --source=. -m unittest discover -bv; :
	pipenv run coverage report -m
	pipenv run coverage html

clean:
	find . -name "__pycache__" -exec rm -r {} +
	find . -name "*.pyc" -exec rm {} +
	rm -rf .coverage htmlcov

FORCE:
