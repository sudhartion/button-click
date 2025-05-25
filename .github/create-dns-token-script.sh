#!/bin/sh
set -eu

DEST="$1"
echo "export DUCKDNS_TOKEN=${DUCKDNS_TOKEN}" >"${DEST}"
