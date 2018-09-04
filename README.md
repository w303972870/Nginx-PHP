```
docker pull registry.cn-hangzhou.aliyuncs.com/server_repertory/php:latest
```
### 日志目录：/data/php/logs
### 默认php-fpm.conf：/etc/php7/php-fpm.conf
### 默认www.conf：/etc/php7/php-fpm.d/www.conf
### 默认php.ini：/etc/php7/php.ini
### 默认缓存目录：/data/php/tmp/


### 开放端口：9000

```
docker run -dit -p 9000:9000 --net host -v /data/htdocs:/data/htdocs -v /data/php/logs:/data/php/logs -v /data/php/etc/php-fpm.d/www.conf:/etc/php7/php-fpm.d/www.conf registry.cn-hangzhou.aliyuncs.com/server_repertory/php:latest
```

		**已安装和支持模块扩展**
```
[PHP Modules]
amqp
bcmath
bz2
Core
ctype
curl
date
dba
dom
enchant
event
exif
fileinfo
filter
ftp
gd
gettext
gmp
hash
iconv
**imagick**
intl
json
ldap
libxml
mbstring
mcrypt
**memcached**
**mongodb**
mysqli
mysqlnd
openssl
pcntl
pcre
PDO
pdo_mysql
pdo_sqlite
Phar
posix
readline
**redis**
Reflection
session
shmop
soap
sockets
sodium
SPL
sqlite3
standard
sysvsem
tokenizer
wddx
xml
xmlreader
xmlrpc
xmlwriter
xsl
yaml
Zend OPcache
zip
zlib
zmq

[Zend Modules]
Zend OPcache
```

		**编译参数**
```
Configure Command =>  

./configure
--build=x86_64-alpine-linux-musl
--host=x86_64-alpine-linux-musl
--prefix=/usr
--program-suffix=7
--libdir=/usr/lib/php7
--datadir=/usr/share/php7
--sysconfdir=/etc/php7
--localstatedir=/var
--with-layout=GNU
--with-pic
--with-pear=/usr/share/php7
--with-config-file-path=/etc/php7
--with-config-file-scan-dir=/etc/php7/conf.d
--disable-short-tags
--enable-bcmath=shared
--with-bz2=shared
--enable-calendar=shared
--enable-ctype=shared
--with-curl=shared
--enable-dba=shared
--with-db4
--with-dbmaker=shared
--with-gdbm
--enable-dom=shared
--with-enchant=shared
--enable-exif=shared
--enable-fileinfo=shared
--enable-ftp=shared
--with-gd=shared
--with-freetype-dir=/usr
--disable-gd-jis-conv
--with-jpeg-dir=/usr
--with-png-dir=/usr
--with-webp-dir=/usr
--with-xpm-dir=/usr
--with-gettext=shared
--with-gmp=shared
--with-iconv=shared
--with-imap=shared
--with-imap-ssl
--with-icu-dir=/usr
--enable-intl=shared
--enable-json=shared
--with-kerberos
--with-ldap=shared
--with-ldap-sasl
--with-libedit
--enable-libxml
--with-libxml-dir=/usr
--enable-mbstring=shared
--with-mysqli=shared,mysqlnd
--with-mysql-sock=/run/mysqld/mysqld.sock
--enable-mysqlnd=shared
--enable-opcache=shared
--with-openssl=shared
--with-system-ciphers
--enable-pcntl=shared
--with-pcre-regex=/usr
--enable-pdo=shared
--with-pdo-dblib=shared
--with-pdo-mysql=shared,mysqlnd
--with-pdo-odbc=shared,unixODBC,/usr
--with-pdo-pgsql=shared
--with-pdo-sqlite=shared,/usr
--with-pgsql=shared
--enable-phar=shared
--enable-posix=shared
--with-pspell=shared
--without-readline
--with-recode=shared
--enable-session=shared
--enable-shmop=shared
--enable-simplexml=shared
--with-snmp=shared
--enable-soap=shared
--with-sodium=shared
--enable-sockets=shared
--with-sqlite3=shared,/usr
--enable-sysvmsg=shared
--enable-sysvsem=shared
--enable-sysvshm=shared
--with-tidy=shared
--enable-tokenizer=shared
--with-unixODBC=shared,/usr
--enable-wddx=shared
--enable-xml=shared
--enable-xmlreader=shared
--with-xmlrpc=shared
--enable-xmlwriter=shared
--with-xsl=shared
--enable-zip=shared
--with-libzip=/usr
--with-zlib
--with-zlib-dir=/usr
--disable-phpdbg
--enable-fpm
--enable-embed
--with-litespeed
build_alias=x86_64-alpine-linux-musl
host_alias=x86_64-alpine-linux-musl
```

		**默认的php.ini**

