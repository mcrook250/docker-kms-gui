![banner](https://github.com/mcrook250/docker-kms-gui/blob/master/img/banner.png?raw=true)

### THIS IS A WORK IN PROGRESS ###

# KMS-GUI
[<img src="https://img.shields.io/badge/github-source-blue?logo=github&color=040308">](https://github.com/mcrook250/docker-KMS-GUI)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)![size](https://img.shields.io/docker/image-size/mcrook250/kms-gui/latest?color=0eb305)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)![version](https://img.shields.io/docker/v/mcrook250/kms-gui/latest?color=eb7a09)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)![pulls](https://img.shields.io/docker/pulls/mcrook250/kms-gui?color=2b75d6)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)[<img src="https://img.shields.io/github/issues/mcrook250/docker-KMS-GUI?color=7842f5">](https://github.com/mcrook250/docker-KMS-GUI/issues)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)![swiss_made](https://img.shields.io/badge/Made_in_Canada-FFFFFF?labelColor=FFBBBB&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABcAAAAMCAMAAAC+5dbKAAAAOVBMVEXfYVj++/vVKx7////gYFbrmZLtpaDeWU788vH5393vrqnrm5XpkYvlfnbhZl3aRDjWLiLzxcHql5HXmJcOAAAAAnRSTlP5/XDhGW0AAABXSURBVBjTbc1LDoAwCATQiqX03+r9D2sLJibgLIbkLRgHO+78IiLtWW5urzwhYPrxuG40HhoOGNiC8gKSory+XvX/PNedwe52Iupmd+fitp6NO5aDW+QBA2oDkd/yfEsAAAAASUVORK5CYII=)

Activate any version of Windows and Office, forever

![Web GUI](https://github.com/mcrook250/docker-KMS-GUI/blob/master/img/kms-dash1.jpg?raw=true)
![Web GUI](https://github.com/mcrook250/docker-KMS-GUI/blob/master/img/kms-dash2.jpg?raw=true)
![Web GUI](https://github.com/mcrook250/docker-KMS-GUI/blob/master/img/kms-dash3.jpg?raw=true)



### NEW FEATURES
##### kms-auto-purge service
![Web GUI](https://github.com/mcrook250/docker-KMS-GUI/blob/master/img/kms-auto-purge.png?raw=true)

##### kms delete button
![Web GUI](https://github.com/mcrook250/docker-KMS-GUI/blob/master/img/kms-delete.png?raw=true)


# SYNOPSIS 📖
**What can I do with this?** This image will run a web GUI for your [mcrook250/ms-kms](https://hub.docker.com/r/mcrook250/ms-kms) server. Why was this created? Because the upstream loser 11notes likes to leave breaking bugs in his code, this one here "Error 0x2a 0x80070216" has been fixed in this release and a new UI with tons of new features!

# COMPOSE ✂️
```yaml
name: "kms"
services:
  kms:
    image: "mcrook250/ms-kms:latest"
    environment:
      TZ: "Canada/Mountain"
      AUTO_PURGE: "True"
    volumes:
      - "var:/kms/var"
    ports:
      - "1688:1688/tcp"
    restart: "always"

  gui:
    image: "mcrook250/kms-gui:latest"
    depends_on:
      app:
        condition: "service_healthy"
        restart: true
    environment:
      ENABLE_DEL: "False"
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
| `KMS_GUI_STYLE` | switch the UI style of the webinterface (py-kms, custom-icon, MSUI) | MSUI |
| `ENABLE_DEL` | enables the delete function in the webUI | False |

** The KMS_GUI_STYLE is locked for now as I build more themes and include the originals

# MAIN TAGS 🏷️
These are the main tags for the image. There is also a tag for each commit and its shorthand sha256 value.

* [latest](https://hub.docker.com/r/mcrook250/docker-kms-gui/tags?name=latest)
* [latest-unraid](https://hub.docker.com/r/mcrook250/docker-kms-gui/tags?name=latest-unraid) *not needed

# REGISTRIES ☁️
```
docker pull mcrook250/kms-gui:latest
docker pull ghcr.io/11notes/kms-gui:latest <-- not used anymore
docker pull quay.io/11notes/kms-gui:latest <-- not used anymore
```

# UNRAID VERSION 🟠
This image supports unraid by default. Simply add **-unraid** to any tag and the image will run as 99:100 instead of 1000:1000 causing no issues on unraid. Enjoy.
*no longer needed as this was fixed in a first release

# SOURCE 💾
* [mcrook250/kms-gui](https://github.com/mcrook250/docker-KMS-GUI)

# PARENT IMAGE 🏛️
* [mcrook250/kms](https://github.com/mcrook250/ms-kms)

# BUILT WITH 🧰
* [mcrook250/fork-pykms-frontend](https://github.com/mcrook250/fork-pykms-frontend)


# GENERAL TIPS 📌
> [!TIP]
>* Use a reverse proxy like Traefik, Nginx, HAproxy to terminate TLS and to protect your endpoints
>* Use Let’s Encrypt DNS-01 challenge to obtain valid SSL certificates for your services

# BlueWave™️
This image is provided to you at your own risk. Always make backups before updating an image to a different version. Check the [releases](https://github.com/mcrook250/docker-kms-gui/releases) for breaking changes. If you have any problems with using this image simply raise an [issue](https://github.com/11notes/docker-kms-gui/issues), thanks. If you have a question or inputs please create a new [discussion](https://github.com/mcrook250/docker-kms-gui/discussions) instead of an issue. You can find all my other repositories on [github](https://github.com/mcrook250?tab=repositories).

*created 21.05.2025, 08:54:36 (CET)*
