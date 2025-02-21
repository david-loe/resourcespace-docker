ARG PHP_MAJOR_VERSION
FROM php:${PHP_MAJOR_VERSION}-apache

ARG RS_VERSION=10.1
ARG PHP_MAJOR_VERSION=8.1

# Use the default production configuration
RUN mv "${PHP_INI_DIR}/php.ini-production" "${PHP_INI_DIR}/php.ini"
# Configure PHP
COPY php.ini "${PHP_INI_DIR}/conf.d/resourcespace.ini"

# Installation of PHP extensions
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions apcu gd intl mysqli zip ldap exif	

# Install programs and dependencies
RUN apt-get update
RUN apt-get install -y mariadb-client poppler-utils ffmpeg imagemagick inkscape ghostscript libimage-exiftool-perl antiword subversion 

# Checkout ResourceSpace
RUN mkdir /var/www/resourcespace
RUN cd /var/www/resourcespace && svn co "http://svn.resourcespace.com/svn/rs/releases/${RS_VERSION}" .

# Set the file and folder permissions
RUN mkdir /var/www/resourcespace/filestore && chmod 777 /var/www/resourcespace/filestore
RUN chgrp -R www-data /var/www/resourcespace/
RUN chmod -R 777 /var/www/resourcespace/include

# Set up the cron job for relevance matching and periodic emails
COPY cronjob /etc/cron.daily/resourcespace

COPY apache-config.conf /etc/apache2/sites-available/000-default.conf
