#!/bin/bash

SERVICE_ID=122abd40-9a2a-420f-9417-83e3d1060db8
curl -s -H "Authorization: Bearer ${DECK_KONNECT_TOKEN}" -X GET https://us.api.konghq.com/konnect-api/api/service_packages/${SERVICE_ID}/documents | jq