#!/usr/bin/env bash
set -ex
REMOTE_DIR_DEFAULT=/tmp
REMOTE_DIR=$REMOTE_DIR_DEFAULT
SCRIPTS="$REMOTE_DIR/deploy/scripts"

find ${SCRIPTS} -type f -name "*.sh" -exec chmod +x {} + && \
    ${SCRIPTS}/main.sh && \
    rm -rf ${SCRIPTS}