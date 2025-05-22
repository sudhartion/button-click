#!/bin/sh

echo "$(terraform show -json | jq --raw-output '.values.root_module.resources[] | select( .name == "button-click-server" ).values.id')"
