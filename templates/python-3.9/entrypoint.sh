#!/bin/bash

# Verifica se as dependências estão instaladas; se não, instala
if [ ! -d "/venv/lib/python3.*/site-packages" ] && [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
fi

# Verifica se o arquivo .env existe; se não, e se .env.example existir, copia
if [ ! -f ".env" ] && [ -f ".env.example" ]; then
    cp .env.example .env
fi

# Executa os comandos passados como argumentos para o script
exec "$@"
