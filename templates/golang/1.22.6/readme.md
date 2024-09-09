# Template Docker para Aplicações Golang

Este template oferece uma configuração de desenvolvimento robusta para aplicações em Golang utilizando Docker. A configuração inclui um Dockerfile para desenvolvimento e Docker Compose, além de práticas recomendadas para otimização e segurança.

## Arquivos Incluídos no Template

- **.dockerignore**: Exclui arquivos desnecessários do contexto de build do Docker.
- **docker-compose.yaml**: Facilita a construção e execução da aplicação em contêineres.
- **Dockerfile.dev**: Prepara um ambiente de desenvolvimento com Golang instalado e configurações de segurança aplicadas.

## Debugando Aplicações Golang com Docker

Para iniciar o debug da aplicação, siga estes passos:

1. Utilize o comando `docker-compose up` para iniciar os serviços definidos no `docker-compose.yaml`.
2. Acesse o contêiner em execução com `docker exec -it application-golang /bin/bash`.
3. Dentro do contêiner, navegue até o diretório do `main.go`.
4. Ative o Delve utilizando o alias `debug` configurado para iniciar o Delve em modo headless e permitir múltiplos clientes.
5. Configure o Visual Studio Code para conectar ao Delve utilizando as seguintes configurações em `settings.json`:

```json
{
    "configurations": [
        {
            "name": "Connect to server",
            "type": "go",
            "request": "attach",
            "mode": "remote",
            "port": 4000,
            "host": "0.0.0.0",
            "showLog": true
        }
    ]
}
```