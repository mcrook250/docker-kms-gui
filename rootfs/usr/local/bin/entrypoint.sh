#!/bin/ash
  if [ -z "${1}" ]; then

    if [ ! -z "${DEBUG}" ]; then
      LOG_LEVEL="DEBUG"
      eleven log debug "setting kms-gui log level to DEBUG"
    fi

    cd /opt/py-kms
    set -- "gunicorn" \
      --log-level ${LOG_LEVEL} \
      pykms_WebUI:app

    eleven log start
  fi

  exec "$@"