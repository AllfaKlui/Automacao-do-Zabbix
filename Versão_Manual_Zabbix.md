# 🛠️ Instalação Manual: Zabbix 8.0 no Ubuntu 26.04

Este guia documenta o passo a passo exato para a instalação manual do Zabbix 8.0, ideal para fins educacionais, troubleshooting e compreensão profunda da arquitetura (Servidor Web, Banco de Dados e Aplicação).

## 🧪 Ambiente de Laboratório

**Virtualização: VMware 25H2**   
**Instituição: Senac (Presidente Prudente)**


## **1. Preparação de Repositórios e Instalação Base**

Comandos para adicionar a chave oficial, corrigir o erro do repositório tools em versões recentes do Ubuntu e instalar os pacotes essenciais (LAMP + Zabbix).


`wget https://repo.zabbix.com/zabbix/8.0/release/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest+ubuntu26.04_all.deb`

`sudo dpkg -i zabbix-release_latest+ubuntu26.04_all.deb`    
`sudo apt update`   
`sudo rm /etc/apt/sources.list.d/zabbix-tools.list`     
`sudo apt update`   
`sudo apt install zabbix-server-mysql zabbix-frontend-php  zabbix-apache-conf zabbix-sql-scripts zabbix-agent mariadb-server -y`

## **2. Configuração de Idioma e Servidor Web**

Ajuste do charset do sistema operacional e ativação dos módulos do PHP 8.5 no Apache2.


`sudo locale-gen en_US.UTF-8`                                                    
`sudo update-locale LANG=en_US.UTF-8`                                                
`sudo a2enmod proxy_fcgi setenvif`          
`sudo a2enconf php8.5-fpm`      
`sudo systemctl reload apache2`             

## **3. Criação do Banco de Dados (MariaDB)**

Acesse o console do banco de dados:


`sudo mysql -uroot -p`

Execute as queries abaixo sequencialmente para criar o banco, usuário e conceder privilégios. Nota> Tire os espaços, colocados apenas para visualização.

`SQL`   
`CREATE DATABASE zabbix CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;`     
`CREATE USER 'zabbix'@'localhost' IDENTIFIED BY 'password';`                    
`GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost';`     
`SET GLOBAL log_bin_trust_function_creators = 1;`       
`QUIT;`     
`EXIT;`

## **4. Importação de Esquemas e Configuração**

Descompactação da estrutura oficial do Zabbix para dentro do banco recém-criado e ajuste de segurança.


`zcat /usr/share/zabbix/sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p zabbix`

`sudo mysql -uroot -p -e "SET GLOBAL log_bin_trust_function_creators = 0;"
Vincule o banco de dados ao servidor Zabbix editando o arquivo .conf:`


`sudo nano /etc/zabbix/zabbix_server.conf`

No editor Nano, localize a linha comentada `# DBPassword=` ***Com o comando ctrl +/ (Linha 124),** remova a cerquilha e insira sua senha (ex: DBPassword=password). **`Salve` com (ctrl +o) de `Enter` e `Saia` com (ctrl+x).**

## **5. Start e Validação dos Serviços**

Reinício completo da pilha de serviços e habilitação para boot automático.

  
`sudo systemctl restart zabbix-server zabbix-agent apache2 php8.5-fpm`  
`sudo systemctl enable zabbix-server zabbix-agent apache2 php8.5-fpm`   
`sudo systemctl status zabbix-server apache2 php8.5-fpm`    

## 🔐 Credenciais Padrão 
Após a conclusão, acesse o link (http://SEU-IP/zabbix) e utilize os dados abaixo:

|Componente|Utilizador|Senha|
|----------|----------|-----|
|**Banco de Dados**|`zabbix`|`password`
|**Inteface Web**  |`Admin`|`zabbix`