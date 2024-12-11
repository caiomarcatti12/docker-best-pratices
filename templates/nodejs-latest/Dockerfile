FROM alpine:3.20.3 AS default
ARG UID=1001
ARG GID=1001
ARG GROUP=appgroup
ARG USER=appuser

# instala a versão mais recente do nodejs
RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
        nodejs=20.15.1-r0 \
        npm=10.9.1-r0

WORKDIR /app
EXPOSE 3000

RUN addgroup -S $GROUP && adduser -S $USER -G $GROUP
USER ${USER}

FROM default AS dev
ARG USER=appuser

USER root

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
        bash=5.2.26-r0

USER ${USER}

CMD ["tail", "-f", "/dev/null"]

FROM dev as build
USER root

COPY ./ /app

RUN npm install --quiet && \
    npm run build && \
    npm prune --production

FROM default as prod
ARG GROUP=appgroup
ARG USER=appuser

USER root

COPY --from=build /app/node_modules/ /app/node_modules
COPY --from=build /app/dist /app

# Dá as permissões necessárias
RUN find /app -type d -exec chmod 755 {} \; && \
    find /app -type f -exec chmod 644 {} \; && \
    chown -R ${USER}:${GROUP} /app -Rf \

RUN rm -f /bin/sh /bin/ash /bin/bash /bin/dash /bin/zsh /bin/apk

USER ${USER}

CMD ["node", "main/server.js"]
HEALTHCHECK --interval=10s --timeout=3s CMD curl -f http://localhost:3000/ || exit 1
