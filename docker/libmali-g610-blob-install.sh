echo "credits to https://gitlab.com/panfork/dri2to3"
MALIOR_HOME=${MALIOR_HOME:-$HOME}
source $MALIOR_HOME/.config/malior/envs.sh 2>&1 >/dev/null || true
mkdir -p $MALIOR_HOME/.local/malior/libmali/x11

echo "fetch libmali"
cd $MALIOR_HOME/.local/malior/libmali/x11
[ ! -e libmali-valhall-g610-g6p0-x11-gbm.so ] && wget https://github.com/JeffyCN/rockchip_mirrors/raw/libmali/lib/aarch64-linux-gnu/libmali-valhall-g610-g6p0-x11-gbm.so
ln -sf libmali-valhall-g610-g6p0-x11-gbm.so libmali.so.1
for l in libEGL.so libEGL.so.1 libgbm.so.1 libGLESv2.so libGLESv2.so.2 libOpenCL.so.1; do ln -sf libmali.so.1 $l; done

echo "build dri2to3"
malior-sudo 'apt-get update && apt-get install -y build-essential meson cmake libxcb-present-dev libxcb-dri2-*dev libxcb-dri3-dev'
malior 'cd /home/player/.local/malior/ && \
git clone https://gitlab.com/panfork/dri2to3 ; \
cd dri2to3 ; rm -rf build ; mkdir build ; cd build && meson setup && ninja \
'

malior '[ "`grep BLOB_LIB_DRI2TO3 /home/player/.config/malior/envs.sh`" == "" ] && \
echo "export BLOB_LIB_DRI2TO3=/home/player/.local/malior/dri2to3/build" >> /home/player/.config/malior/envs.sh'

echo "tips: blob driver without OpenGL support? 'malior install gl4es'"
echo "      Run the application with the blob driver: ' MALI_BLOB=x11 malior glmark2-es2'"