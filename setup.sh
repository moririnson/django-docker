#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Specify application name.（You must specify only one arg.）"
    exit 1
fi

django-admin startproject core
mv core/core core/tmp
mv core/* .
rm -rf core
mv tmp core
touch .env
python manage.py startapp $1
docker-compose up -d