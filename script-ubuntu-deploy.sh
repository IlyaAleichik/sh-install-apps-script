#!/bin/bash

set -e # Прерывать выполнение при ошибках

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

# Проверка прав sudo
check_sudo() {
 if [ "$EUID" -ne 0 ]; then
 print_warning "Требуются права sudo для некоторых операций"
 fi
}

# Добавление репозиториев
add_repositories() {
 print_info "Добавление репозиториев..."
 sudo add-apt-repository -y ppa:agornostal/ulauncher
 sudo add-apt-repository -y ppa:appimagelauncher-team/stable
}

# Удаление Snap
remove_snap() {
 print_info "Удаление Snap..."
 sudo systemctl stop snapd 2>/dev/null || true
 sudo systemctl disable snapd 2>/dev/null || true
 sudo apt purge -y snapd
 rm -rf ~/snap
 sudo rm -rf /snap /var/snap /var/lib/snapd /var/cache/snapd /usr/lib/snapd /root/snap
}

# Установка APT пакетов
install_apt_packages() {
 print_info "Обновление пакетов..."
 sudo apt update

 print_info "Установка APT пакетов..."
 sudo apt install -y \
 ulauncher \
 git \
 unrar \
 appimagelauncher \
 dconf-editor \
 alacarte \
 curl

 print_info "Установка Speedtest..."
 curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
 sudo apt-get install -y speedtest
}

# Настройка Git
setup_git() {
 print_info "Настройка Git..."
 git config --global user.name "IlyaAleichik"
 git config --global user.email "ilya.alejchik@outlook.com"

 # Клонирование и установка тем
 if [ ! -d "vimix-gtk-themes" ]; then
 git clone git@github.com:vinceliuice/vimix-gtk-themes.git
 sudo ./vimix-gtk-themes/install.sh -c dark -t doder -s compact
 fi

 if [ ! -d "WhiteSur-icon-theme" ]; then
 git clone git@github.com:vinceliuice/WhiteSur-icon-theme.git
 sudo ./WhiteSur-icon-theme/install.sh
 fi
}

# Установка .NET
install_dotnet() {
 print_info "Установка .NET..."

 wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
 sudo dpkg -i packages-microsoft-prod.deb
 rm packages-microsoft-prod.deb

 sudo apt-get update
 sudo apt-get install -y apt-transport-https

 # Установка различных версий .NET
 dotnet_versions=(
 "dotnet-sdk-2.1 aspnetcore-runtime-2.1"
 "dotnet-sdk-3.1 aspnetcore-runtime-3.1"
 "dotnet-sdk-5.0 aspnetcore-runtime-5.0"
 "dotnet-sdk-6.0 aspnetcore-runtime-6.0"
 )

 for version in "${dotnet_versions[@]}"; do
 sudo apt-get install -y $version
 done

 # Установка шаблонов Avalonia
 if [ ! -d "avalonia-dotnet-templates" ]; then
 git clone https://github.com/AvaloniaUI/avalonia-dotnet-templates.git
 cd avalonia-dotnet-templates/
 dotnet new --install ./
 cd ..
 fi
}

# Установка баз данных
install_databases() {
 # MSSQL
 print_info "Установка MSSQL..."
 sudo apt-get install -y mssql-server
 sudo /opt/mssql/bin/mssql-conf setup
 systemctl status mssql-server --no-pager

 # MySQL
 print_info "Установка MySQL..."
 sudo apt update
 sudo apt-get install -y mysql-server

 print_info "Проверка версии MySQL..."
 mysql --version

 # PostgreSQL
 print_info "Установка PostgreSQL..."
 sudo apt install -y curl ca-certificates
 sudo install -d /usr/share/postgresql-common/pgdg
 sudo curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc
 sudo sh -c 'echo "deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
 sudo apt update
 sudo apt -y install postgresql
}

# Установка драйверов и библиотек
install_drivers_libs() {
 print_info "Установка драйверов и библиотек..."
 sudo apt install -y --reinstall linux-generic
 sudo apt install -y lib32z1
 sudo apt install -y ubuntu-restricted-extras
 sudo apt install -y xserver-xorg-input-synaptics
 sudo ubuntu-drivers autoinstall
}

# Исправление проблем
apply_fixes() {
 print_info "Применение исправлений..."
 sudo timedatectl set-local-rtc 1 --adjust-system-clock
 sudo apt --fix-broken install -y
}

# Основная функция
main() {
 print_info "Начало установки..."

 check_sudo
 add_repositories
 remove_snap
 install_apt_packages
 setup_git
 install_dotnet
 install_databases
 install_drivers_libs
 apply_fixes

 print_info "Установка завершена успешно!"
}

# Обработка ошибок
trap 'print_error "Скрипт прерван на шаге: $BASH_COMMAND"; exit 1' ERR

# Запуск основной функции
main "$@"
