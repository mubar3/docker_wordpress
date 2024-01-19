FROM php:7.4-apache

COPY . /var/www/html/

RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip\
    nano

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN a2enmod ssl && a2enmod rewrite
RUN mkdir -p /etc/apache2/ssl
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

COPY dockerfiles/ssl/*.pem /etc/apache2/ssl/
COPY dockerfiles/apache/000-default.conf /etc/apache2/sites-available/000-default.conf
RUN docker-php-ext-install pdo_mysql mysqli
RUN chmod -R 777 /var/www/html/
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd
RUN service apache2 restart