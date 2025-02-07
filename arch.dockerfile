# :: Util
  FROM alpine AS util

  ARG NO_CACHE

  RUN set -ex; \
    apk --no-cache --update add \
      git; \
    git clone https://github.com/11notes/docker-util.git;

# :: Build / redis
  FROM python:3.12-alpine AS build

  ARG TARGETARCH
  ARG APP_VERSION

  USER root

  RUN set -ex; \
    apk --update --no-cache add \
      git; \
    mkdir -p /opt/py-kms-gui; \
    git clone https://github.com/Py-KMS-Organization/py-kms.git; \
    cd /py-kms/py-kms; \
    git checkout ${APP_VERSION}; \
    cp -R /py-kms/py-kms/* /opt/py-kms-gui; \
    cp -R /py-kms/docker/docker-py3-kms/requirements.txt /opt/py-kms-gui;

# :: Header
  FROM 11notes/alpine:stable

  # :: arguments
    ARG TARGETARCH
    ARG APP_IMAGE
    ARG APP_NAME
    ARG APP_VERSION
    ARG APP_ROOT

  # :: environment
    ENV APP_IMAGE=${APP_IMAGE}
    ENV APP_NAME=${APP_NAME}
    ENV APP_VERSION=${APP_VERSION}
    ENV APP_ROOT=${APP_ROOT}

    ENV PYKMS_SQLITE_DB_PATH=/kms/var/kms.db
    ENV PYKMS_LICENSE_PATH=/opt/py-kms-gui/LICENSE
    ENV PYKMS_VERSION_PATH=/opt/py-kms-gui
    ENV PORT=8080

  # :: multi-stage
    COPY --from=util /docker-util/src/ /usr/local/bin
    COPY --from=build /opt/py-kms-gui/ /opt/py-kms-gui
    COPY ./LICENSE /opt/py-kms-gui

  # :: Run
  USER root

  # :: install application
    RUN set -ex; \
      apk --no-cache --update add \
        python3=3.12.8-r1; \
      apk --no-cache --update --virtual .build add \
        py3-pip;

    RUN set -ex; \
      mkdir -p ${APP_ROOT}/var; \
      cd /opt/py-kms-gui; \
      pip3 install --no-cache-dir -r /opt/py-kms-gui/requirements.txt --break-system-packages; \
      apk del --no-network .build;

  # :: copy filesystem changes and set correct permissions
    COPY ./rootfs /
    RUN set -ex; \
      chmod +x -R /usr/local/bin; \
      chown -R 1000:1000 \
        ${APP_ROOT};

# :: Volumes
  VOLUME ["${APP_ROOT}/var"]

# :: Monitor
  HEALTHCHECK --interval=5s --timeout=2s CMD curl -X GET -kILs --fail http://localhost:${PORT}/livez || exit 1

# :: Start
  USER docker