#!/bin/ash
  if [ -z "${1}" ]; then

    if [ ! -z "${DEBUG}" ]; then
      LOG_LEVEL="DEBUG"
      eleven log debug "setting kms-gui log level to DEBUG"
    fi

    # apply correct style
    rm -rf /opt/py-kms/templates
    TEMPLATE_DIR=${APP_ROOT}/.default/templates
    case ${KMS_GUI_STYLE} in
      py-kms)
        ln -s ${TEMPLATE_DIR}/py-kms /opt/py-kms/templates
        eleven log info "using ${KMS_GUI_STYLE} GUI style"
      ;;
      *)
        ln -s ${TEMPLATE_DIR}/custom-icon /opt/py-kms/templates
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