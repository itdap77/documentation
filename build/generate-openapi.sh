#!/bin/bash
set -euxo pipefail

mkdir -p specs
for path in core apps/cloud_federation_api apps/dashboard apps/dav apps/files_sharing apps/oauth2 apps/provisioning_api apps/settings apps/theming apps/user_status apps/weather_status; do
  ./openapi-extractor/openapi-extractor "server/$path" "specs/$(echo $path | rev | cut -d "/" -f -1 | rev).json"
done

./openapi-extractor/merge-specs \
  --core specs/core.json \
  --merged ../developer_manual/_static/openapi.json \
  specs/cloud_federation_api.json \
  specs/dashboard.json \
  specs/dav.json \
  specs/files_sharing.json \
  specs/oauth2.json \
  specs/provisioning_api.json \
  specs/settings.json \
  specs/theming.json \
  specs/user_status.json \
  specs/weather_status.json
