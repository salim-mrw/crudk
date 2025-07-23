#!/bin/bash


echo "📦 تثبيت الأدوات الأساسية..."
sudo apt install -y git curl wget unzip build-essential software-properties-common apt-transport-https

echo "🐍 تثبيت Python و pip..."
sudo apt install -y python3 python3-pip

echo "☕ تثبيت Java (OpenJDK)..."
sudo apt install -y openjdk-17-jdk

echo "🟫 تثبيت Node.js و npm..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

echo "🐘 تثبيت PHP..."
sudo apt install -y php

echo "🐬 تثبيت MySQL Server..."
sudo apt install -y mysql-server

echo "🧰 تثبيت NetBeans..."
sudo snap install netbeans --classic

echo "💻 تثبيت Visual Studio Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
rm microsoft.gpg
sudo apt update
sudo apt install -y code

echo "✈️ تثبيت Telegram..."
sudo snap install telegram-desktop

echo "🌐 تثبيت Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

echo "✅ تم التثبيت بنجاح! أعد تشغيل الجهاز لو تطلب الأمر."