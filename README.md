# Docker Laravel 11 Mysql

[English](#english-version) | [Português](#versão-em-português)

---

## Versão em Português

### Componentes

- **PHP 8.3** com Apache
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
docker-compose exec app composer create-project laravel/laravel .
docker-compose exec app cp .env.example .env
docker-compose exec app php artisan key:generate
```

4. **Configure o banco de dados no .env do Laravel**
```env
DB_CONNECTION=mysql
DB_HOST=db
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=laravel
DB_PASSWORD=secret
```

5. **Execute as migrations**
```bash
docker-compose exec app php artisan migrate
```

### Acessar Aplicações

- **Laravel**: http://localhost:8000
- **phpMyAdmin**: http://localhost:8080
  - Servidor: `db`
  - Usuário: `laravel`
  - Senha: `secret`

### Comandos Úteis

```bash
# Parar containers
docker-compose down

# Ver logs
docker-compose logs -f app

# Acessar bash do container
docker-compose exec app bash

# Executar comandos Artisan
docker-compose exec app php artisan migrate
docker-compose exec app php artisan cache:clear

# Instalar dependências
docker-compose exec app composer install
```

### Estrutura de Arquivos

```
seu-projeto/
├── docker/
│   ├── apache/
│   │   └── 000-default.conf
│   ├── php/
│   │   └── custom.ini
│   ├── mysql/
│   │   └── my.cnf
│   └── entrypoint.sh
├── Dockerfile
├── docker-compose.yml
└── .dockerignore
```

### Personalizações Opcionais

**Adicionar Redis:**
Descomente o serviço `redis` no `docker-compose.yml`

**Alterar portas:**
Modifique a seção `ports` no `docker-compose.yml`

**Ajustar permissões:**
```bash
docker-compose exec app chown -R laravel:www-data /var/www/html
docker-compose exec app chmod -R 775 storage bootstrap/cache
```

---

## English Version

### Components

- **PHP 8.3** with Apache
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
docker-compose exec app composer create-project laravel/laravel .
docker-compose exec app cp .env.example .env
docker-compose exec app php artisan key:generate
```

4. **Configure database in Laravel's .env**
```env
DB_CONNECTION=mysql
DB_HOST=db
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=laravel
DB_PASSWORD=secret
```

5. **Run migrations**
```bash
docker-compose exec app php artisan migrate
```

### Access Applications

- **Laravel**: http://localhost:8000
- **phpMyAdmin**: http://localhost:8080
  - Server: `db`
  - Username: `laravel`
  - Password: `secret`

### Useful Commands

```bash
# Stop containers
docker-compose down

# View logs
docker-compose logs -f app

# Access container bash
docker-compose exec app bash

# Run Artisan commands
docker-compose exec app php artisan migrate
docker-compose exec app php artisan cache:clear

# Install dependencies
docker-compose exec app composer install
```

### File Structure

```
your-project/
├── docker/
│   ├── apache/
│   │   └── 000-default.conf
│   ├── php/
│   │   └── custom.ini
│   ├── mysql/
│   │   └── my.cnf
│   └── entrypoint.sh
├── Dockerfile
├── docker-compose.yml
└── .dockerignore
```

### Optional Customizations

**Add Redis:**
Uncomment the `redis` service in `docker-compose.yml`

**Change ports:**
Modify the `ports` section in `docker-compose.yml`

**Fix permissions:**
```bash
docker-compose exec app chown -R laravel:www-data /var/www/html
docker-compose exec app chmod -R 775 storage bootstrap/cache
```
