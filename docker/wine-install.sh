echo "credits to https://ptitseb.github.io/box86/X86WINE.html"
WINE_BUILDS_MIRROR=${WINE_BUILDS_MIRROR:-dl.winehq.org}
echo "Use wine mirror:$WINE_BUILDS_MIRROR"
MALIOR_HOME=${MALIOR_HOME:-$HOME}
source $MALIOR_HOME/.config/malior/envs.sh 2>&1 >/dev/null || true
### User-defined Wine version variables ################
# - Replace the variables below with your system's info.
# - Note that we need the i386 version for Box86 even though we're installing it on our ARM processor.
# - Wine download links from WineHQ: https://$WINE_BUILDS_MIRROR/wine-builds/
wbranch=${MALIOR_WINE_BRA:-"devel"} #example: devel, staging, or stable (wine-staging 4.5+ requires libfaudio0:i386 - see below)
wversion=${MALIOR_WINE_VER:-"7.1"} #example: 7.1
wid=${MALIOR_WINE_OS_RLS:-"debian"} #example: debian, ubuntu
wdist=${MALIOR_WINE_OS_VER:-"bullseye"} #example (for debian): bullseye, buster, jessie, wheezy, etc
wtag=${MALIOR_WINE_TAG:-"-1"} #example: -1 (some wine .deb files have -1 tag on the end and some don't)
[ ! -e $MALIOR_HOME/.local/malior/Downloads ] && mkdir -p $MALIOR_HOME/.local/malior/Downloads
########################################################

# Clean up any old wine instances
# wineserver -k # stop any old wine installations from running
# rm -rf ~/.cache/wine # remove old wine-mono/wine-gecko install files
# rm -rf ~/.local/share/applications/wine # remove old program shortcuts

# # Backup any old wine installations
# malior-sudo mv ~/.local/malior/wine ~/.local/malior/wine-old
# malior-sudo mv ~/.wine ~/.wine-old
# malior-sudo mv /usr/local/bin/wine /usr/local/bin/wine-old
# malior-sudo mv /usr/local/bin/wineboot /usr/local/bin/wineboot-old
# malior-sudo mv /usr/local/bin/winecfg /usr/local/bin/winecfg-old
# malior-sudo mv /usr/local/bin/wineserver /usr/local/bin/wineserver-old


echo "[Wine] Download, extract wine, and install wine"
if [ ! -e $MALIOR_HOME/.local/malior/bin/wine ]; then
    cd $MALIOR_HOME/.local/malior/Downloads
    [ ! -e wine-${wbranch}-i386_${wversion}~${wdist}${wtag}_i386.deb ] \
        && wget https://$WINE_BUILDS_MIRROR/wine-builds/${wid}/dists/${wdist}/main/binary-i386/wine-${wbranch}-i386_${wversion}~${wdist}${wtag}_i386.deb # download
    
    [ ! -e wine-${wbranch}_${wversion}~${wdist}${wtag}_i386.deb ] \
        && wget https://$WINE_BUILDS_MIRROR/wine-builds/${wid}/dists/${wdist}/main/binary-i386/wine-${wbranch}_${wversion}~${wdist}${wtag}_i386.deb # (required for wine_i386 if no wine64 / CONFLICTS WITH wine64 support files)
    
    malior "cd /home/player/.local/malior/Downloads && \
dpkg-deb -x wine-${wbranch}-i386_${wversion}~${wdist}${wtag}_i386.deb wine-installer && \
dpkg-deb -x wine-${wbranch}_${wversion}~${wdist}${wtag}_i386.deb wine-installer && \
mv wine-installer/opt/wine* /home/player/.local/malior/wine && \
rm -rf wine-installer \
"
else
    echo "$MALIOR_HOME/.local/malior/wine exist, skip"
fi

echo "[Wine] Install shortcuts (make 32bit launcher & symlinks. Credits: grayduck, Botspot)"

# Create a script to launch wine programs as 32bit only
cat > $MALIOR_HOME/.local/malior/bin/wine <<EOF
#!/bin/bash
SETARCH=\${SETARCH:-'setarch linux32 -L'}
\$SETARCH \$HOME/.local/malior/wine/bin/wine "\$@"
EOF

malior-sudo " \
ln -sf /home/player/.local/malior/wine/bin/wine /home/player/.local/malior/bin/wine-ori && \
ln -sf /home/player/.local/malior/wine/bin/wineboot /home/player/.local/malior/bin/wineboot && \
ln -sf /home/player/.local/malior/wine/bin/winecfg /home/player/.local/malior/bin/winecfg && \
ln -sf /home/player/.local/malior/wine/bin/wineserver /home/player/.local/malior/bin/wineserver ;
chmod +x /home/player/.local/malior/bin/{wine,wine-ori,wineboot,winecfg,wineserver} ;
"

