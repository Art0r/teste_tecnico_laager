#!/usr/bin/bash

# antes de testar necessario instalar sudo apt-get install apache2-utils
# fazendo 1000 requisições paralelas simulando pessoas votando
ab -n 10000 -c 1000 -m PATCH http://localhost:9999/api/participants/1/upvote &
ab -n 10000 -c 1000 -m PATCH http://localhost:9999/api/participants/2/upvote

exit