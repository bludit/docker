#!/bin/sh

# Initialize themes and plugins directories
theme_dir=/usr/share/nginx/html/bl-themes
plugin_dir=/usr/share/nginx/html/bl-plugins

if [ -z "$(ls -A $theme_dir)" ]; then
  echo "bl-themes directory is empty, initializing..."
  cp -r /tmp/bludit-backup/bl-themes/* $theme_dir
  chown -R www-data:www-data $theme_dir
else
  echo "bl-themes directory is not empty, skipping..."
fi

if [ -z "$(ls -A $plugin_dir)" ]; then
  echo "bl-plugins directory is empty, initializing..."
  cp -r /tmp/bludit-backup/bl-plugins/* $plugin_dir
  chown -R www-data:www-data $plugin_dir
else
  echo "bl-plugins directory is not empty, skipping..."
fi

# Ensure correct ownership of web root
chown -R www-data:www-data /usr/share/nginx/html

# Start PHP-FPM and Nginx
php-fpm &
nginx -g "daemon off;"
