ARG APP_VERSION=stable

# :: Header
  FROM 11notes/kms:${APP_VERSION}

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

    ENV PYKMS_SQLITE_DB_PATH=/kms/var/kms.db
    ENV PYKMS_LICENSE_PATH=/opt/py-kms/LICENSE
    ENV PYKMS_VERSION_PATH=/opt/py-kms/VERSION
    ENV PORT=8080
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

  # :: copy filesystem changes and set correct permissions
    COPY ./rootfs /
    RUN set -ex; \
      chmod +x -R /usr/local/bin; \
      chown -R 1000:1000 \
        ${APP_ROOT} \
        /opt/py-kms;

  # :: support unraid
    RUN set -ex; \
      eleven unraid

# :: Monitor
  HEALTHCHECK --interval=5s --timeout=2s CMD curl -X GET -kILs --fail http://localhost:${PORT}/livez || exit 1

# :: Start
  USER docker