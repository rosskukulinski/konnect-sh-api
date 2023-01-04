#!/bin/bash

# SERVICE_NAME must match exact kong.service.name entity
SERVICE_NAME=${KONG_SERVICE_NAME}
DOC_FILEPATH=${MARDOWN_FILEPATH}
MARKDOWN_DOCUMENT=$(cat ${DOC_FILEPATH} | jq -sR .)

echo "Get service id by service name"
SERVICE_ID=$(curl -s -H "Authorization: Bearer ${KONNECT_TOKEN}" -X GET https://us.api.konghq.com/konnect-api/api/service_packages | jq -r --arg name "${SERVICE_NAME}" '.data | .[] | select(.name == $name).id')
echo -e "Successfully get service id ${SERVICE_ID} for service name ${SERVICE_NAME}\n"

MARKDOWN_DOCUMENT_ID=$(curl -s -H "Authorization: Bearer ${KONNECT_TOKEN}" -X GET https://us.api.konghq.com/konnect-api/api/service_packages/${SERVICE_ID}/documents | jq -r '.data | .[0] | .id')
echo "Current markdown document id: ${MARKDOWN_DOCUMENT_ID}"

if [ ${MARKDOWN_DOCUMENT_ID} != null ]
then
       echo "Deleting current document id: ${MARKDOWN_DOCUMENT_ID}"
       curl -s -H "Authorization: Bearer ${KONNECT_TOKEN}" -X DELETE https://us.api.konghq.com/konnect-api/api/service_packages/${SERVICE_ID}/documents/${MARKDOWN_DOCUMENT_ID}
       echo -e "Successfully deleted ${MARKDOWN_DOCUMENT_ID} from service id ${SERVICE_ID}\n"
fi

echo "Uploading ${DOC_FILEPATH} to Service ${SERVICE_ID}"

generate_document_data()
{
    cat <<EOF
{
    "published": "true",
    "path": "/${DOC_FILEPATH}",
    "content": ${MARKDOWN_DOCUMENT}
}
EOF
}

curl -s -H "Authorization: Bearer ${KONNECT_TOKEN}" -X POST https://us.api.konghq.com/konnect-api/api/service_packages/${SERVICE_ID}/documents \
    -H 'Content-Type: application/json' \
    -d "$(generate_document_data)" > /dev/null

echo -e "Successfully uploaded ${DOC_FILEPATH} to Service $SERVICE_ID\n"

