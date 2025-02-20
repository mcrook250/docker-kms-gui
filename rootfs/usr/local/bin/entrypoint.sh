#!/bin/ash
  if [ -z "${1}" ]; then

    if [ ! -z "${DEBUG}" ]; then
      LOG_LEVEL="DEBUG"
      eleven log debug "setting kms-gui log level to DEBUG"
    fi

    # apply correct style
    rm -rf /opt/py-kms/templates
    rm -rf /opt/py-kms/static
    TEMPLATE_DIR=${APP_ROOT}/.default/styles
    case ${KMS_GUI_STYLE} in
      py-kms)
        ln -s ${TEMPLATE_DIR}/py-kms/templates /opt/py-kms/templates
        ln -s ${TEMPLATE_DIR}/py-kms/static /opt/py-kms/static
        eleven log info "using ${KMS_GUI_STYLE} GUI style"
      ;;
      *)
        ln -s ${TEMPLATE_DIR}/custom-icon/templates /opt/py-kms/templates
        ln -s ${TEMPLATE_DIR}/custom-icon/static /opt/py-kms/static
        eleven log info "using default GUI style"
      ;;
    esac

    cd /opt/py-kms
    set -- "gunicorn" \
      --log-level ${LOG_LEVEL} \
      pykms_WebUI:app

    eleven log start
  fi

  exec "$@"