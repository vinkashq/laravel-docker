FROM vinkas/laravel

RUN pecl install grpc
RUN docker-php-ext-enable grpc

RUN docker-php-ext-install bcmath

RUN apt-get update && apt-get install -y libxslt-dev libicu-dev
RUN docker-php-ext-configure intl
RUN docker-php-ext-install xsl intl
