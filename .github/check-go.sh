#!/bin/sh

files=$(gofmt -l .)
if [ -n "${files}" ]; then
  echo "${files}"
  return 1
fi
