# FROM php:7.2-apache
FROM php-7.2-composer:latest

ENV CUSTOM_DOCUMENT_ROOT=\/app\/public

# fix warning
# AH00558: apache2: Could not reliably determine the server's fully qualified domain name,
# using 172.17.0.2. Set the 'ServerName' directive globally to suppress this message
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

#Default document root is /var/www/html but in laravel is public
RUN sed -i "s/\/var\/www\/html/\/app\/public/g" /etc/apache2/sites-enabled/000-default.conf

RUN echo "<Directory $CUSTOM_DOCUMENT_ROOT>" >> /etc/apache2/apache2.conf
RUN echo "    Options Indexes FollowSymLinks" >> /etc/apache2/apache2.conf
RUN echo "    AllowOverride All" >> /etc/apache2/apache2.conf
RUN echo "    Require all granted" >> /etc/apache2/apache2.conf
RUN echo "</Directory>" >> /etc/apache2/apache2.conf
RUN a2enmod rewrite

# COPY DockerfileEntryPoint.sh /usr/local/bin/DockerfileEntryPoint.sh
# RUN chmod +x /usr/local/bin/DockerfileEntryPoint.sh

RUN apt-get update

#copy source code
RUN mkdir /app
COPY . /app

# use docker stage to temp installation
RUN echo "Y" | apt-get install zip unzip
RUN echo "Y" | apt-get install git

RUN cd /app && composer install
RUN cd /app && \
    php artisan migrate && \
    php artisan db:seed

# ENTRYPOINT ["DockerfileEntryPoint.sh", "apache2-foreground"]
