![Banner](https://github.com/11notes/defaults/blob/main/static/img/banner.png?raw=true)

# 🏔️ kms-gui on Alpine
[<img src="https://img.shields.io/badge/github-source-blue?logo=github&color=040308">](https://github.com/11notes/docker-kms-gui)![size](https://img.shields.io/docker/image-size/11notes/kms-gui/646f476?color=0eb305)![version](https://img.shields.io/docker/v/11notes/kms-gui/646f476?color=eb7a09)![pulls](https://img.shields.io/docker/pulls/11notes/kms-gui?color=2b75d6)[<img src="https://img.shields.io/github/issues/11notes/docker-kms-gui?color=7842f5">](https://github.com/11notes/docker-kms-gui/issues)

**Activate any version of Windows and Office, forever**

![slmgr](https://github.com/11notes/docker-kms-gui/blob/main/GUI.png?raw=true)

# SYNOPSIS 📖
**What can I do with this?** This image will run a web GUI for your [11notes/kms](https://hub.docker.com/r/11notes/kms) server.

# COMPOSE ✂️
```yaml
name: "kms"
services:
  kms:
    image: "11notes/kms:latest"
    container_name: "kms"
    environment:
      TZ: Europe/Zurich
    volumes:
      - "var:/kms/var"
    ports:
      - "1688:1688/tcp"
    restart: always
  kms-gui:
    image: "11notes/kms-gui:646f476"
    container_name: "kms-gui"
    environment:
      TZ: Europe/Zurich
    volumes:
      - "var:/kms/var"
    ports:
      - "8080:8080/tcp"
    restart: always
volumes:
  var:
```

# ENVIRONMENT 📝
| Parameter | Value | Default |
| --- | --- | --- |
| `TZ` | [Time Zone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) | |
| `DEBUG` | Show debug messages from image **not** app | |

# SOURCE 💾
* [11notes/kms-gui](https://github.com/11notes/docker-kms-gui)

# PARENT IMAGE 🏛️
* [11notes/kms:646f476](https://hub.docker.com/r/11notes/kms)

# BUILT WITH 🧰
* [py-kms](https://github.com/Py-KMS-Organization/py-kms)
* [alpine](https://alpinelinux.org)

# TIPS 📌
* Use a reverse proxy like Traefik, Nginx, HAproxy to terminate TLS with a valid certificate
* Use Let’s Encrypt certificates to protect your SSL endpoints
  
# ElevenNotes™️
This image is provided to you at your own risk. Always make backups before updating an image to a different version. Check the [releases](https://github.com/11notes/docker-kms-gui/releases) for breaking changes. If you have any problems with using this image simply raise an [issue](https://github.com/11notes/docker-kms-gui/issues), thanks . You can find all my repositories on [github](https://github.com/11notes?tab=repositories).