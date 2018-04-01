#!/bin/sh

set -e

### app-user
if [[ ${APP_UID} != ${UID} || ${APP_GID} != ${GID} ]]; then
    deluser app
    addgroup -g ${APP_GID} app
    adduser -D -S -s /sbin/nologin -G app -u ${APP_UID} -G app app
    UID=${APP_UID}
    GID=${APP_GID}
fi

### app-dir
mkdir -p ${APP_DIR}
