#/bin/bash
source $HOME/.config/malior/envs.sh 2>&1 >/dev/null || true
MALIOR_EXEC_OPT='--user=root' malior add-apt-repository ppa:openmw/openmw
MALIOR_EXEC_OPT='--user=root' malior apt update
MALIOR_EXEC_OPT='--user=root' malior apt install -y openmw openmw-launcher