![banner](https://github.com/11notes/defaults/blob/main/static/img/banner.png?raw=true)

### THIS IS A WORK IN PROGRESS ###

# KMS-GUI
[<img src="https://img.shields.io/badge/github-source-blue?logo=github&color=040308">](https://github.com/11notes/docker-KMS-GUI)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)![size](https://img.shields.io/docker/image-size/11notes/kms-gui/latest?color=0eb305)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)![version](https://img.shields.io/docker/v/11notes/kms-gui/latest?color=eb7a09)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)![pulls](https://img.shields.io/docker/pulls/11notes/kms-gui?color=2b75d6)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)[<img src="https://img.shields.io/github/issues/11notes/docker-KMS-GUI?color=7842f5">](https://github.com/11notes/docker-KMS-GUI/issues)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)![swiss_made](https://img.shields.io/badge/Swiss_Made-FFFFFF?labelColor=FF0000&logo=data:image/svg%2bxml;base64,PHN2ZyB2ZXJzaW9uPSIxIiB3aWR0aD0iNTEyIiBoZWlnaHQ9IjUxMiIgdmlld0JveD0iMCAwIDMyIDMyIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGQ9Im0wIDBoMzJ2MzJoLTMyeiIgZmlsbD0iI2YwMCIvPjxwYXRoIGQ9Im0xMyA2aDZ2N2g3djZoLTd2N2gtNnYtN2gtN3YtNmg3eiIgZmlsbD0iI2ZmZiIvPjwvc3ZnPg==)

Activate any version of Windows and Office, forever

![Web GUI](https://github.com/mcrook250/docker-KMS-GUI/blob/master/img/kms-dash1.jpg?raw=true)

# SYNOPSIS 📖
**What can I do with this?** This image will run a web GUI for your [mcrook250/ms-kms](https://hub.docker.com/r/mcrook250/ms-kms) server. Why was this created? Because the upstream loser 11notes likes to leave breaking bugs in his code, this one here "Error 0x2a 0x80070216" has been fixed in this release and a new UI with tons of new features!

# COMPOSE ✂️
```yaml
name: "kms"
services:
  kms:
    image: "mcrook250/ms-kms:1.0.0"
    environment:
      TZ: "Canada/Mountain"
    volumes:
      - "var:/kms/var"
    ports:
      - "1688:1688/tcp"
    restart: "always"

  gui:
    image: "mcrook250/kms-gui:1.0.0"
    depends_on:
      app:
        condition: "service_healthy"
        restart: true
    environment:
      TZ: "Canada/Mountain"
    volumes:
      - "var:/kms/var"
    ports:
      - "3000:3000/tcp"
    restart: "always"

volumes:
  var:
```

# DEFAULT SETTINGS 🗃️
| Parameter | Value | Description |
| --- | --- | --- |
| `user` | docker | user name |
| `uid` | 1000 | [user identifier](https://en.wikipedia.org/wiki/User_identifier) |
| `gid` | 1000 | [group identifier](https://en.wikipedia.org/wiki/Group_identifier) |
| `home` | /kms | home directory of user docker |

# ENVIRONMENT 📝
| Parameter | Value | Default |
| --- | --- | --- |
| `TZ` | [Time Zone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) | |
| `DEBUG` | Will activate debug option for container image and app (if available) | |
| `KMS_GUI_STYLE` | switch the UI style of the webinterface (py-kms, custom-icon) | custom-icon |

# MAIN TAGS 🏷️
These are the main tags for the image. There is also a tag for each commit and its shorthand sha256 value.

* [latest](https://hub.docker.com/r/11notes/kms-gui/tags?name=latest)
* [latest-unraid](https://hub.docker.com/r/11notes/kms-gui/tags?name=latest-unraid)

# REGISTRIES ☁️
```
docker pull 11notes/kms-gui:latest
docker pull ghcr.io/11notes/kms-gui:latest
docker pull quay.io/11notes/kms-gui:latest
```

# UNRAID VERSION 🟠
This image supports unraid by default. Simply add **-unraid** to any tag and the image will run as 99:100 instead of 1000:1000 causing no issues on unraid. Enjoy.

# SOURCE 💾
* [11notes/kms-gui](https://github.com/11notes/docker-KMS-GUI)

# PARENT IMAGE 🏛️
* [11notes/kms](${{ json_readme_parent_url }})

# BUILT WITH 🧰
* [11notes/fork-pykms-frontend](https://github.com/11notes/fork-pykms-frontend)
* [11notes/util](https://github.com/11notes/docker-util)

# GENERAL TIPS 📌
> [!TIP]
>* Use a reverse proxy like Traefik, Nginx, HAproxy to terminate TLS and to protect your endpoints
>* Use Let’s Encrypt DNS-01 challenge to obtain valid SSL certificates for your services

# ElevenNotes™️
This image is provided to you at your own risk. Always make backups before updating an image to a different version. Check the [releases](https://github.com/11notes/docker-kms-gui/releases) for breaking changes. If you have any problems with using this image simply raise an [issue](https://github.com/11notes/docker-kms-gui/issues), thanks. If you have a question or inputs please create a new [discussion](https://github.com/11notes/docker-kms-gui/discussions) instead of an issue. You can find all my other repositories on [github](https://github.com/11notes?tab=repositories).

*created 21.05.2025, 08:54:36 (CET)*
