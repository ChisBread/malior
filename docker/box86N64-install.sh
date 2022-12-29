#/bin/bash
source $HOME/.config/malior/envs.sh 2>&1 >/dev/null || true
MALIOR_EXEC_OPT='--user=root' malior 'wget https://ryanfortner.github.io/box64-debs/box64.list -O /etc/apt/sources.list.d/box64.list'
MALIOR_EXEC_OPT='--user=root' malior 'wget -O- https://ryanfortner.github.io/box64-debs/KEY.gpg | gpg --dearmor | tee /usr/share/keyrings/box64-debs-archive-keyring.gpg'
MALIOR_EXEC_OPT='--user=root' malior 'wget https://itai-nelken.github.io/weekly-box86-debs/debian/box86.list -O /etc/apt/sources.list.d/box86.list'
MALIOR_EXEC_OPT='--user=root' malior 'wget -qO- https://itai-nelken.github.io/weekly-box86-debs/debian/KEY.gpg | apt-key add -'
MALIOR_EXEC_OPT='--user=root' malior 'apt update && apt install box86 box64 -y'