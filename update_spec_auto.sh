#!/bin/bash

# SERVICE_NAME must match exact kong.service.name entity
SERVICE_NAME=${KONG_SERVICE_NAME}
SPEC_FILEPATH=${SWAGGER_FILEPATH}

echo "Get service id by service name"
SERVICE_ID=$(curl -s -H "Authorization: Bearer ${KONNECT_TOKEN}" -X GET https://us.api.konghq.com/konnect-api/api/service_packages | jq -r --arg name "${SERVICE_NAME}" '.data | .[] | select(.name == $name).id')
echo -e "Successfully get service id ${SERVICE_ID} for service name ${SERVICE_NAME}\n"


echo "Get service version id by service id"
SERVICE_VERSION_ID=$(curl -s -H "Authorization: Bearer ${KONNECT_TOKEN}" -X GET https://us.api.konghq.com/konnect-api/api/service_packages/${SERVICE_ID} | jq -r '.versions | .[] | .id')
echo -e "Successfully get service version id ${SERVICE_VERSION_ID} for service id ${SERVICE_ID}\n"

SPEC_DOCUMENT_ID=$(curl -s -H "Authorization: Bearer ${KONNECT_TOKEN}" -X GET https://us.api.konghq.com/konnect-api/api/service_versions/${SERVICE_VERSION_ID}/documents | jq -r '.data | .[0] | .id')
echo "Current spec document id: ${SPEC_DOCUMENT_ID}"

SPEC_DOCUMENT=$(cat ${SPEC_FILEPATH} | jq -sR .)

if [ ${SPEC_DOCUMENT_ID} != null ]
then
       echo "Deleting current document id: ${SPEC_DOCUMENT_ID}"
       curl -s -H "Authorization: Bearer ${KONNECT_TOKEN}" -X DELETE https://us.api.konghq.com/konnect-api/api/service_versions/${SERVICE_VERSION_ID}/documents/${DOCUMENT_ID}
       echo "Successfully deleted ${SPEC_DOCUMENT_ID} to Service version id ${SERVICE_VERSION_ID}\n"
fi

echo "Uploading spec ${SPEC_FILEPATH} to Service Version $SERVICE_VERSION_ID"

generate_document_data()
{
    cat <<EOF
{
    "published": "true",
    "path": "/${SPEC_FILEPATH}",
    "content": ${SPEC_DOCUMENT}
}
EOF
}

curl -s -H "Authorization: Bearer ${KONNECT_TOKEN}" -X POST https://us.api.konghq.com/konnect-api/api/service_versions/${SERVICE_VERSION_ID}/documents \
    -H 'Content-Type: application/json' \
    -d "$(generate_document_data)" > /dev/null

echo -e "Successfully uploaded spec ${SPEC_FILEPATH} to Service Version $SERVICE_VERSION_ID}\n"
