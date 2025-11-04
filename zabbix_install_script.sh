#!/bin/bash

# Запрос пароля для пользователя Zabbix
read -sp "Введите пароль для пользователя Zabbix: " zabbix_password
echo

# Обновление пакетов
echo "Обновление пакетов..."
sudo apt update

# Установка Apache
echo "Установка Apache2..."
sudo apt install -y apache2

# Установка MySQL
echo "Установка MySQL..."
sudo apt install -y mysql-server mysql-client

# Проверка статуса MySQL
echo "Проверка статуса MySQL..."
sudo systemctl status mysql --no-pager

# Проверка версии MySQL
echo "Версия MySQL:"
mysql --version

# Настройка безопасности MySQL
echo "Настройка безопасности MySQL..."
sudo mysql_secure_installation

# Установка PHP
echo "Установка PHP..."
sudo apt install -y php php-cli php-common php-mysql

# Загрузка и установка репозитория Zabbix
echo "Установка репозитория Zabbix..."
wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-4+ubuntu20.04_all.deb
sudo dpkg -i zabbix-release_6.0-4+ubuntu20.04_all.deb
sudo apt update

# Установка компонентов Zabbix
echo "Установка компонентов Zabbix..."
sudo apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent

# Создание базы данных и пользователя для Zabbix
echo "Создание базы данных Zabbix..."
sudo mysql -u root -p <<EOF
create database zabbix character set utf8mb4 collate utf8mb4_bin;
create user zabbix@localhost identified by '${zabbix_password}';
grant all privileges on zabbix.* to zabbix@localhost;
set global log_bin_trust_function_creators = 1;
quit
EOF

# Импорт начальной схемы данных
echo "Импорт схемы данных Zabbix..."
zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p"${zabbix_password}" zabbix

# Отключение настройки MySQL
echo "Отключение log_bin_trust_function_creators..."
sudo mysql -u root -p <<EOF
set global log_bin_trust_function_creators = 0;
quit
EOF

# Настройка пароля в конфигурации Zabbix
echo "Настройка конфигурации Zabbix Server..."
sudo sed -i "s/^# DBPassword=.*/DBPassword=${zabbix_password}/" /etc/zabbix/zabbix_server.conf

# Перезапуск служб
echo "Перезапуск служб..."
sudo systemctl restart zabbix-server zabbix-agent apache2
sudo systemctl enable zabbix-server zabbix-agent apache2

echo "Установка завершена!"
echo "Пароль для пользователя Zabbix в MySQL: ${zabbix_password}"
echo "Вы можете получить доступ к веб-интерфейсу Zabbix по адресу: http://ваш_сервер/zabbix"