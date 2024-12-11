# Boas Práticas Gerais ao Usar Docker

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
