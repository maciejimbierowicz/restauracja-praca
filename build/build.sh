#!/bin/bash

set -x
set -e

docker-compose -f docker-compose.dev.yml down
docker-compose -f docker-compose.dev.yml pull
docker-compose -f docker-compose.dev.yml build
docker-compose -f docker-compose.dev.yml up -d --force-recreate --remove-orphans

docker-compose -f docker-compose.dev.yml run php-dev ansible-playbook /app/build/build.yml
