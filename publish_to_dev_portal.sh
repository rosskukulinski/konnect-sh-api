#!/bin/bash

ORGANIZATION=KONG
# SERVICE_NAME must match exact kong.service.name entity
SERVICE_NAME=${KONG_SERVICE_NAME}

echo "Get service id by service name"

SERVICE_ID=$(curl -s -H "Authorization: Bearer ${KONNECT_TOKEN}" -X GET https://us.api.konghq.com/konnect-api/api/service_packages | jq -r --arg name "${SERVICE_NAME}" '.data | .[] | select(.name == $name).id')

echo -e "Successfully get service id ${SERVICE_ID} from service name ${SERVICE_NAME}\n"

echo "Get portal id for ${ORGANIZATION} portal"

PORTAL_ID=$(curl -s -H "Authorization: Bearer ${KONNECT_TOKEN}" -X GET https://us.api.konghq.com/konnect-api/api/portals | jq -r '.data | .[] | .id')

echo -e "Successfully get portal id ${PORTAL_ID} for ${ORGANIZATION} portal\n"

echo "Publish service name ${SERVICE_NAME} to portal id ${PORTAL_ID} for ${ORGANIZATION} portal"

curl -s -H "Authorization: Bearer ${KONNECT_TOKEN}" -X PUT https://us.api.konghq.com/konnect-api/api/service_packages/${SERVICE_ID}/portals/${PORTAL_ID} > /dev/null

echo -e "Successfully publish ${SERVICE_ID} to dev portal\n"
