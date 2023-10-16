FROM alpine:3.18 as dev

# instala a versão mais recente do nodejs
RUN apk add --no-cache nodejs npm bash

WORKDIR /app
EXPOSE 3000

# Adiciona o de inicializaçao
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Cria um usuário para não usar o root
RUN addgroup -S nodegroup && \
    adduser -S nodeuser -G nodegroup && \
    chown -R nodeuser:nodegroup /app && \
    chmod 777 /app -Rf
USER nodeuser

ENTRYPOINT ["/entrypoint.sh"]
CMD ["npm run dev"]

FROM dev as build
WORKDIR /app
COPY . .

# Atribui permissão para escrita na propria pasta
USER root
RUN chown -R nodeuser:nodegroup /app && chmod 777 /app -Rf
USER nodeuser

RUN npm install --quiet && \
    npm run build && \
    npm prune --production


FROM alpine:3.18 as prod

# Instalando Nginx
RUN apk add --no-cache nginx

# Criar diretório para rodar o Nginx e copiar os arquivos compilados
RUN mkdir -p /var/www/html
COPY --from=build /app/dist /var/www/html


# Criar usuário e grupo nginx e ajustar permissões
RUN addgroup -S nginxgroup && adduser -S nginxuser -G nginxgroup && \
    chown -R nginxuser:nginxgroup /var/www/html && \
    chown -R nginxuser:nginxgroup /var/lib/nginx && \
    chown -R nginxuser:nginxgroup /var/log/nginx && \
    mkdir -p /tmp/nginx && chown -R nginxuser:nginxgroup /tmp/nginx

    # Configuração do Nginx
COPY nginx-default.conf /etc/nginx/nginx.conf

USER nginxuser

# Iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]

EXPOSE 80
