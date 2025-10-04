#!/usr/bin/bash

export RAILS_ENV=test

docker rm -f "$(docker ps -aq)" 2>/dev/null || true
docker volume rm "$(docker volume ls -q)" 2>/dev/null || true
docker run -d --name postgres-db-teste -e POSTGRES_USER=postgres_teste -e POSTGRES_PASSWORD=123 -e POSTGRES_DB=postgres_teste -p 5432:5432 postgres:17-alpine

echo "Waiting for PostgreSQL to start..."
sleep 5

mise use ruby@3.3.9
#bin/rails db:create
#bin/rails db:migrate
#bin/rails test test/controllers/
#
#bin/rails db:create
#bin/rails db:migrate
#bin/rails test test/jobs/

bin/rails db:create
bin/rails db:migrate
bin/rails test test/models