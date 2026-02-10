#!/bin/bash
set -e

# Aguardar MySQL estar pronto
until nc -z db 3306; do
  sleep 1
done

# Cria o arquivo padrão de log
touch /var/www/html/storage/laravel.log

# Ajustar permissões essenciais
chown -R laravel:www-data /var/www/html
chmod -R 775 /var/www/html/storage 2>/dev/null || true
chmod -R 775 /var/www/html/bootstrap/cache 2>/dev/null || true

# Executar comando do container
exec "$@"