#/bin/bash
source $HOME/.config/malior/envs.sh 2>&1 >/dev/null || true
[ -d $XONOTIC_DIR ] || git clone https://gitlab.com/xonotic/xonotic.git $XONOTIC_DIR

MALIOR_EXEC_OPT='--user=root' malior 'apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y autoconf automake build-essential curl git libtool libgmp-dev libjpeg-turbo8-dev libsdl2-dev libxpm-dev xserver-xorg-dev zlib1g-dev unzip zip'
malior 'source /home/player/.config/malior/envs.sh && cd $XONOTIC_DIR && ./all update -l best && ./all compile -r'
cat > ~/.local/malior/bin/xonotic <<EOF
#!/bin/env bash
source \$HOME/.config/malior/envs.sh 2>&1 >/dev/null || true
[ ! -d \$HOME/.xonotic ] && ln -sf \$HOME/.config/malior/.xonotic \$HOME/.xonotic
\$XONOTIC_DIR/all run
EOF
chmod +x ~/.local/malior/bin/xonotic
mkdir $HOME/.config/malior/.xonotic  2>&1 >/dev/null || true