```
[PHP]
engine = On
short_open_tag = On
precision = 14
output_buffering = 4096
zlib.output_compression = Off
implicit_flush = Off
unserialize_callback_func =
serialize_precision = -1
disable_functions =
disable_classes =
zend.enable_gc = On
expose_php = On
max_execution_time = 30
max_input_time = 60
memory_limit = 128M
error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT
display_errors = Off
display_startup_errors = Off
log_errors = On
log_errors_max_len = 1024
ignore_repeated_errors = Off
ignore_repeated_source = Off
report_memleaks = On
html_errors = On
error_log = /data/php/logs/php_errors.log
variables_order = "GPCS"
request_order = "GP"
register_argc_argv = Off
auto_globals_jit = On
post_max_size = 100M
auto_prepend_file =
auto_append_file =
default_mimetype = "text/html"
default_charset = "UTF-8"
include_path = ".:/usr/share/php7"
doc_root =
user_dir =
enable_dl = Off
file_uploads = On
upload_max_filesize = 50M
max_file_uploads = 200
allow_url_fopen = On
allow_url_include = Off
default_socket_timeout = 60
[CLI Server]
cli_server.color = On
[Date]
date.timezone = Asia/Shanghai
[filter]
[iconv]
[intl]
[sqlite3]
[Pcre]
[Pdo]
[Pdo_mysql]
pdo_mysql.cache_size = 2000
pdo_mysql.default_socket=
[Phar]
[mail function]
SMTP = localhost
smtp_port = 25
mail.add_x_header = Off
[ODBC]
odbc.allow_persistent = On
odbc.check_persistent = On
odbc.max_persistent = -1
odbc.max_links = -1
odbc.defaultlrl = 4096
odbc.defaultbinmode = 1
[Interbase]
ibase.allow_persistent = 1
ibase.max_persistent = -1
ibase.max_links = -1
ibase.timestampformat = "%Y-%m-%d %H:%M:%S"
ibase.dateformat = "%Y-%m-%d"
ibase.timeformat = "%H:%M:%S"
[MySQLi]
mysqli.max_persistent = -1
mysqli.allow_persistent = On
mysqli.max_links = -1
mysqli.cache_size = 2000
mysqli.default_port = 3306
mysqli.default_socket =
mysqli.default_host =
mysqli.default_user =
mysqli.default_pw =
mysqli.reconnect = Off
[mysqlnd]
mysqlnd.collect_statistics = On
mysqlnd.collect_memory_statistics = Off
[OCI8]
[PostgreSQL]
pgsql.allow_persistent = On
pgsql.auto_reset_persistent = Off
pgsql.max_persistent = -1
pgsql.max_links = -1
pgsql.ignore_notice = 0
pgsql.log_notice = 0
[bcmath]
bcmath.scale = 0
[browscap]
[Session]
session.save_handler = files
session.use_strict_mode = 0
session.use_cookies = 1
session.use_only_cookies = 1
session.name = PHPSESSID
session.auto_start = 0
session.cookie_lifetime = 0
session.cookie_path = /
session.cookie_domain =
session.cookie_httponly =
session.serialize_handler = php
session.gc_probability = 1
session.gc_divisor = 1000
session.gc_maxlifetime = 1440
session.referer_check =
session.cache_limiter = nocache
session.cache_expire = 180
session.use_trans_sid = 0
session.sid_length = 26
session.trans_sid_tags = "a=href,area=href,frame=src,form="
session.sid_bits_per_character = 5
[Assertion]
zend.assertions = -1
[COM]
[mbstring]
[gd]
[exif]
[Tidy]
tidy.clean_output = Off
[soap]
soap.wsdl_cache_enabled=1
soap.wsdl_cache_dir="/tmp"
soap.wsdl_cache_ttl=86400
soap.wsdl_cache_limit = 5
[sysvshm]
[ldap]
ldap.max_links = -1
[dba]
[opcache]
opcache.enable_cli=1
opcache.file_cache=/data/php/tmp/
[curl]
[openssl]
```


		**默认的php-fpm.conf**

```
[global]
pid = run/php-fpm7.pid
daemonize = no
include=/etc/php7/php-fpm.d/*.conf
```

		**默认的php-fpm.d/www.conf**

```
[www]
user = nobody
group = nobody
listen = 9000
pm = dynamic
pm.max_children = 5
pm.start_servers = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 3
```
