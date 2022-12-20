#!/bin/bash

SERVICE_ID=122abd40-9a2a-420f-9417-83e3d1060db8
# Get Active document ID, store in $DOCUMENT_ID

echo "Getting current document id for Service Package: ${SERVICE_ID}"

DOCUMENT_ID=$(curl -s -H "Authorization: Bearer ${DECK_KONNECT_TOKEN}" -X GET https://us.api.konghq.com/konnect-api/api/service_packages/${SERVICE_ID}/documents | jq -r '.data | .[0] | .id')

echo "Current document id: ${DOCUMENT_ID}"

# Delete the document

curl -s -H "Authorization: Bearer ${DECK_KONNECT_TOKEN}" -X DELETE https://us.api.konghq.com/konnect-api/api/service_packages/${SERVICE_ID}/documents/${DOCUMENT_ID}