setup:
	cp -n .env.example .env || true
	bin/setup

start:
	bin/rails s -p 3000 -b "0.0.0.0"

console:
	bin/rails console

lint:
	bundle exec slim-lint app/views/
	bundle exec rubocop

fix:
	bundle exec rubocop -A

deploy:
	git push heroku main

test:
	NODE_ENV=test bin/rails test

.PHONY: test