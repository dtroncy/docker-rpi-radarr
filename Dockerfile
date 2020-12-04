# dtroncy/rpi-radarr
FROM balenalib/rpi-raspbian

ARG radarr_version

RUN apt update \
    && apt upgrade -y \
    && apt install wget -y \
    && apt install mediainfo -y \
    && apt install -y libicu-dev \
    && apt install -y libssl-dev \
    && apt install -y libgdiplus \
    && wget -P /opt --no-check-certificate https://github.com/Radarr/Radarr/releases/download/v$radarr_version/Radarr.master.$radarr_version.linux-core-arm.tar.gz \
    && tar -xvzf /opt/Radarr.master.$radarr_version.linux-core-arm.tar.gz -C /opt \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && rm -rf /opt/Radarr.master.$radarr_version.linux-core-arm.tar.gz \
    && mkdir -p /volumes/config /volumes/media \
    && chmod -R 755 /opt \
    && chmod -R 755 /volumes/config \
    && chmod -R 755 /volumes/media

## Expose port
EXPOSE 7878

## Volume for Radarr data
VOLUME /volumes/config /volumes/media

## Entrypoint to launch Radarr
ENTRYPOINT ["/opt/Radarr/Radarr", "-nobrowswer", "-data=/volumes/config"]
