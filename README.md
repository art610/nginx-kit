# Конфигурация WordPress Nginx

Данный набор файлов конфигураций для Nginx содержит best practices из различных источников, включая [WordPress Codex](https://codex.wordpress.org/Nginx) и [H5BP](https://github.com/h5bp/server-configs-nginx).

The following example sites are included:

- [multisite-subdirectory.com](sites-available/multisite-subdirectory.com) - WordPress multisite install using subdirectories
- [multisite-subdomain.com](sites-available/multisite-subdomain.com) - WordPress multisite install using subdomains
- [single-site.com](sites-available/single-site.com) - WordPress single site install
- [single-site-with-caching.com](sites-available/single-site-with-caching.com) - WordPress single site install with FastCGI caching
- [single-site-no-ssl.com](sites-available/single-site-no-ssl.com) - WordPress single site install (no SSL or page caching)

## Usage

### Site configuration

Для замены текущих файлов конфигурации Nginx следуем инструкции ниже.

Backup текущих конфигураций - копирование с изменением названий файлов, например, добавив .backup:

`sudo mv /etc/nginx /etc/nginx.backup`

Конфигурации из данного набора копируем в `/etc/nginx`.

Добавляем симлинк файлам из _sites-available_ в _sites-enabled_, что позволит активировать конфиги. Ответ сервера может быть с кодом 444.

`sudo ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default`

Копируем необходимую конфигурацию из _sites-available_ в _sites-available/yourdomain.com_:

`sudo cp /etc/nginx/sites-available/single-site.com /etc/nginx/sites-available/yourdomain.com`

Итоговую конфигурацию необходимо отредактировать, указав данные собственного сервера.

В итоге добавляем симлинк в _sites-enabled_, что позволит активировать конфигурацию:

`sudo ln -s /etc/nginx/sites-available/yourdomain.com /etc/nginx/sites-enabled/yourdomain.com`

Проверяем конфигурацию:

`sudo nginx -t`

Если всё хорошо, перезапускаем Nginx:

`sudo service nginx reload`

### Конфигурация PHP

Конфигурация php-fpm расположена в `global/php-pool.conf` и по умолчанию относится к PHP 7.4\. Дополнительно, PHP версия может быть добавлена в директории`/upstreams` (для PHP 7.3 здесь также есть пример). Также можно использовать пул по умолчанию из `$upstream`.

Например, стандартная конфигурация для `single-site.com` имеет следующие стандартные установки для php:

```
fastcgi_pass    $upstream
```

Но, для php 7.3 можно изменить её так (предполагая, что php7.3-fpm сервис уже у вас запущен).

```
fastcgi_pass    php73
```

## Структура директорий

В данном наборе конфигураций структура директорий аналогична той, что получается при стандартной установке Nginx через менеджер apt в Debian:

```
.
├── conf.d
├── global
    └── server
├── sites-available
├── sites-enabled
```

**conf.d** - конфигурации для модулей.

**global** - конфигурации внутри блока `http`.

**global/server** - конфигурации внутри блока `server`. Файл `defaults.conf` на определенных серверах может быть необходим. Дополнительные `.conf` файлы могут быть использованы по необходимости для каждого конкретного сайта.

**sites-available** - конфигурации для отдельных сайтов (виртуальных хостов / virtual hosts).

**sites-enabled** - симлинки на конфигурации из директории `sites-available` для активации. Активировать конфиг нужно только для тех сайтов, которые необходимо отдавать через NGINX.

### Рекомендованная структура для хостов

```
.
├── yourdomain1.com
    └── cache
    └── logs
    └── public
├── yourdomain2.com
    └── cache
    └── logs
    └── public
```
