# ⚠️ Ambiente de Validação
Homologado e testado em máquinas virtuais via **VMware 25H2**.

## 📊 Automação de Instalação: Grafana + Plugin Zabbix

Este repositório contém um script de automação (`.sh`) para a instalação direta do **Grafana** em servidores **Ubuntu 26.04 (Resolute)**, já incluindo o download e a ativação prévia do plugin de integração com o Zabbix.

### 📋 Sobre o Projeto

Estruturado para agilizar a criação de laboratórios de monitoramento nas aulas de infraestrutura (Senac - Presidente Prudente), o script elimina a complexidade de adicionar chaves GPG manualmente e prepara o ambiente visual escuro e moderno do Grafana. 

## 🚀 Como utilizar

Siga os passos abaixo no terminal do seu servidor para iniciar a instalação:

1. **Baixe o script diretamente do GitHub:**
wget https://raw.githubusercontent.com/AllfaKlui/Automacao-do-Zabbix/main/Zabbix_teste.sh

2. **Dê permissão de execução ao arquivo:**

`chmod +x install_grafana.sh`

3. **Execute o instalador:**

`sudo ./install_grafana.sh`



## 🔐 Primeiro Acesso

Após a execução, acesse pelo navegador http://SEU-IP:3000.

Usuário padrão: `admin`

Senha padrão: `admin` (O sistema exigirá a troca no primeiro login).

## 🔗 Guia de Integração Rápida (Grafana ↔ Zabbix)

Com a instalação concluída, você precisa "ligar" os dois sistemas na interface web do Grafana:

**Passo 1: Habilitar o Plugin**

No menu esquerdo, vá em `Administration` (ícone de engrenagem) > `Plugins`.

Pesquise por `Zabbix` e clique nele.

`Clique no botão azul Enable.`

**Passo 2: Configurar o Data Source (Fonte de Dados)**

Vá em `Connections` > `Data Sources` e clique em `Add data source.`

`Selecione Zabbix.`

Na seção `HTTP`, preencha a `URL`: `http://localhost/zabbix/api_jsonrpc.php` (use localhost se o Zabbix estiver no mesmo servidor).

Na seção `Zabbix Connection`, insira as credenciais da `API` do seu **Zabbix
`(Geralmente Admin e zabbix)`.**

**Desça até o final da página e clique em `Save & Test.`** Um `balão verde` confirmará a conexão.

**Passo 3: Dashboards Prontos**

**Ainda em Data Source de volta para cima e clique na aba Dashboards.**

**Importe os modelos disponíveis ou Todos se quiser (ex: Zabbix Server Dashboard).**

## Pronto! Acesse seus Dashboards no menu lateral esquerdo.
