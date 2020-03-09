#!/bin/bash
set -e

function start {

  echo "starting php as foreground process"

  # first arg is `-f` or `--some-option`
  if [ "${1#-}" != "$1" ]; then
  	set -- /usr/local/bin/apache2-foreground "$@"
  fi

  exec "$@"

}

#Default document root is /var/www/html but in laravel is public
function set_document_root {

  echo "CUSTOM_DOCUMENT_ROOT:$CUSTOM_DOCUMENT_ROOT"

  if [ -z $CUSTOM_DOCUMENT_ROOT ]
  then
    echo "DocumentRoot will be /var/www/html"
  else
      sed -i "s/\/var\/www\/html/$CUSTOM_DOCUMENT_ROOT/g" /etc/apache2/sites-enabled/000-default.conf
  fi
}


set_document_root
start "$@"
