#!/bin/bash


# 🟢 تثبيت TigerVNC
sudo apt update && sudo apt install -y tigervnc-standalone-server tigervnc-common

# 🟢 تعيين باسورد للـ VNC (راح يطلب تدخل يدوي)
echo "🚨 الآن أدخل باسورد للـ VNC:"
vncpasswd

# 🟢 إنشاء ملف xstartup لتشغيل واجهة LinuxFX (Cinnamon)
mkdir -p ~/.vnc
cat > ~/.vnc/xstartup <<EOF
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
exec cinnamon-session &
EOF
chmod +x ~/.vnc/xstartup

# 🟢 إنشاء خدمة systemd
sudo bash -c "cat > /etc/systemd/system/vncserver@.service" <<EOF
[Unit]
Description=Start TigerVNC server at startup
After=syslog.target network.target

[Service]
Type=forking
User=$USER
PAMName=login
PIDFile=/home/$USER/.vnc/%H:%i.pid
ExecStartPre=-/usr/bin/vncserver -kill :%i > /dev/null 2>&1
ExecStart=/usr/bin/vncserver :%i -geometry 1280x800 -depth 24
ExecStop=/usr/bin/vncserver -kill :%i

[Install]
WantedBy=multi-user.target
EOF

# 🟢 إعادة تحميل النظام وتفعيل وتشغيل السيرفر على الشاشة :1 (المنفذ 5901)
sudo systemctl daemon-reload
sudo systemctl enable vncserver@1.service
sudo systemctl start vncserver@1.service

# 🟢 عرض النتيجة
echo "✅ تم الإعداد بنجاح!"
echo "🔑 استخدم الباسورد اللي دخلته للاتصال."
echo "💻 الآن تقدر تتصل عبر:  $(hostname -I | awk '{print $1}'):5901"