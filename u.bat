#!/bin/bash


sudo apt update && sudo apt upgrade -y && \
# ===== VS Code =====
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/packages.microsoft.gpg >/dev/null && \
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list && \
sudo apt update && sudo apt install -y code && \
# ===== Chrome =====
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/chrome.deb && \
sudo dpkg -i /tmp/chrome.deb || sudo apt -f install -y && rm /tmp/chrome.deb && \
# ===== Canva (كويب أب) =====
cat <<EOF > ~/.local/share/applications/canva.desktop
[Desktop Entry]
Name=Canva
Exec=google-chrome --app=https://www.canva.com/
Icon=chrome
Type=Application
Categories=Graphics;
EOF
&& \
# ===== Apache + PHP + MySQL =====
sudo apt install -y apache2 mysql-server php libapache2-mod-php php-mysql && \
sudo systemctl enable --now apache2 mysql && \
# ===== Python + pip + PyCharm =====
sudo apt install -y python3 python3-pip && \
sudo snap install pycharm-community --classic && \
# ===== VNC =====
sudo apt install -y tigervnc-standalone-server tigervnc-viewer && \
# ===== Static IP =====
IFACE=$(ip route | grep '^default' | awk '{print $5}') && \
sudo bash -c "cat > /etc/netplan/01-static-ip.yaml" <<EONET
network:
  version: 2
  renderer: NetworkManager
  ethernets:
    $IFACE:
      dhcp4: no
      addresses: [192.168.0.191/24]
      gateway4: 192.168.0.1
      nameservers:
        addresses: [8.8.8.8,1.1.1.1]
EONET
&& \
sudo netplan apply && \
echo '✅ كل شيء اتثبت وضبط بنجاح! يفضل إعادة التشغيل: sudo reboot