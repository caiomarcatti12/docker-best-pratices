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
RUN npm install --quiet && \
    npm run build && \
    npm prune --production

FROM dev as prod
ENV NODE_ENV=production
WORKDIR /app
COPY --from=build /app/node_modules/ ./node_modules
COPY --from=build /app/dist /app
EXPOSE 3000
CMD ["node", "server.js"]
HEALTHCHECK --interval=10s --timeout=3s CMD curl -f http://localhost:3000/ || exit 1