#!/bin/bash
set -e

echo "============================="
echo " INICIANDO CONFIGURACIÓN POP!_OS "
echo "============================="

# -------------------------
# 1️⃣ Actualizar sistema
# -------------------------
sudo apt update && sudo apt upgrade -y
sudo apt install -y build-essential curl wget git unzip software-properties-common apt-transport-https xclip zsh fonts-firacode

# -------------------------
# 2️⃣ Configurar Zsh + Oh My Zsh
# -------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Añadir NVM a Zsh
cat << 'EOF' >> ~/.zshrc

# Configuración NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"       # Carga NVM
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Autocompletado NVM
EOF

source ~/.zshrc

# -------------------------
# 3️⃣ Git + SSH
# -------------------------
git config --global user.name "TuNombre"
git config --global user.email "TuEmail"

# Generar clave SSH si no existe
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
    ssh-keygen -t ed25519 -C "TuEmail" -f "$HOME/.ssh/id_ed25519" -N ""
fi

# Añadir al agente SSH
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Copiar clave al portapapeles
cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard
echo "Clave SSH copiada al portapapeles. Pégala en GitHub/GitLab/Bitbucket."

# -------------------------
# 4️⃣ Docker
# -------------------------
sudo apt install -y ca-certificates gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER

# -------------------------
# 5️⃣ Python + IA + Backend
# -------------------------
sudo apt install -y python3 python3-pip python3-venv
pip install --upgrade --user pip
pip install --user numpy pandas matplotlib scikit-learn jupyter notebook tensorflow torch torchvision torchaudio fastapi flask

# -------------------------
# 6️⃣ Node.js + NVM + Yarn + Pnpm
# -------------------------
if [ ! -d "$HOME/.nvm" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
    source ~/.zshrc
fi

nvm install --lts
nvm use --lts
npm install -g yarn pnpm

# -------------------------
# 7️⃣ Java + Kotlin
# -------------------------
sudo apt install -y openjdk-17-jdk
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install kotlin

# -------------------------
# 8️⃣ Flutter + Android Studio
# -------------------------
# Flutter
git clone https://github.com/flutter/flutter.git -b stable ~/flutter
echo 'export PATH="$PATH:$HOME/flutter/bin"' >> ~/.zshrc
source ~/.zshrc

# Dependencias Android
sudo apt install -y openjdk-17-jdk unzip xz-utils libglu1-mesa

# Android Studio
sudo apt install -y flatpak
flatpak install flathub com.google.AndroidStudio -y

# -------------------------
# 9️⃣ VS Code + IntelliJ IDEA
# -------------------------
# VS Code
wget -O ~/Descargas/code.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
sudo apt install -y ~/Descargas/code.deb
rm ~/Descargas/code.deb

# IntelliJ IDEA Community
flatpak install flathub com.jetbrains.IntelliJ-IDEA-Community -y

echo "============================="
echo " CONFIGURACIÓN COMPLETA "
echo "Reinicia la sesión para aplicar todos los cambios."
echo "============================="
