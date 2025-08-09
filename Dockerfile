FROM php:8.2-fpm-alpine

# Set environment variables
ENV bludit_content /usr/share/nginx/html/bl-content
ENV bludit_url https://www.bludit.com/releases/bludit-3-16-2.zip

# Install required packages
RUN apk add --no-cache nginx curl unzip bash

# Configure PHP
RUN docker-php-ext-install opcache

# Install gd PHP module
RUN apk add --no-cache libpng-dev libjpeg-turbo-dev freetype-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd

# Configure Nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/default.conf /etc/nginx/conf.d/default.conf

# Bludit installation
WORKDIR /tmp
RUN curl -o bludit.zip ${bludit_url} && \
    unzip bludit.zip && \
    rm -rf /usr/share/nginx/html && \
    mv bludit /usr/share/nginx/html && \
    chown -R www-data:www-data /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html && \
    sed -i "s/'DEBUG_MODE', FALSE/'DEBUG_MODE', TRUE/g" /usr/share/nginx/html/bl-kernel/boot/init.php && \
    rm -f bludit.zip

# Copy entrypoint script
COPY docker-entrypoint.sh /

# Make entrypoint executable
RUN chmod +x /docker-entrypoint.sh

# Expose port 80
EXPOSE 80

# Start Nginx and PHP-FPM
CMD ["/docker-entrypoint.sh"]
