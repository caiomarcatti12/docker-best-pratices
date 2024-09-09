FROM alpine:3.20

ARG USER_NAME=appuser
ARG USER_GROUP=appgroup
ARG USER_UID=1001
ARG USER_GID=1001

# Instale as dependências necessárias
RUN apk add --no-cache \
    bash=5.2.26-r0 \
    git=2.45.2-r0 \
    musl-utils=1.2.5-r0 \
    musl=1.2.5-r0 \
    go=1.22.6-r0

# Define o diretório de trabalho
WORKDIR /app

# Define usuario não root com UID e GID específicos
RUN addgroup -g $USER_GID -S $USER_GROUP \
    && adduser -u $USER_UID -S $USER_NAME -G $USER_GROUP

# Define o workdir como um diretorio confiavel
RUN git config --system --add safe.directory '/app' 

USER $USER_NAME

# Instala o Delve
RUN go install github.com/go-delve/delve/cmd/dlv@v1.23.0

# Adiciona o diretório onde o Go instala os binários ao PATH
ENV GOPATH="/home/$USER_NAME/go"
ENV PATH=$PATH:$GOPATH/bin

# Adiciona um alias para ativar o debug
RUN echo 'alias debug="dlv debug --headless=true --listen=0.0.0.0:4000 --api-version=2 --accept-multiclient"' >> ~/.bashrc

# Comando padrão ao iniciar o contêiner
CMD ["/bin/bash"]
