#!/bin/sh
dockerize -template /home/app/vendor/docker/database.properties.tmpl:/home/app/src/main/resources/database.properties
# dockerize -template /home/app/docker/log4j.xml.tmpl:/home/app/src/main/resources/log4j.xml
dockerize -template /home/app/vendor/docker/log4j.properties.tmpl:/home/app/src/main/resources/log4j.properties
# dockerize -template /home/app/docker/crontab.tmpl:/home/app/docker/crontab