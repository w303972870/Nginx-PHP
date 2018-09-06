FROM alpine:latest

MAINTAINER Eric Wang

ADD Dockerfile /root/

LABEL description="宿住机器新建好日志目录和配置目录：/etc/php7/php-fpm.conf，/etc/php7/php.ini，/etc/php7/php-fpm.d/，/data/php/logs/"

ENV TIMEZONE Asia/Shanghai
ENV MAX_UPLOAD 50M
ENV PHP_MAX_FILE_UPLOAD 200
ENV PHP_MAX_POST 100M

RUN mkdir -p /data/php/ && mkdir -p /data/php/tmp/ && mkdir -p /data/php/logs

RUN apk update && \
  apk add tzdata curl && \
  cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
  echo "${TIMEZONE}" > /etc/timezone && \
      addgroup -S php \
    && adduser -D -S -h /var/cache/php -s /sbin/nologin -G php php && \
  apk --update --repository=http://dl-4.alpinelinux.org/alpine/edge/testing add php7 php7-mysqli php7-fpm php7-pdo_mysql  php7-json php7-zlib  php7-intl php7-session php7-redis php7-memcached php7-bcmath php7-bz2 php7-ctype php7-curl  php7-dom php7-fileinfo  php7-ftp php7-gd php7-gettext  php7-iconv   php7-mbstring php7-mysqlnd  php7-openssl php7-pcntl   php7-pdo_sqlite  php7-posix   php7-shmop  php7-soap php7-sockets php7-sqlite3 php7-sysvsem php7-tokenizer php7-xml php7-xmlreader php7-xmlrpc php7-xmlwriter php7-zip php7-zlib php7-common php7-mcrypt php7-gmp php7-pdo php7-phar php7-exif  \
  php7-xsl php7-opcache php7-dba php7-pear php7-sodium php7-imagick php7-enchant php7-ldap php7-mongodb php7-amqp php7-wddx php7-zmq  php7-event php7-yaml php7-embed && \
curl -sS https://getcomposer.org/installer | php7 -- --install-dir=/usr/bin --filename=composer  && rm -rf /var/cache/apk/*


RUN sed -i 's@;daemonize = yes@daemonize = no@g' /etc/php7/php-fpm.conf \ 
    && sed -i "s|upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD}|" /etc/php7/php.ini  \ 
    && sed -i "s|max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|" /etc/php7/php.ini  \ 
    && sed -i "s|post_max_size =.*|post_max_size = ${PHP_MAX_POST}|" /etc/php7/php.ini  \ 
    && sed -i "s|;opcache.file_cache=.*|opcache.file_cache=/data/php/tmp/|" /etc/php7/php.ini  \ 
    && sed -i "s|;;opcache.huge_code_pages=1|opcache.huge_code_pages=1|" /etc/php7/php.ini  \ 
    && sed -i "s|;opcache.enable_cli=0|opcache.enable_cli=1|" /etc/php7/php.ini  \ 
    && sed -i "s|short_open_tag = Off|short_open_tag = On|" /etc/php7/php.ini  \ 
    && sed -i "s|;error_log = php_errors.log|error_log = /data/php/logs/php_errors.log|" /etc/php7/php.ini  \ 
    && sed -i "s|;;opcache.enable=1|opcache.enable=1|" /etc/php7/php.ini  \ 
    && sed -i "s|;date.timezone =|date.timezone = ${TIMEZONE}|" /etc/php7/php.ini  \ 
    && sed -i "s|listen = 127.0.0.1:9000|listen = 9000|" /etc/php7/php-fpm.d/www.conf   \ 
    && sed -i "s|;pid = run/php-fpm7.pid|pid = run/php-fpm7.pid|" /etc/php7/php-fpm.conf



RUN ln -s /usr/sbin/php-fpm7 /usr/bin/php-fpm

EXPOSE 9000

CMD ["/usr/bin/php-fpm"]
