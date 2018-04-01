#!/bin/sh

set -a
ENV_FILE=${ENV_FILE:=/.env}
if [ -r $ENV_FILE ]; then
    . $ENV_FILE
fi


set +a
ENV_DIR=${ENV_DIR:=/var/env}
if [ -d $ENV_DIR ]; then
    for file in $ENV_DIR/* ; do
        if [ -r $file ]; then
            export "$(basename $file)"="$(cat $file)"
        fi
    done
fi


set -a

APP_TZ=${APP_TZ:="Europe/Moscow"}


### app-user
UID=$(id -u app)
GID=$(id -g app)
APP_UID=${APP_UID:=$UID}
APP_GID=${APP_GID:=$GID}

### app-dir
APP_DIR=${APP_DIR:="/app"}
PWD=${APP_DIR}

### app-env
APP_ENV=${APP_ENV:="prod"}
if [[ "${APP_ENV}" = "prod" || "${APP_ENV}" = "production" ]]; then
    IS_PROD=1
    IS_DEV=0
else
    IS_PROD=0
    IS_DEV=1
fi

PHP_DISPLAY_ERRORS=${IS_DEV}
EXPOSE_PHP=${IS_DEV}
PHP_OPCACHE_VALIDATE_TIMESTAMPS=${IS_DEV}
