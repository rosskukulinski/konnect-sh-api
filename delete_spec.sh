#!/bin/bash

SERVICE_VERSION_ID=83792720-e784-4e7a-99ac-7d347920fa40
# Get Active document ID, store in $DOCUMENT_ID

echo "Getting current document id for Service Package: ${SERVICE_ID}"

DOCUMENT_ID=$(curl -s -H "Authorization: Bearer ${DECK_KONNECT_TOKEN}" -X GET https://us.api.konghq.com/konnect-api/api/service_versions/${SERVICE_VERSION_ID}/documents | jq -r '.data | .[0] | .id')

echo "Current document id: ${DOCUMENT_ID}"

# Delete the document

curl -s -H "Authorization: Bearer ${DECK_KONNECT_TOKEN}" -X DELETE https://us.api.konghq.com/konnect-api/api/service_versions/${SERVICE_VERSION_ID}/documents/${DOCUMENT_ID}