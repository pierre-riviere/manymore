# Test technique Symfony

## Stack

- PHP >= 8.1
- MYSQL 8.0.33
- Composer
- Symfony 6.3.1

## Notes

- Nom de la base : `manymore`
- Si besoin un dump de la base est disponible `./manymore.sql`
- Le mot de passe de tous les users est : `password`
- Login User admin : `admin@mail.com`

## Installation

```bash
composer install
symfony console doctrine:database:create
symfony console doctrine:migrations:migrate
symfony console doctrine:fixtures:load
```

## Tests

```bash
symfony console doctrine:database:create --env=test
symfony console doctrine:migrations:migrate --env=test
symfony console doctrine:fixtures:load --env=test
```

```bash
php bin/phpunit
```
