FROM alpine:latest

MAINTAINER Eric Wang

ADD Dockerfile /root/
ADD nginx.conf /root/
ADD localhost.conf /root/

ENV TIMEZONE Asia/Shanghai
ENV MAX_UPLOAD 50M
ENV PHP_MAX_FILE_UPLOAD 200
ENV PHP_MAX_POST 100M
ENV TENGINE_VERSION 2.2.2

ENV CONFIG "\
        --sbin-path=/usr/sbin/nginx \
        --conf-path=/data/nginx/conf/nginx.conf \
        --error-log-path=/data/nginx/logs/error.log \
        --http-log-path=/data/nginx/logs/access.log \
        --pid-path=/var/run/nginx.pid \
        --lock-path=/var/run/nginx.lock \
        --http-client-body-temp-path=/data/nginx/tmp//client_temp \
        --http-proxy-temp-path=/data/nginx/tmp//proxy_temp \
        --http-fastcgi-temp-path=/data/nginx/tmp//fastcgi_temp \
        --http-uwsgi-temp-path=/data/nginx/tmp//uwsgi_temp \
        --http-scgi-temp-path=/data/nginx/tmp//scgi_temp \
        --with-http_ssl_module \
        --with-http_realip_module \
        --with-http_addition_module \
        --with-http_sub_module \
        --with-http_dav_module \
        --with-http_flv_module \
        --with-http_mp4_module \
        --with-http_gunzip_module \
        --with-http_gzip_static_module \
        --with-http_random_index_module \
        --with-http_secure_link_module \
        --with-http_auth_request_module \
        --with-mail \
        --with-mail_ssl_module \
        --with-file-aio \
        --with-http_v2_module \
        --with-ipv6 \
        --with-jemalloc \
	--with-threads \
	--with-http_xslt_module \
	--with-http_image_filter_module \
	--with-http_geoip_module \
	--with-http_degradation_module \
	--with-http_slice_module \
	--with-http_stub_status_module \
	--with-http_dyups_module \  
	--with-http_lua_module \  
	--with-md5-asm \  
	--with-pcre \  
	--with-sha1-asm \  
	--with-http_dyups_lua_api "

RUN mkdir -p /data/php/conf/php-fpm.d/ && mkdir -p /data/php/tmp/ && mkdir -p /data/php/logs \
    && echo 'ls -l $1' > /usr/bin/ll \
    && mkdir -p /data/nginx/logs /var/run/nginx/ /data/nginx/tmp//uwsgi /data/nginx/tmp//proxy /data/nginx/tmp//scgi /data/htdocs /data/supervisor/logs/ /data/supervisor/conf/ && apk update && \
  apk add tzdata curl && \
  cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
  echo "${TIMEZONE}" > /etc/timezone && \
      addgroup -S php \
    && adduser -D -S -h /var/cache/php -s /sbin/nologin -G php php && \
  apk --update --repository=http://dl-4.alpinelinux.org/alpine/edge/testing add php7 php7-mysqli php7-dev php7-fpm php7-pdo_mysql  php7-json php7-zlib  php7-intl php7-session php7-redis php7-memcached php7-bcmath php7-bz2 php7-ctype php7-curl  php7-dom php7-fileinfo  php7-ftp php7-gd php7-gettext  php7-iconv   php7-mbstring php7-mysqlnd  php7-openssl php7-pcntl   php7-pdo_sqlite  php7-posix   php7-shmop  php7-soap php7-sockets php7-sqlite3 php7-sysvsem php7-tokenizer php7-xml php7-xmlreader php7-xmlrpc php7-xmlwriter php7-zip php7-zlib php7-common php7-mcrypt php7-gmp php7-pdo php7-phar php7-exif  \
  php7-xsl php7-opcache php7-dba php7-pear php7-sodium php7-imagick php7-enchant php7-ldap php7-mongodb php7-amqp php7-wddx php7-zmq  php7-event php7-yaml php7-embed && \
