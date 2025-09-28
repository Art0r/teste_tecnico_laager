#!/usr/bin/bash

# fazendo 1000 requisições paralelas simulando pessoas votando
ab -n 10000 -c 1000 -m PATCH http://localhost:9999/api/participants/1/upvote &
ab -n 10000 -c 1000 -m PATCH http://localhost:9999/api/participants/2/upvote

exit