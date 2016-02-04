FROM php:5.6-apache
MAINTAINER dockerapp

RUN a2enmod rewrite

RUN apt-get update && apt-get install -y wget curl libjpeg-dev libpng12-dev libxml2-dev libcurl4-gnutls-dev libldap2-dev
RUN docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd mysql mysqli xmlrpc curl mbstring
RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
	&& docker-php-ext-install ldap
WORKDIR "/var/www/html"
RUN wget https://github.com/glpi-project/glpi/releases/download/0.90.1/glpi-0.90.1.tar.gz \
	&& tar xvfz *.tar.gz && rm -f *.tar.gz \
	&& chown www-data /var/www/html/glpi/config \
	&& chown www-data /var/www/html/glpi/files \
	&& chown www-data /var/www/html/glpi/files/_dumps \
	&& chown www-data /var/www/html/glpi/files/_sessions \
	&& chown www-data /var/www/html/glpi/files/_cron \
	&& chown www-data /var/www/html/glpi/files/_graphs \
	&& chown www-data /var/www/html/glpi/files/_lock \
        && chown www-data /var/www/html/glpi/files/_plugins \
        && chown www-data /var/www/html/glpi/files/_tmp \
        && chown www-data /var/www/html/glpi/files/_rss \
        && chown www-data /var/www/html/glpi/files/_uploads \
        && chown www-data /var/www/html/glpi/files/_pictures \
        && chown www-data /var/www/html/glpi/files/_log
WORKDIR "/var/www/html/glpi/plugins"
RUN apt-get install -y git
RUN wget https://forge.glpi-project.org/attachments/download/2114/glpi-ocsinventoryng-1.2.1.tar.gz && tar xfvz *.tar.gz && rm -f *tar.gz \
	&& wget https://forge.glpi-project.org/attachments/download/2101/glpi-reports-1.9.0.tar.gz && tar xvfz *.tar.gz && rm -f *.tar.gz \
	&& git clone https://github.com/pluginsGLPI/fields.git && chown -R www-data /var/www/html/glpi/plugins/fields \
	&& git clone https://github.com/InfotelGLPI/racks.git \
	&& git clone https://github.com/pluginsGLPI/connections.git \
	&& git clone https://github.com/pluginsGLPI/formcreator.git \
	&& git clone https://github.com/pluginsGLPI/mreporting.git
 

VOLUME /var/www/html

