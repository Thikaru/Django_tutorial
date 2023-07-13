up:
	docker compose up -d
build:
	docker compose build --no-cache --force-rm
init:
	docker compose up -d --build
	docker compose exec web python3 manage.py migrate
	docker compose exec web cp -n .env.example .env
	@make fresh
remake:
	@make destroy
	@make init
stop:
	docker compose stop
down:
	docker compose down --remove-orphans
restart:
	@make down
	@make up
destroy:
	docker compose down --rmi all --volumes --remove-orphans
destroy-volumes:
	docker compose down --volumes --remove-orphans
pip-install:
	docker compose exec web pip install -r requirements.txt
ps:
	docker compose ps
logs:
	docker compose logs
logs-watch:
	docker compose logs --follow
log-web:
	docker compose logs web
log-web-watch:
	docker compose logs --follow web
log-db:
	docker compose logs db
log-db-watch:
	docker compose logs --follow db
web:
	docker compose exec web bash
makemigrations:
	docker compose exec web python3 manage.py makemigrations
migrate:
	docker compose exec web python3 manage.py migrate
fresh:
	docker compose exec web python3 manage.py flush
seed:
	docker compose exec web python3 manage.py db_seed
shell:
	docker compose exec web python3 manage.py shell
test:
	docker compose exec app python3 manage.py test
cache:
	docker compose exec app composer dump-autoload -o
	@make optimize
	docker compose exec app php artisan event:cache
	docker compose exec app php artisan view:cache
cache-clear:
	docker compose exec app composer clear-cache
	@make optimize-clear
	docker compose exec app php artisan event:clear
npm:
	@make npm-install
npm-install:
	docker compose exec web npm install
npm-dev:
	docker compose exec web npm run dev
npm-watch:
	docker compose exec web npm run watch
npm-watch-poll:
	docker compose exec web npm run watch-poll
npm-hot:
	docker compose exec web npm run hot
yarn:
	docker compose exec web yarn
yarn-install:
	@make yarn
yarn-dev:
	docker compose exec web yarn dev
yarn-watch:
	docker compose exec web yarn watch
yarn-watch-poll:
	docker compose exec web yarn watch-poll
yarn-hot:
	docker compose exec web yarn hot
db:
	docker compose exec db bash
sql:
	docker compose exec db bash -c 'mysql -u $$MYSQL_USER -p$$MYSQL_PASSWORD $$MYSQL_DATABASE'
redis:
	docker compose exec redis redis-cli
ide-helper:
	docker compose exec app php artisan clear-compiled
	docker compose exec app php artisan ide-helper:generate
	docker compose exec app php artisan ide-helper:meta
	docker compose exec app php artisan ide-helper:models --nowrite
log-refresh:
	find ./backend/storage/logs | grep -E '/(.*)\.log$/' | xargs rm -rf
storage-link:
	docker compose exec app php artisan storage:link
TIMESTAMP=$(shell date +%Y%m%d)
for-deploy-%:
	git checkout -b ${@:for-deploy-%=%}/${TIMESTAMP}
	yarn build
	echo '!backend/public/js' >> .gitignore
	grep -l 'docker compose' Makefile | xargs sed -i.bak -e 's/docker compose/docker-compose/g'
	rm Makefile.bak
	git add -A
	git commit -m 'release'
	git push origin ${@:for-deploy-%=%}/${TIMESTAMP} --force-with-lease
	git checkout master
preview:
	@make for-deploy-preview
