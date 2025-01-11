FROM vinkas/laravel

RUN pecl install grpc
RUN docker-php-ext-enable grpc

RUN docker-php-ext-install bcmath

RUN apt install -y libxslt1-dev
RUN docker-php-ext-install xsl
