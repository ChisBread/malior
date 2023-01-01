#/bin/bash
MALIOR_HOME=${MALIOR_HOME:-$HOME}
echo "Download malior.."
sudo wget -q https://github.com/ChisBread/malior/raw/main/malior -O /usr/local/bin/malior
sudo chmod +x /usr/local/bin/malior
cat > /tmp/malior-sudo <<EOF
MALIOR_EXEC_USER=root malior \$*
EOF
sudo mv /tmp/malior-sudo /usr/local/bin/malior-sudo
sudo chmod +x /usr/local/bin/malior-sudo
echo "Done."
echo "Initialize configuration directory.."
[ ! -d $MALIOR_HOME/.config/malior ] && mkdir -p $MALIOR_HOME/.config/malior
[ ! -d $MALIOR_HOME/.local/malior/bin ] && mkdir -p $MALIOR_HOME/.local/malior/bin
[ ! -d $MALIOR_HOME/.local/malior/share ] && mkdir -p $MALIOR_HOME/.local/malior/share
cat > $MALIOR_HOME/.config/malior/envs.sh <<EOF
# user settings
# end of user settings
# malior settings
[ "\$CONTAINER" == "DOCKER" ] && unset MALIOR_HOME
export PATH=\${MALIOR_HOME:-\$HOME}/.local/malior/bin:/usr/games:\$PATH
export USER=\$(whoami)
# end of settings
EOF
echo "Done."