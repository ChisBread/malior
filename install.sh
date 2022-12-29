#/bin/bash
sudo wget https://github.com/ChisBread/malior/raw/main/malior -O /usr/local/bin/malior
sudo chmod +x /usr/local/bin/malior
mkdir -p ~/.config/malior
mkdir -p ~/.local/malior
cat > ~/.config/malior/envs.sh <<EOF
export XONOTIC_DIR=~/.local/malior/xonotic
export PATH=\$PATH:~/.local/malior/bin
EOF