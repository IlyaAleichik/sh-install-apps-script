#!/bin/bash

# Скрипт настройки VNC сервера в Ubuntu 22.04
# Сохранить как skript.sh и сделать исполняемым: chmod +x skript.sh

set -e

echo "=== Настройка VNC сервера в Ubuntu 22.04 ==="

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Функции для вывода
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Проверка прав root
if [ "$EUID" -eq 0 ]; then
    print_error "Не запускайте скрипт от root! Используйте обычного пользователя."
    exit 1
fi

# 1. Установка VNC сервера
print_info "Установка VNC сервера..."
sudo apt update
sudo apt install -y tigervnc-standalone-server tigervnc-xorg-extension

# 2. Настройка VNC пароля
print_info "Настройка VNC пароля..."
echo "Придумайте пароль для VNC подключения (минимум 6 символов):"
vncpasswd

# 3. Создание конфигурационного файла
print_info "Создание конфигурационного файла..."
mkdir -p ~/.vnc

cat > ~/.vnc/xstartup << 'EOF'
#!/bin/bash
export XDG_SESSION_TYPE=x11
export GNOME_SHELL_SESSION_MODE=ubuntu
export XDG_CURRENT_DESKTOP=ubuntu:GNOME
export XDG_CONFIG_DIRS=/etc/xdg/xdg-ubuntu:/etc/xdg

[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources

dbus-launch --exit-with-session gnome-session &
EOF

chmod +x ~/.vnc/xstartup

# 4. Запуск VNC сервера для теста
print_info "Запуск VNC сервера на дисплее :1..."
vncserver :1 -geometry 1920x1080 -depth 24

# 5. Настройка автозапуска через systemd
print_info "Настройка автозапуска через systemd..."

USERNAME=$(whoami)

sudo tee /etc/systemd/system/vncserver@.service > /dev/null << EOF
[Unit]
Description=Start TigerVNC server at startup
After=syslog.target network.target

[Service]
Type=forking
User=$USERNAME
Group=$USERNAME
WorkingDirectory=/home/$USERNAME
PIDFile=/home/$USERNAME/.vnc/%H:%i.pid
ExecStartPre=-/usr/bin/vncserver -kill :%i > /dev/null 2>&1
ExecStart=/usr/bin/vncserver -depth 24 -geometry 1920x1080 :%i
ExecStop=/usr/bin/vncserver -kill :%i

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable vncserver@1.service

# 6. Настройка фаервола
print_info "Настройка фаервола..."
sudo ufw allow 5901

# 7. Перезапуск VNC сервера через systemd
print_info "Перезапуск VNC сервера через systemd..."
vncserver -kill :1
sudo systemctl start vncserver@1.service

# 8. Вывод информации
print_info "Настройка завершена!"
echo "=========================================="
echo "VNC сервер запущен на порту: 5901"
echo "IP адрес сервера: $(hostname -I | awk '{print $1}')"
echo "Для подключения используйте: ${HOSTNAME}:1 или $(hostname -I | awk '{print $1}'):5901"
echo "=========================================="

# Проверка статуса
print_info "Проверка статуса VNC сервера..."
sudo systemctl status vncserver@1.service --no-pager

echo ""
print_warning "Не забудьте настроить проброс портов если сервер за NAT!"
print_info "Для управления VNC сервером используйте:"
echo "  sudo systemctl start vncserver@1.service"
echo "  sudo systemctl stop vncserver@1.service"
echo "  sudo systemctl restart vncserver@1.service"
echo "  sudo systemctl status vncserver@1.service"