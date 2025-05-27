#!/bin/sh
set -eu

DEST="$1"
echo "${SERVER_CERT_KEY}" >"${DEST}"
chmod 600 "${DEST}"
