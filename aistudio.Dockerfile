FROM vinkas/laravel

RUN rm /etc/supervisor/conf.d/pulse.conf

RUN apt-get update && apt-get install -y libpng-dev

RUN docker-php-ext-install bcmath
RUN docker-php-ext-install gd
