# Docker Laravel 11 Mysql

[English](#english-version) | [Português](#versão-em-português)

---

## Versão em Português

### Componentes

- **PHP 8.4** com Apache
- **Laravel 11**
- **MySQL 8.0**
- **phpMyAdmin**

### Início Rápido

1. **Clone ou copie os arquivos para seu projeto Laravel**

2. **Inicie os containers**
```bash
docker-compose up -d --build
```

3. **Instale o Laravel** (se for projeto novo)
```bash
docker-compose exec laravel_app composer create-project laravel/laravel:^11 .
docker-compose exec laravel_app cp .env.example .env
docker-compose exec laravel_app php artisan key:generate
```

4. **Configure o banco de dados no .env do Laravel**
```env
APP_KEY=<chave_gerada>

DB_CONNECTION=mysql
DB_HOST=db
DB_PORT=3306
DB_DATABASE=laravel_db
DB_USERNAME=laravel_db_admin
DB_PASSWORD=<senha_forte>
DB_ROOT_PASSWORD=<senha_forte_para_o_root>
```

5. **Execute as migrations**
```bash
docker-compose exec laravel_app php artisan migrate
```

### Acessar Aplicações

- **Laravel**: http://localhost:8000
- **phpMyAdmin**: http://localhost:8080

### Comandos Úteis

```bash
# Parar containers
docker-compose down

# Ver logs
docker-compose logs -f laravel_app

# Acessar bash do container
docker-compose exec laravel_app bash

# Executar comandos Artisan
docker-compose exec laravel_app php artisan migrate
docker-compose exec laravel_app php artisan cache:clear

# Instalar dependências
docker-compose exec laravel_app composer install
```

### Estrutura de Arquivos

```
meu-projeto-laravel/
├── Dockerfile
├── docker-compose.yml
├── .dockerignore
├── .env
├── .env.example
├── LICENSE
├── README.md
├── docker/
│   └── apache/
│       └── laravel.conf   ← configuração do VirtualHost
└── (arquivos Laravel)
```

---

## English Version

### Components

- **PHP 8.4** with Apache
- **Laravel 11**
- **MySQL 8.0**
- **phpMyAdmin**

### Quick Start

1. **Clone or copy files to your Laravel project**

2. **Start containers**
```bash
docker-compose up -d --build
```

3. **Install Laravel** (for new projects)
```bash
docker-compose exec laravel_app composer create-project laravel/laravel:^11 .
docker-compose exec laravel_app cp .env.example .env
docker-compose exec laravel_app php artisan key:generate
```

4. **Configure database in Laravel's .env**
```env
APP_KEY=<generated_key>

DB_CONNECTION=mysql
DB_HOST=db
DB_PORT=3306
DB_DATABASE=laravel_db
DB_USERNAME=laravel_db_admin
DB_PASSWORD=<strong_password>
DB_ROOT_PASSWORD=<strong_password_for_root>
```

5. **Run migrations**
```bash
docker-compose exec laravel_app php artisan migrate
```

### Access Applications

- **Laravel**: http://localhost:8000
- **phpMyAdmin**: http://localhost:8080

### Useful Commands

```bash
# Stop containers
docker-compose down

# View logs
docker-compose logs -f laravel_app

# Access container bash
docker-compose exec laravel_app bash

# Run Artisan commands
docker-compose exec laravel_app php artisan migrate
docker-compose exec laravel_app php artisan cache:clear

# Install dependencies
docker-compose exec laravel_app composer install
```

### File Structure

```
my-laravel-project/
├── Dockerfile
├── docker-compose.yml
├── .dockerignore
├── .env
├── .env.example
├── LICENSE
├── README.md
├── docker/
│   └── apache/
│       └── laravel.conf   ← VirtualHost conf
└── (Laravel files)
```

