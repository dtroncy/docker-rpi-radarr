# dtroncy/rpi-radarr
FROM balenalib/rpi-raspbian

ARG radarr_version

RUN apt update \
    && apt install apt-transport-https dirmngr gnupg ca-certificates -y \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb https://download.mono-project.com/repo/debian stable-raspbianstretch main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list \
    && apt update \
    && apt upgrade -y \
    && apt install wget -y \
    && apt install mediainfo -y \
    && apt install mono-devel -y \
    && wget -P /opt --no-check-certificate https://github.com/Radarr/Radarr/releases/download/v$radarr_version/Radarr.develop.$radarr_version.linux.tar.gz \
    && tar -xvzf /opt/Radarr.develop.$radarr_version.linux.tar.gz -C /opt \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && rm -rf /opt/Radarr.develop.$radarr_version.linux.tar.gz \
    && mkdir -p /volumes/config /volumes/media \
    && chmod -R 777 /opt \
    && chmod -R 777 /volumes/config \
    && chmod -R 777 /volumes/media

## Expose port
EXPOSE 7878

## Volume for Radarr data
VOLUME /volumes/config /volumes/media

## Entrypoint to launch Radarr
ENTRYPOINT ["mono", "--debug", "/opt/Radarr/Radarr.exe", "-nobrowswer", "-data=/volumes/config"]
