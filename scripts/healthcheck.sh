#!/bin/bash
# Author: Luka Stajkovic
# Date: 07.11.2026.
# Description: This script performs health checks.
# It gets passed URL argument. Calls /health endpoint
# and logs findings to the console. If the health check fails,
# it will log an error message and exit with a non-zero status code.

if [[ -z $1 ]]; then
    echo "----"
    echo "To use $0 script please provide a valid URL
in format: $0 [URL]

example: $0 http://localhost:8080"
    echo "----"

    exit 1
else
    URL=$1
    HEALTH_URL="$URL/health"

    for (( i=1; i<=5; i++ )); do
        STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$HEALTH_URL")
        TIMESTAMP=$(date "+%d-%m-%Y %H:%M:%S")

            if [[ "$STATUS" -eq 200 ]]; then
                echo "[$TIMESTAMP] [INFO] [$STATUS] Application is healthy!"
                exit 0
            else
                echo "[$TIMESTAMP] [ERROR] [$STATUS] Pokusaj ${i}/5"
                sleep 3

            fi


    done

    exit 1
fi
