#!/bin/sh

# Initialize themes and plugins directories
theme_dir=/usr/share/nginx/html/bl-themes
plugin_dir=/usr/share/nginx/html/bl-plugins

if [ -z "$(ls -A $theme_dir)" ]; then
  echo "bl-themes directory is empty, initializing..."
  cp -r /tmp/bludit-backup/bl-themes/* $theme_dir
  chown -R nginx:nginx $theme_dir
else
  echo "bl-themes directory is not empty, skipping..."
fi

if [ -z "$(ls -A $plugin_dir)" ]; then
  echo "bl-plugins directory is empty, initializing..."
  cp -r /tmp/bludit-backup/bl-plugins/* $plugin_dir
  chown -R nginx:nginx $plugin_dir
else
  echo "bl-plugins directory is not empty, skipping..."
fi

# Start PHP-FPM and Nginx
php-fpm &
nginx -g "daemon off;"
