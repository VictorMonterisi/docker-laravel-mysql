FROM php:8.3-apache

# Define o diretório de trabalho
WORKDIR /var/www/html

# Instala as dependências do sistema
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    unzip \
    nodejs \
    npm \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

# Configura e instala extensões do PHP necessárias para o Laravel
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
 && docker-php-ext-install -j$(nproc) \
    pdo_mysql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd \
    zip

# Instala o Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Habilita o mod_rewrite do Apache
RUN a2enmod rewrite

# Configura o Apache para apontar para o diretório public do Laravel
ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Configura as permissões de desenvolvimento
ARG USER_ID=1000
ARG GROUP_ID=1000
RUN usermod -u ${USER_ID} www-data && \
    groupmod -g ${GROUP_ID} www-data

# Abre a porta 80
EXPOSE 80

# Executa um script inline para configurar as permissões e iniciar o Apache
CMD bash -c " \
    sleep 2 && \
    chown -R www-data:www-data /var/www/html && \
    find /var/www/html -type f -exec chmod 644 {} \; && \
    find /var/www/html -type d -exec chmod 755 {} \; && \
    [ -d '/var/www/html/storage' ] && chmod -R 775 /var/www/html/storage && chown -R www-data:www-data /var/www/html/storage; \
    [ -d '/var/www/html/bootstrap/cache' ] && chmod -R 775 /var/www/html/bootstrap/cache && chown -R www-data:www-data /var/www/html/bootstrap/cache; \
    exec apache2-foreground \
"
