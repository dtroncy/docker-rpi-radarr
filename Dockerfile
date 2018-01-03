# dtroncy/rpi-radarr
FROM resin/rpi-raspbian

ARG radarr_version

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install libmono-cil-dev -y \
    && apt-get install wget \
    && wget http://sourceforge.net/projects/bananapi/files/mono_3.10-armhf.deb \
    && dpkg -i mono_3.10-armhf.deb \
    && rm mono_3.10-armhf.deb \
    && cd /opt \
    && wget --no-check-certificate https://github.com/Radarr/Radarr/releases/download/v$radarr_version/Radarr.develop.$radarr_version.linux.tar.gz \
    && tar -xvzf Radarr.develop.$radarr_version.linux.tar.gz \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && rm -rf /opt/Radarr.develop.$radarr_version.linux.tar.gz \
    && mkdir -p /volumes/config /volumes/media

# forward Radarr logs to docker log collector
RUN ln -sf /dev/stdout /volumes/config/logs/radarr.txt

## Expose port
EXPOSE 7878

## Volume for Radarr data
VOLUME /volumes/config /volumes/media

## Entrypoint to launch Radarr
ENTRYPOINT ["mono", "/opt/Radarr/Radarr.exe", "-nobrowswer", "-data=/volumes/config"]