Resilio Sync
===============

[![CircleCI](https://circleci.com/gh/oomathias/resilio-sync.svg?style=svg)](https://circleci.com/gh/oomathias/resilio-sync)
[![Docker Pulls](https://img.shields.io/docker/pulls/oomathias/resilio-sync.svg)](https://hub.docker.com/r/oomathias/resilio-sync/)
[![](https://images.microbadger.com/badges/image/oomathias/resilio-sync.svg)](https://microbadger.com/images/oomathias/resilio-sync "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/oomathias/resilio-sync.svg)](https://microbadger.com/images/oomathias/resilio-sync "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/commit/oomathias/resilio-sync.svg)](https://microbadger.com/images/oomathias/resilio-sync "Get your own commit badge on microbadger.com")
[![MIT Licence](https://badges.frapsoft.com/os/mit/mit.svg?v=103)](https://opensource.org/licenses/mit-license.php)  

# Docker image content

- Alpine based
- dumb-init. Why? [Look at this Yelp article](https://engineeringblog.yelp.com/2016/01/dumb-init-an-init-for-docker.html)
- glibc
- resilio-sync

# What's Resilio Sync?

Sync uses peer-to-peer technology to provide fast, private file sharing for teams and individuals. By skipping the cloud, transfers can be significantly faster because files take the shortest path between devices. Sync does not store your information on servers in the cloud, avoiding cloud privacy concerns.

# Usage

    docker-compose 
    
    Resilio:
      image: oomathias/resilio-sync
      privileged: true
      restart: always
      ports:
      - 8888:8888
      - 55555:55555
      volumes:
      - /mnt/sync:/mnt/sync
      dns:
      - 8.8.8.8
      - 223.6.6.6
      extra_hosts:
      - "config.getsync.com:54.230.143.112"
      - "config.resilio.com:54.230.143.112"
      - "config.usyncapp.com:54.230.143.112"

    docker 
    
    DATA_FOLDER=/path/to/data/folder/on/the/host
    WEBUI_PORT=[ port to access the webui on the host ]
    
    mkdir -p $DATA_FOLDER

    docker run -d --name Sync \
      -p 127.0.0.1:$WEBUI_PORT:8888 -p 55555 \
      -v $DATA_FOLDER:/mnt/sync \
      --restart on-failure \
      oomathias/resilio-sync

Go to localhost:$WEBUI_PORT in a web browser to access the webui.

#### LAN access

If you do not want to limit the access to the webui to localhost, run instead:

    docker run -d --name Sync \
      -p $WEBUI_PORT:8888 -p 55555 \
      -v $DATA_FOLDER:/mnt/sync \
      --restart on-failure \
      oomathias/resilio-sync

#### Extra directories

If you need to mount extra directories, mount them in /mnt/mounted_folders:

    docker run -d --name Sync \
      -p 127.0.0.1:$WEBUI_PORT:8888 -p 55555 \
      -v $DATA_FOLDER:/mnt/sync \
      -v <OTHER_DIR>:/mnt/mounted_folders/<DIR_NAME> \
      -v <OTHER_DIR2>:/mnt/mounted_folders/<DIR_NAME2> \
      --restart on-failure \
      oomathias/resilio-sync

Do not create directories at the root of mounted_folders from the Sync webui since this new folder will not be mounted on the host.

# Volume

* /mnt/sync - State files and Sync folders

# Ports

* 8888 - Webui
* 55555 - Listening port for Sync traffic
