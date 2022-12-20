#!/bin/bash

# Lists all of the Service Packages you have access to

curl -s -H "Authorization: Bearer ${DECK_KONNECT_TOKEN}" -X GET https://us.api.konghq.com/konnect-api/api/service_packages | jq