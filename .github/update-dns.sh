#!/bin/sh
set -eu

curl "https://www.duckdns.org/update?domains=sudhartion&token=${DUCKDNS_TOKEN}&ip=" \
  -o "./duckdns.log.$(date +%s)"
