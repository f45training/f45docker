FROM iron/php:5.6.14
RUN apk update
RUN apk upgrade
RUN apk add alpine-sdk
RUN apk add zlib-dev
RUN apk add curl
RUN apk add bash
RUN apk add perl
RUN apk add re2c
RUN apk add pcre-dev
RUN apk add openssl-dev
RUN apk add php-dev autoconf
# MongoDB
RUN git clone https://github.com/mongodb/mongo-php-driver.git
WORKDIR ./mongo-php-driver
RUN which php
RUN git submodule sync && git submodule update --init
RUN phpize
RUN ./configure
RUN make all -j 5
RUN make install
RUN echo 'extension=mongodb.so' >> /etc/php/php.ini
# Redis
RUN git clone https://github.com/nicolasff/phpredis.git --branch 4.2.0
WORKDIR ./phpredis
RUN phpize
RUN ./configure
RUN make all -j 5
RUN make install
RUN echo 'extension=redis.so' >> /etc/php/php.ini
RUN sed -i 's/memory_limit = .*/memory_limit = 1G/g' /etc/php/php.ini