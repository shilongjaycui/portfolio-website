PORT := 4000
URL := http://127.0.0.1:$(PORT)

.PHONY: run-local-dev-server

run-local-dev-server:
	( sleep 1 && xdg-open "$(URL)" ) &
	bundle exec jekyll serve --livereload --port $(PORT)
