ARG APP_VERSION=stable
ARG APP_PREFIX=""
ARG APP_SUFFIX=""

# :: Build / styles
  FROM alpine/git AS styles
  ARG APP_NO_CACHE
  RUN set -ex; \
    git clone https://github.com/11notes/pykms-frontend.git; \
    cd /git/pykms-frontend;

# :: Header
  FROM 11notes/kms:${APP_PREFIX}${APP_VERSION}${APP_SUFFIX}

  # :: arguments
    ARG TARGETARCH
    ARG APP_IMAGE
    ARG APP_NAME
    ARG APP_VERSION
    ARG APP_ROOT
    ARG APP_UID
    ARG APP_GID

  # :: environment
    ENV APP_IMAGE=${APP_IMAGE}
    ENV APP_NAME=${APP_NAME}
    ENV APP_VERSION=${APP_VERSION}
    ENV APP_ROOT=${APP_ROOT}

    ENV KMS_GUI_STYLE="custom-icon"

    ENV PYKMS_SQLITE_DB_PATH=/kms/var/kms.db
    ENV PYKMS_LICENSE_PATH=/opt/py-kms/LICENSE
    ENV PYKMS_VERSION_PATH=/opt/py-kms/VERSION
    ENV PORT=3000
    ENV LOG_LEVEL=INFO

  # :: multi-stage
    COPY ./LICENSE /opt/py-kms

  # :: Run
  USER root
  RUN eleven printenv;

  # :: install application
    RUN set -ex; \
      apk --no-cache --update --virtual .build add \
        py3-pip;

    RUN set -ex; \
      mkdir -p ${APP_ROOT}/var; \
      cd /opt/py-kms; \
      echo "${APP_VERSION}" > VERSION; \
      echo "master" >> VERSION; \
      pip3 install --no-cache-dir -r /opt/py-kms/requirements.gui.txt --break-system-packages; \
      apk del --no-network .build;

  # :: copy filesystem changes
    COPY ./rootfs /      

  # :: add multi template option
    RUN set -ex; \
      mkdir -p ${APP_ROOT}/styles/py-kms; \
      mkdir -p ${APP_ROOT}/styles/custom-icon; \
      cp -R /opt/py-kms/templates ${APP_ROOT}/styles/py-kms; \
      cp -R /opt/py-kms/static ${APP_ROOT}/styles/py-kms; \
      rm -rf /opt/py-kms/templates; \
      rm -rf /opt/py-kms/static;
    
    COPY --from=styles /git/pykms-frontend/templates ${APP_ROOT}/styles/custom-icon/templates
    COPY --from=styles /git/pykms-frontend/static ${APP_ROOT}/styles/custom-icon/static

  # :: set correct permissions
    RUN set -ex; \
      chmod +x -R /usr/local/bin; \
      chown -R ${APP_UID}:${APP_GID} \
        ${APP_ROOT} \
        /opt/py-kms;

# :: Monitor
  HEALTHCHECK --interval=5s --timeout=2s CMD curl -X GET -kILs --fail http://localhost:${PORT}/livez || exit 1

# :: Start
  USER docker