#!/usr/bin/bash

# antes de testar necessario instalar sudo apt-get install apache2-utils
# fazendo 10000 requisições simulando pessoas votando
ab -n 1000 -c 1000 -m PATCH http://localhost:9999/api/participants/1/upvote

exit