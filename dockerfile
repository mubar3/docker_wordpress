FROM php:7.4-apache

COPY . /var/www/html/

RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip\
    nano

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN a2enmod rewrite
RUN docker-php-ext-install pdo_mysql mysqli
RUN chmod -R 777 /var/www/html/
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd
RUN service apache2 restart