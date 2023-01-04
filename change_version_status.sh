#!/bin/bash

SERVICE_VERSION_ID=05f9d96a-1d3a-4d75-bc28-a0de92a1f8a0

# publish_status can be "published" or "unpublished"
generate_document_data()
{
    cat <<EOF
{
    "publish_status": "unpublished"
}
EOF
}

curl -s -H "Authorization: Bearer ${DECK_KONNECT_TOKEN}" -X PATCH https://us.api.konghq.com/konnect-api/api/service_versions/${SERVICE_VERSION_ID} \
    -H 'Content-Type: application/json' \
    -d "$(generate_document_data)" > /dev/null

echo "Successfully changed published status of Service Version $SERVICE_VERSION_ID"
