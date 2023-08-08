FROM alpine:3.18 as default
WORKDIR /var/www/html

RUN apk update && apk upgrade && \
    apk add bash \
            nginx \
            php81 \
            curl \
            php81-fpm \
            php81-mongodb \
            php81-curl \
            php81-iconv \
            php81-mbstring \
            php81-session \
            php81-tokenizer \
            php81-dom \
            php81-xml \
            php81-xmlwriter \
            php81-fileinfo \
            composer 

# Copiar configurações
COPY .docker/nginx-default.conf /etc/nginx/nginx.conf
COPY .docker/nginx-server.conf /etc/nginx/conf.d/server.conf
COPY .docker/entrypoint.sh /entrypoint.sh
COPY .docker/php-fpm-default.conf /etc/php81/php-fpm.conf
COPY .docker/php-fpm-server.conf /etc/php81/php-fpm.d/php-fpm-server.conf

# Criar diretórios e ajustar permissões
RUN chown -R nginx:nginx /var/www/html

# Expor porta 80
EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm81", "-F"]

FROM default AS dev
ENV ENV=development
RUN apk add php81-pecl-xdebug
COPY .docker/xdebug.ini /etc/php81/conf.d/docker-php-ext-xdebug.ini
USER nginx

FROM default AS build
ENV ENV=production
WORKDIR /var/www/html
COPY . /var/www/html
RUN composer install --no-dev --optimize-autoloader

FROM default AS prod
ENV ENV=production
WORKDIR /var/www/html
COPY --from=build /var/www/html /var/www/html
RUN chmod 777 /var/www/html -Rf
USER nginx