FROM richarvey/nginx-php-fpm
MAINTAINER Diego Najar

ENV bludit_zip https://s3.amazonaws.com/bludit-s3/bludit-builds/bludit_latest.zip

# Configurations files
ADD conf/default.conf /etc/nginx/sites-enabled/default.conf

# Bludit installation
RUN cd /tmp/; \
	wget ${bludit_zip} -o /tmp/bludit.zip; \
	unzip /tmp/bludit.zip; \
	rm -rf /var/www/html; \
	cp -r /tmp/bludit /var/www/html; \
	chown -R nginx:nginx /var/www/html*; \
	mkdir -p /var/www/html/bl-content; \
	chmod 755 /var/www/html/bl-content; \
	rm /tmp/bludit.zip; \
	rm -rf /tmp/bludit
