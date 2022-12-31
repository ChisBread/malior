#/bin/bash
source $HOME/.config/malior/envs.sh 2>&1 >/dev/null || true
if [ ! -e $HOME/.local/malior/steam/bin/steam ]; then
    # create necessary directories
    mkdir -p $HOME/.local/malior/steam
    mkdir -p $HOME/.local/malior/steam/tmp
    cd $HOME/.local/malior/steam/tmp
    # download latest deb and unpack
    wget https://cdn.cloudflare.steamstatic.com/client/installer/steam.deb
    ar x steam.deb
    tar xf data.tar.xz
    # remove deb archives, not needed anymore
    rm ./*.tar.xz ./steam.deb
    # move deb contents to steam folder
    mv ./usr/* ../
    cd ../ && rm -rf ./tmp/
fi
# create run script
echo "#!/bin/bash
export STEAMOS=1
export STEAM_RUNTIME=1
export DBUS_FATAL_WARNINGS=0
\$HOME/.local/malior/steam/bin/steam -noreactlogin steam://open/minigameslist $@" > $HOME/.local/malior/bin/steam
chmod +x $HOME/.local/malior/bin/steam
# update package lists with the newly added arch
MALIOR_EXEC_USER=root malior 'apt-get update && apt-get install -y \
    dbus-x11 fonts-wqy-* libnm0:armhf libudev0:armhf libudev1:armhf \
    libxcb*:armhf libgtk2.0-0:armhf libtcmalloc-minimal4*:armhf zenity:armhf \
    libc6:armhf libncurses5:armhf libsdl2*:armhf libopenal*:armhf libpng*:armhf libfontconfig*:armhf libXcomposite*:armhf libbz2-dev:armhf libXtst*:armhf'
echo "Don't forget to 'malior install Box86N64' !"