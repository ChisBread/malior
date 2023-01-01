#/bin/bash
MALIOR_HOME=${MALIOR_HOME:-$HOME}
source $MALIOR_HOME/.config/malior/envs.sh 2>&1 >/dev/null || true
[ -d $MALIOR_HOME/.local/malior/xonotic ] || git clone https://gitlab.com/xonotic/xonotic.git $MALIOR_HOME/.local/malior/xonotic

malior 'source /home/player/.config/malior/envs.sh && cd $HOME/.local/malior/xonotic/ && ./all update -l best && ./all compile -r'
cat > $MALIOR_HOME/.local/malior/bin/xonotic <<EOF
#!/bin/env bash
source \$HOME/.config/malior/envs.sh 2>&1 >/dev/null || true
[ ! -d \$HOME/.xonotic ] && ln -sf \$HOME/.config/malior/.xonotic \$HOME/.xonotic
\$HOME/.local/malior/xonotic/all run
EOF
chmod +x $MALIOR_HOME/.local/malior/bin/xonotic
mkdir $MALIOR_HOME/.config/malior/.xonotic  2>&1 >/dev/null || true