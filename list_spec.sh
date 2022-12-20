#!/bin/bash

SERVICE_VERSION_ID=83792720-e784-4e7a-99ac-7d347920fa40
curl -s -H "Authorization: Bearer ${DECK_KONNECT_TOKEN}" -X GET https://us.api.konghq.com/konnect-api/api/service_versions/${SERVICE_VERSION_ID}/documents | jq