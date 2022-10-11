#!/bin/sh

theme_dir=/usr/share/nginx/html/bl-themes
plugin_dir=/usr/share/nginx/html/bl-plugins

if [[ "$(ls $theme_dir)" ]]; then
  echo "bl-themes directory is not empty, skipping..."
else
  echo "bl-themes directory is empty, initializing..."
  echo "Copying theme files to $theme_dir"
  cp -r /tmp/bludit-*/bl-themes/* $theme_dir
  chown -R nginx. $theme_dir
fi

if [[ "$(ls $plugin_dir)" ]]; then
  echo "bl-plugins directory is not empty, skipping..."
else
  echo "bl-plugins directory is empty, initializing..."
  echo "Copying plugin files to $plugin_dir"
  cp -r /tmp/bludit-*/bl-plugins/* $plugin_dir
  chown -R nginx. $plugin_dir
fi

rm -rf /tmp/bludit-*
exec /usr/bin/supervisord -n -c /etc/supervisord.conf
