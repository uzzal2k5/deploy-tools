#!/usr/bin/env bash
set -ex
SCRIPTS="/tmp/deploy/scripts"
find ${SCRIPTS} -type f -name "*.sh" -exec chmod +x {} + && \
    ${SCRIPTS}/main.sh && \
    rm -rf ${SCRIPTS}