<<<<<<< HEAD
FROM richarvey/nginx-php-fpm:latest

COPY . .

# Image config
ENV SKIP_COMPOSER 1
ENV WEBROOT /var/www/html/public
ENV PHP_ERRORS_STDERR 1
ENV RUN_SCRIPTS 1
ENV REAL_IP_HEADER 1

# Laravel config
ENV APP_ENV production
ENV APP_DEBUG false
ENV LOG_CHANNEL stderr

# Allow composer to run as root
ENV COMPOSER_ALLOW_SUPERUSER 1

CMD ["/start.sh"]
=======
FROM php:8.1-apache

# Install required packages
RUN apt-get update && apt-get install -y \
    libpq-dev \
    libzip-dev

# Clean sources
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install URL rewrite module
RUN a2enmod rewrite

# Install php dependencies
RUN docker-php-ext-install pdo_pgsql zip

# Copy Laravel app files
COPY . /var/www/html

# Set write permissions to used folders
RUN chown -R www-data:www-data /var/www/html /var/www/html/storage /var/www/html/bootstrap/cache

# Change working directory to Laravel app root
WORKDIR /var/www/html

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# Install Laravel dependencies
RUN composer install --no-dev --optimize-autoloader

# Expose port 80 for Apache
EXPOSE 80
>>>>>>> a6b10ac5bdbcdaf4718ec6d3d0c92d6f7798a142
