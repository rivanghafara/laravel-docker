FROM dimaskiddo/debian:php-7.4-nginx-novol

WORKDIR /var/www/html

USER root

COPY composer.* ./

RUN composer install --no-scripts --no-autoloader

COPY . .

RUN cp .env.example .env \
    && composer dump-autoload --optimize \
    && find . -type d -exec chmod 775 {} \; \
    && find . -type f -exec chmod 664 {} \; \
    && php artisan key:generate \
    && sed -i -e "s|/var/www/html|/var/www/html/public|g" \
       /usr/local/docker/etc/nginx/sites-available/default

USER user

