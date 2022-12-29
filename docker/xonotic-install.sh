#/bin/bash
source /home/player/.config/malior/envs.sh 2>&1 >/dev/null || true
sudo apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        autoconf automake build-essential curl git libtool libgmp-dev libjpeg-turbo8-dev libsdl2-dev libxpm-dev xserver-xorg-dev zlib1g-dev unzip zip
[ -d $XONOTIC_DIR ] || git clone https://gitlab.com/xonotic/xonotic.git $XONOTIC_DIR
cd $XONOTIC_DIR
./all update -l best
./all compile -r