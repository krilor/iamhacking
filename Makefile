init:
	stat .env || virtualenv .env
	. .env/bin/activate && pip install -r requirements.txt
	. .env/bin/activate && python -m bash_kernel.install

freeze:
	. .env/bin/activate && pip freeze > requirements.txt

update-theme:
	git submodule update

build: convert
	hugo

convert:
	find ./notebooks/ -maxdepth 1 -name "*.ipynb" | xargs -I % basename % .ipynb | xargs -I % \
	jupyter nbconvert --to markdown --output ../content/posts/%.md notebooks/%.ipynb
