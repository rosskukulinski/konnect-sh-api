#!/bin/bash

SERVICE_VERSION_ID=83792720-e784-4e7a-99ac-7d347920fa40
FILENAME=Petstore_oas2.yaml

SPEC=$(cat $FILENAME | jq -sR .)

if [ ${DOCUMENT_ID} != null ]
then
	echo "Deleting current document id: ${DOCUMENT_ID}"
        curl -s -H "Authorization: Bearer ${DECK_KONNECT_TOKEN}" -X DELETE https://us.api.konghq.com/konnect-api/api/service_versions/${SERVICE_VERSION_ID}/documents/${DOCUMENT_ID}
	"Successfully deleted ${DOCUMENT_ID} from Service version id ${SERVICE_VERSION_ID}"
fi

echo "Uploading spec ($FILENAME) to Service Version $SERVICE_VERSION_ID"

generate_document_data()
{
    cat <<EOF
{
    "published": "true",
    "path": "/$FILENAME",
    "content": ${SPEC}
}
EOF
}

curl -s -H "Authorization: Bearer ${DECK_KONNECT_TOKEN}" -X POST https://us.api.konghq.com/konnect-api/api/service_versions/${SERVICE_VERSION_ID}/documents \
    -H 'Content-Type: application/json' \
    -d "$(generate_document_data)" > /dev/null

echo "Successfully uploaded spec ($FILENAME) to Service Version $SERVICE_VERSION_ID"
