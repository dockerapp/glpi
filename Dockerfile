FROM php:5.6-apache
MAINTAINER dockerapp

RUN a2enmod rewrite

RUN apt-get update && apt-get install -y wget curl libjpeg-dev libpng12-dev libxml2-dev libcurl4-gnutls-dev libldap2-dev
RUN docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd mysql xmlrpc curl
RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
	&& docker-php-ext-install ldap

#RUN lhp5-mysql php5-ldap php5-xmlrpc curl php5-curl

VOLUME /var/www/html

