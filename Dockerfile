FROM php:7.2-fpm-alpine
MAINTAINER easter1021 <mufasa.hsu@gmail.com>

# fix permissions
RUN sed -ri 's/^www-data:x:82:82:/www-data:x:1000:1000:/' /etc/passwd && \
    sed -ri 's/^www-data:x:82:/www-data:x:1000:/' /etc/group

# setup composer
ENV COMPOSER_DEPS \
        git \
        unzip \
        zip

# setup php extensions
ENV PHP_EXTS \
        bcmath \
        mbstring \
        pdo_mysql \
        mysqli

RUN set -xe && \
    NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
    apk add --no-cache --virtual .lib-deps libmcrypt-dev openssl-dev && \
    docker-php-ext-install -j${NPROC} $PHP_EXTS

# supervisor
RUN apk --update add --no-cache supervisor && \
    mkdir /etc/supervisor.d

# install composer
RUN set -xe && \
    apk add --no-cache --virtual .composer-deps $COMPOSER_DEPS && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# install php packages from composer
COPY ./www/composer.json /var/www/html/
RUN set -xe && \
    chown -R www-data:www-data /var/www/html
USER www-data
RUN set -xe && \
    cd /var/www/html; composer install --no-dev --no-autoloader --no-scripts
USER root

# copy service code
WORKDIR /var/www/html
COPY ./www /tmp/html/
RUN set -xe && \
        chown -R www-data:www-data /tmp/html && \
        mv /tmp/html/* /var/www/html 

USER www-data
RUN set -xe && \
        composer dump-autoload
USER root

# copy configuration
COPY ./www/supervisord.conf /etc/supervisord.conf
COPY ./php-fpm/10-php-fpm.ini /etc/supervisor.d/
COPY ./php-fpm/zz-www.conf /usr/local/etc/php-fpm.d/
RUN echo 'php_admin_value[memory_limit] = 256M' >> /usr/local/etc/php-fpm.d/www.conf

VOLUME ["/var/www/html"]

CMD ["/usr/bin/supervisord"]
