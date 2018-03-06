# docker-rpi-radarr

[![Build Status](https://travis-ci.org/dtroncy/docker-rpi-radarr.svg?branch=master)](https://travis-ci.org/dtroncy/docker-rpi-radarr)

This is a raspberry pi compatible radarr DockerFile.

To build it :

    docker build --build-arg radarr_version=$radarr_version -t rpi-radarr .

$radarr_version is version of radarr you want to install.

To run it (with image on docker hub) :

    docker run -d -p 7878:7878 \
    -v /path_to_your_media_folder:/volumes/media \
    -v /path_to_your_config_folder:/volumes/config \
    -v /etc/localtime:/etc/localtime:ro \
    --restart unless-stopped \
    --name radarr \
    dtroncy/rpi-radarr

Description of parameters :
  - **-d** : to launch container as demon
  - **-v /path_to_your_media_folder:/volumes/media** : mount media folder in your container to a folder in your host. The media folder is the folder where radarr scan your actuals media
  - **-v /path_to_your_config_folder:/volumes/config** : mount config folder in your container to a folder in your host
  - **-v /etc/localtime:/etc/localtime:ro** : synchronise time between host and container
  - **--restart unless-stopped** : restart the container unless it has been stopped by user
  - **--name radarr** : container's name
  - **dtroncy/rpi-radarr** : image's name
