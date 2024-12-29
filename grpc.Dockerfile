FROM vinkas/laravel

RUN pecl install grpc
RUN docker-php-ext-enable grpc
