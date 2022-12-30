#/bin/bash
source $HOME/.config/malior/envs.sh 2>&1 >/dev/null || true
MALIOR_EXEC_USER=root malior '[ ! -f /etc/apt/sources.list.d/openmw-ubuntu-openmw-jammy.list ] && add-apt-repository ppa:openmw/openmw'
MALIOR_EXEC_USER=root malior 'apt update && apt install -y openmw openmw-launcher'