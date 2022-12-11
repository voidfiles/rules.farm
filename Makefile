site:
	pipenv run python makesite.py

vercel: site
	rm -fR .vercel
	mkdir -p .vercel/output/static
	cp -fR _site/* .vercel/output/static 

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

act:
	op run --env-file=".env" -- \
		act \
			-s VERCEL_ORG_ID \
			-s VERCEL_PROJECT_ID \
			-s VERCEL_TOKEN \
			-s GITHUB_TOKEN \
			-e event.json \
			--container-architecture linux/amd64 \
			pull_request
FORCE:
