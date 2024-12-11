# Boas práticas ao construir imagens Docker para produção

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
      COPY .. .
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
