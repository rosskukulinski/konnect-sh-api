# Kong Konnect "unofficial" APIs

Kong Konnect offers a suite of official APIs, as documented here: [https://docs.konghq.com/konnect/api/](https://docs.konghq.com/konnect/api/).

More official "v2" APIs are in-flight, including Runtime Group Configuration APIs (aka Gateway "Admin API") as well as APIs for Service Hub, Analytics, 
and Developer Portal.

However, to help customers who must build automation against the existing "v1" APIs, these scripts can be used to build automation for managing
Service Package markdown documentation & Service Version Open API Specs.

You will need a [Personal Access Token](https://docs.konghq.com/konnect/runtime-manager/runtime-groups/declarative-config/#generate-a-personal-access-token), as well as the Service Package ID (e.g. `https://cloud.konghq.com/us/servicehub/5bdf66c1-02a9-4ef5-b32f-7791c0f59be0/overview` --> `5bdf66c1-02a9-4ef5-b32f-7791c0f59be0`) and 
Service Version ID (e.g. `https://cloud.konghq.com/us/servicehub/5bdf66c1-02a9-4ef5-b32f-7791c0f59be0/versions/9fbeed10-6cf5-42b7-ad1f-6bbeed93d46b` --> `9fbeed10-6cf5-42b7-ad1f-6bbeed93d46b`).

**IMPORTANT NOTE: These APIs are not official and will be deprecated & removed once we ship v2 Service Hub APIs**

## list_services.sh

Gets the list of all the Service Packages you have access to

## list_service_versions.sh

Gets the list of all the service versions associated with a particular Service Package

## upload_doc.sh

If exist, remove the documentation associated with a particular Service Package and then uploads the markdown document, "Petstore.md" to the defined Service Package

## upload_spec.sh

If exist, remove the OpenAPI specification associated with a particular service version and then uploads the OpenAPI Spec, "Petstore_oas2.yaml" to the defined Service Version

## delete_doc.sh

Deletes the Documentation associated with a particular Service Package

## delete_spec.sh

Deletes the OpenAPI Specification associated with a particular Service Version

## list_doc.sh

Gets the documentation currently associated with a particular Service Package

## list_spec.sh

Gets the API spec currently associated with a particular Service Version

## download_doc.sh
Download the markdown document, to the defined Service Package

