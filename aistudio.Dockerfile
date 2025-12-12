FROM vinkas/laravel

RUN apt-get update && apt-get install -y libpng-dev

RUN docker-php-ext-install bcmath
RUN docker-php-ext-install gd
