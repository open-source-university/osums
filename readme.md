OSUMS[Open Source University Management System]
==========================================

# Description
  Easy & hassle free Open Source University Management System Web Application

# Installation and use
### OSUMS is build using Laravel 5.2
```
$ git clone https://github.com/hrshadhin/osums.git
```
```
$ cd osums
```
```
$ mv .env.example .env
```
**Change configuration in .env according your need and create Database**
```
$ composer install
```
```
$ php artisan migrate
```
```
$ php artisan db:seed
```

**Give write permission to storage and bootstrap/cache directory**

```
$ php artisan serve
```
**  http://localhost:8000 **
USER: admin
PASS: demo123

# Demo Live Link
URL: http://osums.hrshadhin.me
USER: admin
PASS: demo123


# Screenshot
<img src="screenshots/1.png">
<img src="screenshots/2.png">
<img src="screenshots/3.png">
<img src="screenshots/4.png">
<img src="screenshots/6.png">
<img src="screenshots/7.png">
<img src="screenshots/8.png">
<img src="screenshots/9.png">
<img src="screenshots/10.png">
<img src="screenshots/11.png">
<img src="screenshots/12.png">
<img src="screenshots/13.png">
<img src="screenshots/14.png">
<img src="screenshots/15.png">
<img src="screenshots/16.png">



# License
OSUMS is open-sourced software licensed under the AGPL-3.0 license. Frameworks and libraries has it own licensed

Enjoy :)

# Docker

https://github.com/docker-library/php/blob/master/7.2/stretch/apache/Dockerfile

FROM php:7.2-apache

# composer installation
RUN cd /tmp && curl -sS https://getcomposer.org/installer | php
RUN cd /tmp && mv composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer


docker build --rm -t $(pwd | xargs basename) . &&\
docker rm -f $(pwd | xargs basename)-app &&\
docker run -d -p 80:80 -e "CUSTOM_DOCUMENT_ROOT=\/app\/public" --name $(pwd | xargs basename)-app $(pwd | xargs basename) && docker logs $(pwd | xargs basename)-app -f
