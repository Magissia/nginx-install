#!/bin/sh
echo "By running this script, you have agreed and understood to anything you may have to agree to before running it, like license and stuff"
mkdir -p /var/{cache/{nginx/tmp,nginx/cached},lib/nginx/{body,proxy,fastcgi},log/nginx/}
mkdir -p /etc/nginx/{conf.d,sites-available,sites-enabled}

echo "Creating service user and management group"
	groupadd -g 750 -r nginx
	useradd -c nginx -d /etc/nginx -M -r -s /bin/false -u 750 -g nginx nginx
	
git clone https://github.com/nginx/nginx.git ~/src/nginx
cp ~/src/nginx/auto/configure ~/src/nginx/

cd ~/src/nginx/configure #We must cd to the directory or configure will fail to find "auto/options"
~/src/nginx/auto/configure \
	--prefix=/etc/nginx \
	--sbin-path=/usr/sbin/nginx \
	--conf-path=/etc/nginx/nginx.conf \
	--error-log-path=/var/log/nginx/error.log \
	--http-log-path=/var/log/nginx/access.log \
	--pid-path=/var/run/nginx.pid \
	--lock-path=/var/run/nginx.lock \
	--http-client-body-temp-path=/var/cache/nginx/client_temp \
	--http-proxy-temp-path=/var/cache/nginx/proxy_temp \
	--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
	--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
	--http-scgi-temp-path=/var/cache/nginx/scgi_temp \
	--user=nginx \
	--group=nginx \
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
	--with-http_stub_status_module \
	--with-http_auth_request_module \
	--with-threads \
	--with-stream \
	--with-stream_ssl_module \
	--with-http_slice_module \
	--with-mail \
	--with-mail_ssl_module \
	--with-file-aio \
	--with-http_v2_module \
	--with-ipv6 \
	--with-pcre \
	--with-http_degradation_module 