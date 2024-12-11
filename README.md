## Melhores praticas do Docker

Este repositório reúne práticas recomendadas, exemplos e templates para maximizar o uso do Docker em diferentes cenários. Ele é destinado a desenvolvedores e equipes que desejam criar contêineres mais eficientes, seguros e fáceis de gerenciar. Aqui você encontrará:

- **Práticas recomendadas para contêineres e imagens Docker.**
- **Configuração e automação.**
- **Templates prontos para linguagens.**

Nosso objetivo é centralizar conhecimento e tornar seu trabalho com Docker mais simples e produtivo!

---

### Antes
Docker é uma plataforma de código aberto que permite aos desenvolvedores criar, empacotar e executar aplicações em contêineres. Um contêiner Docker é uma unidade de software padronizada, que pode ser facilmente movida entre ambientes de desenvolvimento, teste e produção. Ele encapsula a aplicação e todas as suas dependências, garantindo que ela funcione de maneira consistente em qualquer sistema que suporte Docker.

### Exemplo Básico:
```bash
docker run -d -p 8080:80 nginx
```
Isso irá baixar uma imagem do Nginx do Docker Hub, executar o Nginx no contêiner, e você poderá acessá-lo via http://localhost:8080

---


## O que tem por aqui?

1. [Práticas recomendadas para uso](pratices/best-pratices.md)
2. [Práticas recomendadas para imagens](pratices/best-pratices-image.md)
3. [Configuração de HEALTHCHECK no Docker](pratices/healthcheck.md)
4. [Templates de imagens Docker](templates/)
    - [Golang](templates/golang/)
    - [Node.js (última versão)](templates/nodejs-latest/)
    - [Node.js (desenvolvimento com Nginx para produção)](templates/nodejs-latest-dev-nginx-prod/)
    - [PHP 8.1 com Nginx](templates/php81-nginx/)
    - [Python 3.9](templates/python-3.9/)

---

## Como Contribuir

Se você tem sugestões, melhorias ou exemplos adicionais, fique à vontade para contribuir! Siga estas etapas:

1. Faça um fork do repositório.
2. Crie um branch com sua nova funcionalidade ou correção de bug:
   ```bash
   git checkout -b minha-feature
   ```
3. Envie suas alterações:
   ```bash
   git commit -m "Adiciona minha nova feature"
   git push origin minha-feature
   ```
4. Abra um Pull Request.

Toda colabração é bem vinda!


## Licença

Este repositório está licenciado sob a [Licença MIT](LICENSE).

