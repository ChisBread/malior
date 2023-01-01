#/bin/bash
MALIOR_HOME=${MALIOR_HOME:-$HOME}
source $MALIOR_HOME/.config/malior/envs.sh 2>&1 >/dev/null || true
malior-sudo 'wget https://ryanfortner.github.io/box64-debs/box64.list -O /etc/apt/sources.list.d/box64.list'
malior-sudo 'wget -O- https://ryanfortner.github.io/box64-debs/KEY.gpg | gpg --dearmor | tee /usr/share/keyrings/box64-debs-archive-keyring.gpg'
malior-sudo 'wget https://itai-nelken.github.io/weekly-box86-debs/debian/box86.list -O /etc/apt/sources.list.d/box86.list'
malior-sudo 'wget -qO- https://itai-nelken.github.io/weekly-box86-debs/debian/KEY.gpg | apt-key add -'
malior-sudo 'apt update && apt install box86 box64 -y'