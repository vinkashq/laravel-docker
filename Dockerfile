FROM php:8.3-apache

ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

RUN apt-get update -y && apt-get install -y libmcrypt-dev openssl zip unzip
RUN docker-php-ext-install pdo pdo_mysql

# mcrypt requires < php 8.4
RUN pecl install mcrypt \
    && pecl install redis \
    && pecl install excimer
RUN docker-php-ext-enable mcrypt redis
RUN a2enmod rewrite

COPY --from=composer /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

RUN apt-get update -y && apt-get install -y cron supervisor

RUN runuser -u www-data -- echo "* * * * * /usr/local/bin/php /var/www/html/artisan schedule:run >> /var/www/html/cron.output" | runuser -u www-data -- crontab -

COPY supervisor/ /etc/supervisor/conf.d/

CMD ["/usr/bin/supervisord"]
