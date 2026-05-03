#!/bin/bash

echo "========================================================"
echo " Iniciando a Instalação Automatizada do Zabbix 8.0"
echo "========================================================"

# 1. Download e Preparação de Repositórios
wget https://repo.zabbix.com/zabbix/8.0/release/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest+ubuntu26.04_all.deb
sudo dpkg -i zabbix-release_latest+ubuntu26.04_all.deb
sudo apt update
sudo rm /etc/apt/sources.list.d/zabbix-tools.list
sudo apt update

# 2. Instalação dos Pacotes Principais
sudo apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent mariadb-server -y

# 3. Correção do Idioma (System Locale)
echo "Configurando o idioma do sistema para o Zabbix..."
sudo locale-gen en_US.UTF-8
sudo update-locale LANG=en_US.UTF-8

# 4. Configuração do Servidor Web (Apache e PHP)
sudo a2enmod proxy_fcgi setenvif
sudo a2enconf php8.5-fpm
sudo systemctl reload apache2

# 5. Configuração Silenciosa do Banco de Dados (MariaDB)
echo "Configurando credenciais do Banco de Dados..."
sudo mysql -e "CREATE DATABASE zabbix CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;"
sudo mysql -e "CREATE USER 'zabbix'@'localhost' IDENTIFIED BY 'password';"
sudo mysql -e "GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost';"
sudo mysql -e "SET GLOBAL log_bin_trust_function_creators = 1;"

# 6. Importação do Schema do Zabbix
echo "Importando estrutura de tabelas. Isso pode demorar alguns segundos..."
zcat /usr/share/zabbix/sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -ppassword zabbix

# 7. Fechamento de Segurança do Banco
sudo mysql -e "SET GLOBAL log_bin_trust_function_creators = 0;"

# 8. Injeção de Configuração no zabbix_server.conf
echo "Injetando senha no arquivo de configuração do servidor..."
sudo sed -i 's/# DBPassword=/DBPassword=password/g' /etc/zabbix/zabbix_server.conf

# 9. Reinicialização e Ativação Definitiva dos Serviços
echo "Reiniciando e ativando serviços no boot..."
sudo systemctl restart apache2 php8.5-fpm zabbix-server zabbix-agent
sudo systemctl enable zabbix-server zabbix-agent apache2 php8.5-fpm

# 10. Captura de IP e Entrega do HTTP
SERVER_IP=$(hostname -I | awk '{print $1}')

echo "========================================================"
echo " Instalação Concluída com Sucesso!"
echo " Status atual do Zabbix Server:"
sudo systemctl status zabbix-server --no-pager | grep Active
echo "========================================================"
echo " A interface web já está aguardando conexões."
echo " 👉 Acesse o link: http://$SERVER_IP/zabbix"
echo "========================================================"