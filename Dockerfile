# Gunakan gambar resmi PHP 8
FROM php:8.0.30-fpm

# Instal dependensi yang diperlukan
RUN apt-get update && \
    apt-get install -y \
    libzip-dev \
    unzip \
    libonig-dev \
    libxml2-dev

# Instal ekstensi PHP yang diperlukan
RUN docker-php-ext-install pdo_mysql zip mbstring exif pcntl bcmath opcache

# Instal Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set direktori kerja
WORKDIR /var/www/html

# Salin file Composer dan file lainnya yang diperlukan
COPY composer.json composer.lock ./
# RUN composer install --no-scripts --no-autoloader

# Salin seluruh proyek Laravel
COPY . .

# Generate autoload file dan cache
# RUN composer dump-autoload --optimize
# RUN php artisan config:cache
# RUN php artisan route:cache

# Berikan hak akses yang sesuai
RUN chown -R www-data:www-data storage bootstrap/cache

# Set permissions agar storage dan cache dapat ditulis
RUN chmod -R 775 storage bootstrap/cache

# Expose port yang akan digunakan
EXPOSE 8000

RUN composer install --ignore-platform-reqs
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
