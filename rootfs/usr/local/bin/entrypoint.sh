#!/bin/ash
  if [ -z "${1}" ]; then
    cd /opt/py-kms
    set -- "gunicorn" \
      --log-level INFO \
      pykms_WebUI:app

    eleven log start
  fi

  exec "$@"