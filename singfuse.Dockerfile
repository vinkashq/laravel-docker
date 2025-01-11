FROM vinkas/laravel

RUN docker-php-ext-install bcmath

RUN apt install -y libxslt-dev
RUN docker-php-ext-install xsl
