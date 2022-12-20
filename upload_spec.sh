#!/bin/bash

SERVICE_VERSION_ID=83792720-e784-4e7a-99ac-7d347920fa40
FILENAME=PetStore_oas2.yaml

SPEC=$(cat $FILENAME | jq -sR .)

echo "Uploading spec ($FILENAME) to Service Version $SERVICE_VERSION_ID"

generate_document_data()
{
    cat <<EOF
{
    "published": "true",
    "path": "/Petstore_oas2.yaml",
    "content": ${SPEC}
}
EOF
}

curl -s -H "Authorization: Bearer ${DECK_KONNECT_TOKEN}" -X POST https://us.api.konghq.com/konnect-api/api/service_versions/${SERVICE_VERSION_ID}/documents \
    -H 'Content-Type: application/json' \
    -d "$(generate_document_data)" > /dev/null

echo "Successfully uploaded spec ($FILENAME) to Service Version $SERVICE_VERSION_ID"