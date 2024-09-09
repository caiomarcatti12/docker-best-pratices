# O que é Docker?

Docker é uma plataforma de código aberto que permite aos desenvolvedores criar, empacotar e executar aplicações em contêineres. Um contêiner Docker é uma unidade de software padronizada, que pode ser facilmente movida entre ambientes de desenvolvimento, teste e produção. Ele encapsula a aplicação e todas as suas dependências, garantindo que ela funcione de maneira consistente em qualquer sistema que suporte Docker.

### Exemplo Básico:
```bash
# Baixar uma imagem do Nginx do Docker Hub e executar um contêiner
docker run -d -p 8080:80 nginx
# Isso irá iniciar o Nginx no contêiner, e você poderá acessá-lo via http://localhost:8080
```

## Boas Práticas Gerais ao Usar Docker

1. **Use imagens oficiais ou confiáveis:** Prefira imagens oficiais ou de provedores confiáveis do Docker Hub. Isso assegura que você esteja usando uma imagem livre de malware ou vulnerabilidades conhecidas, evitando comprometimento do sistema ou vazamento de dados.
   - **Exemplo:** 
     ```bash
     # Puxando uma imagem oficial do Node.js
     docker pull node:14-alpine
     ```
   - Certifique-se de que a imagem tem a etiqueta "Official" no Docker Hub.

2. **Minimize o tamanho da imagem:** Evite instalar pacotes desnecessários na imagem. Isso resulta em imagens mais rápidas para baixar e iniciar, reduzindo a superfície de ataque e as possíveis vulnerabilidades.
   - **Exemplo:** 
     ```dockerfile
     # Use uma imagem base minimalista
     FROM alpine:3.18
     # Instale apenas as dependências necessárias
     RUN apk add --no-cache python3
     ```

3. **Use tags específicas, não 'latest':** Especificar uma tag ou versão da imagem garante a consistência do contêiner, prevenindo a execução inadvertida de versões não testadas ou instáveis.
   - **Exemplo:**
     ```bash
     # Use uma tag de versão específica para evitar atualizações inesperadas
     docker pull redis:6.2.6
     ```

4. **Use redes e montagens de volumes de forma consciente:** Configure corretamente para restringir o acesso apenas aos recursos necessários. Isso minimiza a possibilidade de um contêiner comprometido afetar outros ou o host, promovendo isolamento e limitando a superfície de ataque.
   - **Exemplo:**
     ```bash
     # Criação de uma rede Docker e uso em contêineres para isolamento
     docker network create minha_rede
     docker run -d --name meu_app --network minha_rede nginx
     ```

5. **Mantenha o Docker e seus contêineres atualizados:** Ao manter tudo atualizado, você se protege contra vulnerabilidades conhecidas, garantindo um sistema mais seguro e eficiente.
   - **Exemplo:**
     ```bash
     # Atualizando o Docker no Ubuntu
     sudo apt-get update && sudo apt-get upgrade docker-ce
     ```

6. **Monitore e audite seus contêineres:** Ferramentas de monitoramento fornecem visibilidade sobre as atividades dos contêineres, permitindo detectar comportamentos suspeitos em tempo real.
   - **Exemplo:**
     ```bash
     # Usando o Docker stats para monitorar contêineres
     docker stats
     ```

7. **Limite os recursos do contêiner:** Usando as configurações de cgroup para limitar recursos, você evita o consumo excessivo e mitiga potenciais problemas de desempenho.
   - **Exemplo:**
     ```bash
     # Limitando a memória e CPU de um contêiner
     docker run -d --memory="512m" --cpus="1" nginx
     ```

## Boas Práticas ao Construir Imagens Docker para Produção

1. **Use uma Imagem Base Pequena e Minimize o Tamanho:** Utilize imagens base minimalistas, como `alpine`, para reduzir o tamanho total da imagem. Evite pacotes desnecessários e use o `.dockerignore` para manter a imagem enxuta, reduzindo a exposição a vulnerabilidades potenciais.
   - **Exemplo:**
     ```dockerfile
     FROM alpine:3.18
     RUN apk add --no-cache curl
     ```

