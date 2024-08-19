FROM centos:centos7

ENV bludit_content /usr/share/nginx/html/bl-content
ENV bludit_url https://www.bludit.com/releases/bludit-3-16-1.zip

ENV nginx_path /etc/nginx
ENV nginx_conf ${nginx_path}/nginx.conf
ENV php_conf /etc/opt/remi/php72/php.ini
ENV fpm_conf /etc/opt/remi/php72/php-fpm.conf
ENV fpm_pool /etc/opt/remi/php72/php-fpm.d/www.conf

RUN sed -i 's/mirrorlist/vault/g' /etc/yum.repos.d/CentOS-* && \
	sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN yum install -y epel-release && \
	yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm  && \
	yum-config-manager --enable remi-php72  && \
	yum -y update && \
	yum install -y nginx php72-php-fpm php72-php-gd php72-php-json php72-php-dom php72-php-xml php72-php-zip php72-php-mbstring supervisor unzip jq

# Config files
RUN sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" ${php_conf} && \
	sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 100M/g" ${php_conf} && \
	sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 100M/g" ${php_conf} && \
	sed -i -e "s/variables_order = \"GPCS\"/variables_order = \"EGPCS\"/g" ${php_conf}

RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" ${fpm_conf}

RUN sed -i -e "s/listen = 127.0.0.1:9000/listen = \/var\/run\/php-fpm.sock/g" ${fpm_pool} && \
	sed -i -e "s/;listen.owner = nobody/listen.owner = nginx/g" ${fpm_pool} && \
	sed -i -e "s/;listen.group = nobody/listen.group = nginx/g" ${fpm_pool} && \
	sed -i -e "s/user = apache/user = nginx/g" ${fpm_pool} && \
	sed -i -e "s/group = apache/group = nginx/g" ${fpm_pool}

RUN echo "daemon off;" >> ${nginx_conf}

RUN chown -R nginx:nginx /var/opt/remi/php72/lib/php

# Clean up
RUN yum clean all && \
	rm -rf ${nginx_path}/conf.d/* && \
	rm -rf /var/cache/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

# Configurations files
COPY conf/default.conf ${nginx_path}/conf.d/default.conf
COPY conf/nginx.conf ${nginx_conf}
COPY conf/supervisord.conf /etc/supervisord.conf

# Entrypoint file
COPY docker-entrypoint.sh /

# Nginx logs to Docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
	ln -sf /dev/stderr /var/log/nginx/error.log

# Bludit installation
WORKDIR /tmp
RUN curl -o /tmp/bludit.zip ${bludit_url} && \
	unzip /tmp/bludit.zip && \
	rm -rf /usr/share/nginx/html && \
	cp -r bludit /usr/share/nginx/html && \
	chown -R nginx:nginx /usr/share/nginx/html && \
	chmod 755 ${bludit_content} && \
	sed -i "s/'DEBUG_MODE', FALSE/'DEBUG_MODE', TRUE/g" /usr/share/nginx/html/bl-kernel/boot/init.php && \
	rm -f /tmp/bludit.zip

EXPOSE 80

CMD ["/docker-entrypoint.sh"]
