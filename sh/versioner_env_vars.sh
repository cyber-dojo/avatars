#!/bin/bash -Eeu

# - - - - - - - - - - - - - - - - - - - - - - - -
versioner_env_vars()
{
  docker run --rm cyberdojo/versioner:latest
  echo CYBER_DOJO_AVATARS_SHA="$(get_image_sha)"
  echo CYBER_DOJO_AVATARS_TAG="$(get_image_tag)"
  echo CYBER_DOJO_AVATARS_CLIENT_IMAGE=cyberdojo/avatars-client
  echo CYBER_DOJO_AVATARS_CLIENT_PORT=9999
  echo CYBER_DOJO_AVATARS_CLIENT_USER=nobody
  echo CYBER_DOJO_AVATARS_SERVER_USER=nobody
}

# - - - - - - - - - - - - - - - - - - - - - - - -
get_image_sha()
{
  echo "$(cd "${ROOT_DIR}" && git rev-parse HEAD)"
}

# - - - - - - - - - - - - - - - - - - - - - - - -
get_image_tag()
{
  local -r sha="$(get_image_sha)"
  echo "${sha:0:7}"
}