2. **Use Multi-Stage Builds:** Multi-stage builds permitem criar múltiplas etapas em um único `Dockerfile`, mantendo a imagem final limpa e evitando a inclusão de ferramentas desnecessárias e dependências de desenvolvimento.
   - **Exemplo:**
     ```dockerfile
     # Primeiro estágio: Construção
     FROM node:16-alpine AS build
     WORKDIR /app
     COPY package*.json ./
     RUN npm install
     COPY . .
     RUN npm run build

     # Segundo estágio: Produção
     FROM nginx:alpine
     COPY --from=build /app/dist /usr/share/nginx/html
     ```

3. **Defina um Usuário Não-Root para o Contêiner:** Crie e utilize um usuário específico e com privilégios limitados para executar o contêiner, minimizando os riscos em caso de comprometimento.
   - **Exemplo:**
     ```dockerfile
     RUN addgroup -S appgroup && adduser -S appuser -G appgroup
     USER appuser
     ```

4. **Reduza o Número de Camadas e Otimize Instruções:** Combine comandos no `Dockerfile` para reduzir o número de camadas e otimizar o tamanho da imagem. Isso também ajuda a aproveitar o cache do Docker e evita reconstruções desnecessárias.
   - **Exemplo:**
     ```dockerfile
     # Combinar comandos para reduzir camadas
     RUN apt-get update && apt-get install -y curl git && apt-get clean
     ```

5. **Trate Informações Sensíveis com Cuidado:** Evite incluir informações sensíveis diretamente no Dockerfile. Utilize variáveis de ambiente seguras e certifique-se de que estas informações não sejam expostas ou copiadas inadvertidamente.
   - **Exemplo:**
     ```dockerfile
     # Evite armazenar segredos no Dockerfile
     ENV DB_PASSWORD_FILE=/run/secrets/db_password
     ```

6. **Configure a Saúde do Contêiner:** Utilize a instrução `HEALTHCHECK` no Dockerfile para monitorar o status da aplicação dentro do contêiner, permitindo a detecção rápida de problemas.
   - **Exemplo:**
     ```dockerfile
     HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
       CMD curl -f http://localhost/ || exit 1
     ```

7. **Mantenha-se Atualizado e Verifique Vulnerabilidades:** Mantenha as imagens sempre atualizadas e utilize ferramentas como `Trivy` ou `Clair` para realizar scans de vulnerabilidades regularmente, tomando medidas proativas para mitigar riscos.
   - **Exemplo:**
     ```bash
     # Usando Trivy para verificar vulnerabilidades
     trivy image nome-da-imagem
     ```

8. **Pinagem de Versões:** Fixe as versões dos pacotes instalados na imagem para evitar que atualizações inesperadas introduzam vulnerabilidades ou quebras de funcionalidade.
   - **Exemplo:** `RUN apk add --no-cache nodejs=16.17.0-r1 npm=8.19.2-r0 bash=5.1.16-r2`

9. **Redução de Permissões:** Minimize as permissões de arquivos e diretórios, evitando configurações permissivas como `chmod 777`. Prefira permissões restritivas e justifique a necessidade de qualquer permissão mais permissiva.
   - **Exemplo:** `RUN chown -R nodeuser:nodegroup /app && find /app -type d -exec chmod 750 {} \; && find /app -type f -exec chmod 640 {} \;`

10. **Evite COPY do Stage de Build para Produção:** Em vez de usar "COPY ." que copia todos os arquivos do estágio de build para a produção, faça a cópia apenas das pastas e arquivos necessários.
    - **Exemplo:** `COPY --from=build /var/www/html/app /var/www/html/app`

11. **Remoção de Terminais:** Considere remover shells desnecessários (`/bin/sh`, `/bin/ash`, `/bin/bash`, `/bin/dash`, `/bin/zsh`) para aumentar a segurança. Isso deve ser feito com cuidado, pois a ausência de shells pode dificultar a depuração.
    - **Exemplo:** `RUN rm -f /bin/sh /bin/ash /bin/bash /bin/dash /bin/zsh`
