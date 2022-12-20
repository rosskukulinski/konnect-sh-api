#!/bin/bash


SERVICE_ID=122abd40-9a2a-420f-9417-83e3d1060db8
FILENAME=PetStore.md

DOCUMENT=$(cat $FILENAME | jq -sR .)

echo "Uploading Petstore.md to Service $SERVICE_ID"

generate_document_data()
{
    cat <<EOF
{
    "published": "true",
    "path": "/$FILENAME",
    "content": ${DOCUMENT}
}
EOF
}

curl -s -H "Authorization: Bearer ${DECK_KONNECT_TOKEN}" -X POST https://us.api.konghq.com/konnect-api/api/service_packages/${SERVICE_ID}/documents \
    -H 'Content-Type: application/json' \
    -d "$(generate_document_data)" > /dev/null

echo "Succesfully uploaded $FILENAME to Service $SERVICE_ID"