echo "[Wine] These packages are needed for running wine on a 64-bit OS via multiarch"
malior-sudo 'dpkg --add-architecture armhf && apt-get update' # enable multi-arch
malior-sudo 'apt-get install -y libasound2:armhf libc6:armhf libglib2.0-0:armhf libgphoto2-6:armhf libgphoto2-port12:armhf'
malior-sudo 'apt -o Dpkg::Options::="--force-overwrite" --fix-broken install'
malior-sudo 'apt-get install -y libgstreamer-plugins-base1.0-0:armhf libgstreamer1.0-0:armhf libldap-*:armhf libopenal1:armhf libpcap0.8:armhf'
malior-sudo 'apt-get install -y libpulse0:armhf libsane1:armhf libudev1:armhf libusb-1.0-0:armhf libvkd3d1:armhf libx11-6:armhf libxext6:armhf'
malior-sudo 'apt-get install -y libasound2-plugins:armhf ocl-icd-libopencl1:armhf libncurses6:armhf libncurses5:armhf libcap2-bin:armhf libcups2:armhf'
malior-sudo 'apt-get install -y libdbus-1-3:armhf libfontconfig1:armhf libfreetype6:armhf libglu1-mesa:armhf libglu1:armhf libgnutls30:armhf'
malior-sudo 'apt-get install -y libgssapi-krb5-2:armhf libkrb5-3:armhf libodbc1:armhf libosmesa6:armhf libsdl2-2.0-0:armhf libv4l-0:armhf'
malior-sudo 'apt-get install -y libxcomposite1:armhf libxcursor1:armhf libxfixes3:armhf libxi6:armhf libxinerama1:armhf libxrandr2:armhf'
malior-sudo 'apt-get install -y libxrender1:armhf libxxf86vm1 libc6:armhf libcap2-bin:armhf' # to run wine-i386 through box86:armhf on aarch64
# This list found by downloading...
#	wget https://$WINE_BUILDS_MIRROR/wine-builds/debian/dists/bullseye/main/binary-i386/wine-devel-i386_7.1~bullseye-1_i386.deb
#	wget https://$WINE_BUILDS_MIRROR/wine-builds/debian/dists/bullseye/main/binary-i386/winehq-devel_7.1~bullseye-1_i386.deb
#	wget https://$WINE_BUILDS_MIRROR/wine-builds/debian/dists/bullseye/main/binary-i386/wine-devel_7.1~bullseye-1_i386.deb
# then `dpkg-deb -I package.deb`. Read output, add `:armhf` to packages in dep list, then try installing them on Pi aarch64.

echo "[Wine] These packages are needed for running wine-staging on RPiOS (Credits: chills340)"
malior-sudo 'apt install libstb0 -y'
cd $MALIOR_HOME/.local/malior/Downloads
wget -r -l1 -np -nd -A "libfaudio0_*~bpo10+1_i386.deb" http://ftp.us.debian.org/debian/pool/main/f/faudio/ # Download libfaudio i386 no matter its version number
malior-sudo "cd /home/player/.local/malior/Downloads && \
dpkg-deb -xv libfaudio0_*~bpo10+1_i386.deb libfaudio && \
cp -TRv libfaudio/usr/ /usr/  && \
rm libfaudio0_*~bpo10+1_i386.deb && \
rm -rf libfaudio \
"

echo "[Wine] Boot wine (make fresh wineprefix in /home/player/.wine )"
[ "`malior 'whereis box86 | cut -d: -f2'`" == "" ] && echo "malior install box86N64" && malior install box86N64
malior 'wine wineboot'


echo "[Wine] Install winetricks"
if [ ! -e $MALIOR_HOME/.local/malior/bin/winetricks ]; then
    malior-sudo "apt-get install cabextract -y"                                                                   # winetricks needs this installed
    malior-sudo "mv /usr/local/bin/winetricks /usr/local/bin/winetricks-old"                                      # Backup old winetricks
    cd $MALIOR_HOME/.local/malior/Downloads \
        && wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks # Download
    malior "cd /home/player/.local/malior/Downloads && \
chmod +x winetricks && mv winetricks /home/player/.local/malior/bin/ \
"
else
    echo "[Wine] Skip"
fi

[ "`malior 'echo $LANG'`" == "zh_CN.UTF-8" ] && echo "tips: 使用中文环境? 'malior winetricks -q fakechinese wenquanyi'"
