echo "credits to https://gitlab.com/panfork/dri2to3"
MALIOR_HOME=${MALIOR_HOME:-$HOME}
source $MALIOR_HOME/.config/malior/envs.sh 2>&1 >/dev/null || true

echo "build gl4es"

malior-sudo 'apt-get update && apt-get install -y build-essential meson cmake libxcb-present-dev libxcb-dri2-*dev libxcb-dri3-dev'
malior 'cd /home/player/.local/malior/ && \
git clone https://github.com/ptitSeb/gl4es ; \
cd gl4es ; rm -rf build ; mkdir build ; cd build && cmake .. -DODROID=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo; make -j$(expr $(nproc) + 3) ; \
cd /home/player/.local/malior/gl4es/lib && ln -sf libGL.so.1 libGL.so \
'

malior '[ "`grep LIB_GL4ES /home/player/.config/malior/envs.sh`" == "" ] && \
echo "export LIB_GL4ES=/home/player/.local/malior/gl4es/lib" >> /home/player/.config/malior/envs.sh'
echo "      mali blob test: ' MALI_BLOB=x11 malior glmark2'"