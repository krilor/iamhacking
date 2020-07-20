init:
	stat .env || virtualenv .env
	. .env/bin/activate && pip install -r requirements.txt

freeze:
	. .env/bin/activate && pip freeze > requirements.txt

update-theme:
	git submodule update

build:
	hugo
