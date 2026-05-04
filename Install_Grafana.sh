#!/bin/bash

echo "========================================================"
echo " Iniciando a Instalação Automatizada do Grafana"
echo "========================================================"

# 1. Instalação de dependências e Chave GPG
echo "Baixando chaves de segurança do repositório oficial..."
sudo apt-get install -y apt-transport-https software-properties-common wget
sudo mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null

# 2. Adição do Repositório Oficial
echo "Adicionando repositório do Grafana..."
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee  /etc/apt/sources.list.d/grafana.list
sudo apt-get update

# 3. Instalação do Grafana
echo "Instalando o Grafana Server..."
sudo apt-get install grafana -y

# 4. Ativação do Serviço
echo "Configurando inicialização automática..."
sudo systemctl daemon-reload
sudo systemctl start grafana-server
sudo systemctl enable grafana-server

# 5. Instalação do Plugin do Zabbix e Ajuste de Permissões
echo "Instalando o Plugin Oficial do Zabbix (Alexander Zobnin)..."
sudo grafana-cli --homepath "/usr/share/grafana" plugins install alexanderzobnin-zabbix-app

echo "Ajustando permissões para futuros plugins via Web..."
sudo chown -R grafana:grafana /var/lib/grafana/plugins
sudo chmod -R 775 /var/lib/grafana/plugins

echo "Reiniciando o Grafana para aplicar as mudanças..."
sudo systemctl restart grafana-server

# 6. Captura de IP e Entrega do HTTP
SERVER_IP=$(hostname -I | awk '{print $1}')

echo "========================================================"
echo " Instalação Concluída com Sucesso!"
echo " Status atual do Grafana Server:"
sudo systemctl status grafana-server --no-pager | grep Active
echo "========================================================"
echo " O painel visual já está aguardando conexões."
echo " 👉 Acesse o link: http://$SERVER_IP:3000"
echo "========================================================"