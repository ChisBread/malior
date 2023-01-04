echo "[gl4es] credits to https://gitlab.com/panfork/dri2to3"
MALIOR_HOME=${MALIOR_HOME:-$HOME}
source $MALIOR_HOME/.config/malior/envs.sh 2>&1 >/dev/null || true

echo "[gl4es] build gl4es"
sudo apt install 
malior-sudo 'apt-get update && apt-get install -y  build-essential meson cmake libxcb-present-dev libxcb-dri2-*dev libxcb-dri3-dev'
malior-sudo 'apt -o Dpkg::Options::="--force-overwrite" --fix-broken install'
malior 'cd /home/player/.local/malior/ && \
git clone https://github.com/ptitSeb/gl4es ; \
cd gl4es ; rm -rf build ; mkdir build ; cd build && cmake .. -DODROID=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo && make -j$(expr $(nproc) + 3) ; \
cd /home/player/.local/malior/gl4es/lib && ln -sf libGL.so.1 libGL.so ; \
cp -r /home/player/.local/malior/gl4es/lib /home/player/.local/malior/gl4es/lib64 \
'

malior '[ "`grep LIB_GL4ES /home/player/.config/malior/envs.sh`" == "" ] && \
echo "export LIB_GL4ES=/home/player/.local/malior/gl4es/lib64" >> /home/player/.config/malior/envs.sh'


echo "[gl4es] build gl4es armhf"
malior-sudo 'apt-get install -y gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf libxcb-present-dev:armhf libxcb-dri2-*dev:armhf libxcb-dri3-dev:armhf libx11-dev:armhf'
malior-sudo 'apt-get -o Dpkg::Options::="--force-overwrite" --fix-broken install'
malior 'cd /home/player/.local/malior/gl4es ; \
rm -rf build32 ; mkdir build32 ; cd build32 ; \
CC=arm-linux-gnueabihf-gcc CXX=arm-linux-gnueabihf-g++ cmake .. -DODROID=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo && make -j$(expr $(nproc) + 3) ; \
cd /home/player/.local/malior/gl4es/lib && ln -sf libGL.so.1 libGL.so ; \
cp -r /home/player/.local/malior/gl4es/lib /home/player/.local/malior/gl4es/lib32 \
'

malior '[ "`grep LIB_GL4ES_32 /home/player/.config/malior/envs.sh`" == "" ] && \
echo "export LIB_GL4ES_32=/home/player/.local/malior/gl4es/lib32" >> /home/player/.config/malior/envs.sh'

echo "[gl4es] remove cross build toolchain"
malior-sudo 'apt-get remove -y gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf'
malior-sudo 'apt-get -o Dpkg::Options::="--force-overwrite" install -y cpp:armhf cpp-11:armhf'
echo "      mali blob test: ' MALI_BLOB=x11 malior glmark2'"
