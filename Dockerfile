FROM php:apache

ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

RUN apt-get update -y && apt-get install -y openssl zip unzip supervisor
RUN docker-php-ext-install pdo pdo_mysql zip

RUN pecl install redis \
    && pecl install excimer
RUN docker-php-ext-enable redis
RUN a2enmod rewrite

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

COPY --from=composer /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY php/ /usr/local/etc/php/conf.d/
COPY supervisor/ /etc/supervisor/conf.d/

CMD ["/usr/bin/supervisord"]
