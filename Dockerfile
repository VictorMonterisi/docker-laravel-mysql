FROM php:8.3-apache

# Argumentos de build
ARG user=laravel
ARG uid=1000

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    unzip \
    nano \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Instalar extensões PHP necessárias para Laravel
RUN docker-php-ext-install \ 
    pdo_mysql \ 
    mbstring \ 
    exif \
    pcntl \
    bcmath \
    gd \
    zip \
    opcache

# Habilitar mod_rewrite do Apache
RUN a2enmod rewrite headers

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Criar usuário do sistema para rodar comandos do Composer e Artisan
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

# Configurar diretório de trabalho
WORKDIR /var/www/html

# Copiar configuração customizada do Apache
COPY ./docker/apache/000-default.conf /etc/apache2/sites-available/000-default.conf

# Copiar configuração customizada do PHP
COPY ./docker/php/custom.ini /usr/local/etc/php/conf.d/custom.ini

# Ajustar permissões
RUN chown -R $user:www-data /var/www/html \
    && chmod -R 775 /var/www/html/storage \
    && chmod -R 775 /var/www/html/bootstrap/cache

# Expor porta 80
EXPOSE 80

# Script de entrada
COPY ./docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["apache2-foreground"]