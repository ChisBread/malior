#/bin/bash
MALIOR_HOME=${MALIOR_HOME:-$HOME}
source $MALIOR_HOME/.config/malior/envs.sh 2>&1 >/dev/null || true
malior-sudo '[ ! -f /etc/apt/sources.list.d/openmw-ubuntu-openmw-jammy.list ] && add-apt-repository ppa:openmw/openmw'
malior-sudo 'apt update && apt install -y openmw openmw-launcher'