curl -sS https://getcomposer.org/installer | php7 -- --install-dir=/usr/bin --filename=composer \ 
    && sed -i 's@;daemonize = yes@daemonize = no@g' /etc/php7/php-fpm.conf \ 
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
    && sed -i "s|listen = 127.0.0.1:9000|listen = /dev/shm/php.sock|" /etc/php7/php-fpm.d/www.conf   \ 
    && sed -i "s|;listen.owner = nobody|listen.owner = nobody|" /etc/php7/php-fpm.d/www.conf   \ 
    && sed -i "s|;listen.group = nobody|listen.group = nobody|" /etc/php7/php-fpm.d/www.conf   \ 
    && sed -i "s|;listen.mode = 0660|listen.mode = 0660|" /etc/php7/php-fpm.d/www.conf   \ 
    && sed -i "s|;pid = run/php-fpm7.pid|pid = /data/php/conf/php-fpm7.pid|" /etc/php7/php-fpm.conf \
    && sed -i "s|;error_log = log/php7/error.log|error_log = /data/php/logs/error.log|" /etc/php7/php-fpm.conf \
    && sed -i "s|include=/etc/php7/php-fpm.d/*.conf|include=/data/php/conf/php-fpm.d/*.conf|" /etc/php7/php-fpm.conf \
    && cp /etc/php7/php-fpm.conf /data/php/conf/ && cp /etc/php7/php-fpm.d/www.conf /data/php/conf/php-fpm.d/ \
    && cp /etc/php7/php.ini /data/php/conf/ &&  apk add --no-cache --virtual .build-deps \
        gcc g++ \
        libc-dev \
        make \
        openssl-dev \
        pcre-dev \
        zlib-dev \
        linux-headers geoip-dev \
        curl libxml2-dev libxslt-dev gd-dev git \
	    lua-dev make cmake re2c \
        jemalloc-dev \
    && curl "http://tengine.taobao.org/download/tengine-$TENGINE_VERSION.tar.gz" -o tengine.tar.gz \
    && mkdir -p /usr/src \
    && tar -zxC /usr/src -f tengine.tar.gz \
    && rm tengine.tar.gz \
    && cd /usr/src/tengine-$TENGINE_VERSION/src/os/unix/ \
    && cd ../../../ \
#    && cd /usr/src/tengine-$TENGINE_VERSION \
    && ./configure $CONFIG --with-debug \
    && make \
    && mv objs/nginx objs/nginx-debug \
    && ./configure $CONFIG \
    && make \
    && make install \
    && rm -rf /etc/nginx/html/ \
    && mkdir /data/nginx/conf/conf.d/ \
    && mkdir -p /usr/share/nginx/html/ \
    && install -m644 html/index.html /usr/share/nginx/html/ \
    && install -m644 html/50x.html /usr/share/nginx/html/ \
    && install -m755 objs/nginx-debug /usr/sbin/nginx-debug \
    && strip /usr/sbin/nginx* \

    && mkdir /usr/src/jieba/ -p && cd /usr/src/jieba/ \
    && git clone https://github.com/jonnywang/phpjieba.git \
    && cd phpjieba/cjieba && make && cd .. \
    && phpize && ./configure && make && make install && mkdir /data/jieba/dict -p \
    && cp -R /usr/src/jieba/phpjieba/cjieba/dict/* /data/jieba/dict \
    && cd /usr/src/ && wget http://www.xunsearch.com/scws/down/scws-1.2.3.tar.bz2 \
    && tar jxf scws-1.2.3.tar.bz2 && cd scws-1.2.3 && ./configure --sysconfdir=/data/scws/etc \
    && make && make install && cd phpext && phpize && ./configure \
    && make && make install \

    && runDeps="$( \
        scanelf --needed --nobanner /usr/sbin/nginx \
            | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
            | sort -u \
            | xargs -r apk info --installed \
            | sort -u \
    )" \
    && apk add --virtual .nginx-rundeps $runDeps supervisor \
    && apk del .build-deps && apk del make wget php7-dev curl gcc libc-dev openssl-dev pcre-dev zlib-dev linux-headers geoip-dev libxml2-dev libxslt-dev gd-dev lua-dev jemalloc-dev && rm -rf /var/cache/apk/* \
    && rm -rf /usr/src/tengine-$TENGINE_VERSION  \
    && apk add --no-cache gettext \
    \
    # forward request and error logs to docker log collector
    && ln -sf /dev/stdout /data/nginx/logs/access.log \
    && ln -sf /dev/stderr /data/nginx/logs/error.log  \
    && \cp /root/nginx.conf /data/nginx/conf/nginx.conf && \cp /root/localhost.conf /data/nginx/conf/conf.d/default.conf \
    && ln -s /usr/sbin/php-fpm7 /usr/bin/php-fpm 
ADD supervisord.conf /data/supervisor/conf/
ADD fastcgi_params /data/nginx/conf/

EXPOSE 9000 9001 80 443

CMD ["supervisord", "-n", "-c","/data/supervisor/conf/supervisord.conf"]
