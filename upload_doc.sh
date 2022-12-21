#!/bin/bash


SERVICE_ID=122abd40-9a2a-420f-9417-83e3d1060db8
FILENAME=Petstore.md

DOCUMENT=$(cat $FILENAME | jq -sR .)

DOCUMENT_ID=$(curl -s -H "Authorization: Bearer ${DECK_KONNECT_TOKEN}" -X GET https://us.api.konghq.com/konnect-api/api/service_packages/${SERVICE_ID}/documents | jq -r '.data | .[0] | .id')

if [ ${DOCUMENT_ID} != null ]
then
       echo "Deleting current document id: ${DOCUMENT_ID}"
       curl -s -H "Authorization: Bearer ${DECK_KONNECT_TOKEN}" -X DELETE https://us.api.konghq.com/konnect-api/api/service_packages/${SERVICE_ID}/documents/${DOCUMENT_ID}
       echo "Successfully deleted ${DOCUMENT_ID} from service id ${SERVICE_ID}"
fi


echo "Uploading ${FILENAME} to Service $SERVICE_ID"

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

echo "Successfully uploaded $FILENAME to Service $SERVICE_ID"

