FROM ubuntu:22.04
RUN sed -i s@/ports.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list \
    && apt-get update && apt-get install -y software-properties-common \
    && add-apt-repository ppa:liujianfeng1994/panfork-mesa \
    && sed -i -e "s@http.*://ppa.launchpadcontent.net@https://launchpad.proxy.ustclug.org@g" /etc/apt/sources.list.d/* \
    && dpkg --add-architecture armhf\
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y locales wget curl vim \
        libegl-mesa0:armhf libegl1-mesa:armhf libgbm1:armhf libgl1-mesa-dri:armhf libgl1-mesa-glx:armhf libglapi-mesa:armhf libgles2-mesa:armhf libglx-mesa0:armhf libosmesa6:armhf libwayland-egl1-mesa:armhf mesa-va-drivers:armhf \
        libegl-mesa0 libegl1-mesa libgbm1 libgl1-mesa-dri libgl1-mesa-glx libglapi-mesa libgles2-mesa libglx-mesa0 libosmesa6 libwayland-egl1-mesa mesa-va-drivers \
        autoconf automake build-essential curl git libtool libgmp-dev libjpeg-turbo8-dev libsdl2-dev libxpm-dev xserver-xorg-dev zlib1g-dev unzip zip \
        libosmesa6-dev freeglut3-dev libpulse0 libasound2 libasound2-plugins pulseaudio-utils libvorbisfile3 libvorbisenc2 libvorbis0a \
        glmark2 glmark2-wayland glmark2-es2 glmark2-es2-wayland \
    && rm -rf /var/lib/apt/lists/* \
    && locale-gen en_US.UTF-8 && locale-gen zh_CN.UTF-8
RUN groupadd -o -g 1000 player && useradd -g player -s /bin/bash -u 1000 -m player
ENV PAN_MESA_DEBUG=gofaster
ENV container=docker
WORKDIR /home/player
ENTRYPOINT ["/usr/bin/systemd"]
CMD [ "log-level=info", "unit=sysinit.target" ]