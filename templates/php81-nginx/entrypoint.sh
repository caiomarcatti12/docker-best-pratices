#!/bin/bash

if [ ! -d "./vendor" ] && [ -f "composer.json" ] ;
then
    composer install
fi
if [ ! -f ".env" ] && [ -f ".env.example" ]  ; then cp .env.example .env ; chmod 777 ./.env -Rf ; fi

chmod 777 /var/www/html -Rf

/bin/bash -c "nginx"

echo 'started'
exec "$@"
