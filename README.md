# 🛠️ Automação do Zabbix no Ubuntu Server

Este projeto contém um script de automação (.sh) desenvolvido para realizar a instalação completa e configurada do Zabbix 8.0 (Alpha) em servidores Ubuntu 26.04 (Resolute) de forma totalmente autônoma.

# 🔔 Sobre o Projeto

O script foi criado com base nas aulas da instituição Senac (Presidente Prudente), feito para facilitar laboratórios de monitoramento, resolvendo automaticamente conflitos de repositórios em versões recentes do Linux e configurando a pilha LAMP (Linux, Apache, MariaDB, PHP) necessária para o Zabbix. 

## ⚠️ Aviso 
Os testes para este script foram feitos no VMware 25H2 

## Como utilizar

1. ### Baixe o script diretamente do GitHub:


` wget https://raw.githubusercontent.com/AllfaKlui/Automacao-do-Zabbix/main/Setup_Zabbix.sh`


2. ### Dê permissão de execução ao arquivo:

`chmod +x Setup_Zabbix.sh`

3. ### Execute o instalador:

`sudo ./Setup_Zabbix.sh`


## 🔐 Credenciais Padrão 
Após a conclusão, acesse o link gerado pelo script (http://SEU-IP/zabbix) e utilize os dados abaixo:


|Componente|Utilizador|Senha|
|----------|----------|-----|
|Banco de Dados|zabbix|password
|Inteface Web  |Admin|zabbix


### Para quem quer deixar a **"HUD"** do Zabbix mais profissional. Aqui está uma `instalação automática.`
[Instalação automatica do Grafana](Guia_de_Instalação_Grafana.md)

### Para aqueles que tem curiosidade em ver e testar passo a passo. Aqui se encontra, o **"Manual"** de instalação do `Zabbix.`

[Instalação Manual do Zabbix](Versão_Manual_Zabbix.md)      

