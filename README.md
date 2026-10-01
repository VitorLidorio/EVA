# -
Creation and integration of ᕮᐯᗩ with OpenWebUI; ᕮᐯᗩ is essentially a customized interface for the OpenWebUI tool integrated with Ollama. Here, you will find the complete documentation and a step-by-step guide for deployment using Docker Compose.

# Open WebUI - ᕮᐯᗩ

Configuração do Open WebUI com Ollama, Open Terminal e personalização da interface.

## Instalação

### 1. Clonar o repositório

```bash
git clone https://github.com/SEU_USUARIO/SEU_REPOSITORIO.git openwebui
```

### 2. Entrar no diretório

```bash
cd openwebui
```

### 3. Iniciar os containers

```bash
sudo docker compose up -d
```

### 4. Aplicar a personalização da interface

```bash
chmod +x scripts/aplicar-branding.sh
./scripts/aplicar-branding.sh
```

## Acesso

Após a instalação, acesse:

```text
http://IP_DO_SERVIDOR:3000
```



## Atualização

Para atualizar a instalação:

```bash
cd /opt/openwebui
git pull
sudo docker compose up -d
./scripts/aplicar-branding.sh
```

O script de branding reaplica automaticamente os logos, favicons e ajustes da interface após a atualização do container.

## Estrutura

```text
openwebui/
├── docker-compose.yml
├── README.md
├── branding/
│   ├── logo.png
│   ├── favicon.png
│   ├── favicon.ico
│   ├── favicon-96x96.png
│   └── apple-touch-icon.png
└── scripts/
    └── aplicar-branding.sh
```

## Observação

Os dados persistentes do Open WebUI, Ollama e Open Terminal ficam armazenados em volumes Docker e não fazem parte do repositório Git.

Não executar:

```bash
sudo docker compose down -v
```

Esse comando remove os volumes e pode apagar os dados persistentes. Porque aparentemente até o Docker precisa de uma opção capaz de transformar um simples comando em um dia ruim.

