#!/bin/bash

set -e

CONTAINER="open-webui"
BASE_DIR="/opt/openwebui"
BRANDING_DIR="$BASE_DIR/branding"

echo "=========================================="
echo " Aplicando personalização da ᕮᐯᗩ"
echo "=========================================="

# Verifica se o container existe
if ! sudo docker inspect "$CONTAINER" >/dev/null 2>&1; then
    echo "ERRO: container $CONTAINER não encontrado."
    exit 1
fi

# Verifica se o container está rodando
if [ "$(sudo docker inspect -f '{{.State.Running}}' "$CONTAINER")" != "true" ]; then
    echo "ERRO: container $CONTAINER não está em execução."
    exit 1
fi

# Verifica a pasta de branding
if [ ! -d "$BRANDING_DIR" ]; then
    echo "ERRO: pasta $BRANDING_DIR não encontrada."
    exit 1
fi

echo ""
echo "[1/3] Aplicando logos..."

FILES=(
    "logo.png"
    "favicon.png"
    "favicon.ico"
    "favicon-96x96.png"
    "apple-touch-icon.png"
)

for FILE in "${FILES[@]}"; do
    if [ -f "$BRANDING_DIR/$FILE" ]; then

        sudo docker cp "$BRANDING_DIR/$FILE" \
            "$CONTAINER:/app/build/static/$FILE"

        if [ -d "$BRANDING_DIR" ]; then
            sudo docker cp "$BRANDING_DIR/$FILE" \
                "$CONTAINER:/app/backend/open_webui/static/$FILE" 2>/dev/null || true
        fi

        echo "  OK: $FILE"
    else
        echo "  AVISO: $FILE não encontrado."
    fi
done

echo ""
echo "[2/3] Removendo '(Open WebUI)' do nome..."

sudo docker exec "$CONTAINER" \
    sed -i "s/    WEBUI_NAME += ' (Open WebUI)'/    pass/" \
    /app/backend/open_webui/env.py

echo "  OK: nome personalizado aplicado."

echo ""
echo "[3/3] Reiniciando Open WebUI..."

sudo docker restart "$CONTAINER" >/dev/null

echo ""
echo "=========================================="
echo " Personalização aplicada com sucesso!"
echo "=========================================="
echo ""
echo "Aguarde alguns segundos e atualize o navegador."
