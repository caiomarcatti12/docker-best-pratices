# Estágio dev
FROM alpine:3.18 as dev

# Instala Python, pip e outras ferramentas necessárias
RUN apk add --no-cache python3 py3-pip bash curl

# Cria e ativa o ambiente virtual
RUN python3 -m venv /venv
ENV PATH="/venv/bin:$PATH"

WORKDIR /app
EXPOSE 5000

# Adiciona o script de inicialização
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh 

# Cria um usuário para não usar o root
RUN addgroup -S pygroup && \
    adduser -S pyuser -G pygroup && \
    chown -R pyuser:pygroup /app && \
    chmod 777 /app -Rf
USER pyuser

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]   
