<p align="center">
    <h1 align="center">Mochapi</h1>
    <p align="center">
      <a href="https://raw.githubusercontent.com/gerardo-m/mochapi/master/LICENSE">
        <img align="center" src="https://img.shields.io/github/license/gerardo-m/mochapi" alt="Mochapi license.">
      </a>
    </p>
</p>

Mochapi is a web application that lets you mock third party APIs. The main purpose
of this application is to allow you to test your own applications that make use of 
third party APIs without relying on that third party to provide you a test environment.

## Considerations

This app is intended for internal use, so a couple of Rails default config options were
disabled, specifically:

```ruby
config.assume_ssl = false
config.force_ssl = false
```

This is to allow you to deploy in your internal network without forcing ssl

## Installation

### Prerequisites

- Docker
- xxd

### Using the installer

If you just want to install this application and have it ready to go this is the
recommended method.

```bash
wget https://github.com/gerardo-m/mochapi/releases/latest/download/mochapi.tar.gz
tar -xf mochapi.tar.gz
cd mochapi/
chmod +x installer.sh
./installer.sh
```

The installer will prompt you to set passwords for the database. After that it will
generate a secret_base_key for the rails app.

The docker-compose.yml file is set to deploy the app in the port 80 and the 
database in the port 3306, if for any reason any of those ports are already 
taken, edit the file

```yml
app:
  ports:
    - 80:80 # host:container // Change the first one if you want this in a different port
...
db:
  ports:
    - "3306:3306" # host:container // Change the first one if you want the db in a different port
```

After this is complete, you can run

```bash
docker compose up -d
```

### Install the application image only (Not the DB)

If you want to install just the application image, and use your existing instance
of MySql you can do the following:

- Make sure you have mysql server installed and allow remote connections. Check 
[This](https://www.digitalocean.com/community/tutorials/how-to-allow-remote-access-to-mysql)
for instructions
- Create the production databases
```sql
CREATE DATABASE mochapi_production;
CREATE DATABASE mochapi_production_cache;
CREATE DATABASE mochapi_production_queue;
CREATE DATABASE mochapi_production_cable;
```
- Create a user called mochapi and grant him permissions for the databases.
```sql
CREATE USER IF NOT EXISTS 'mochapi'@'172.17.0.%' IDENTIFIED BY '<password>'; --172.17.0.0/16 is the default ip ranges for docker containers
GRANT ALL PRIVILEGES ON mochapi_production.* TO 'mochapi'@'172.17.0.%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON mochapi_production_cache.* TO 'mochapi'@'172.17.0.%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON mochapi_production_queue.* TO 'mochapi'@'172.17.0.%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON mochapi_production_cable.* TO 'mochapi'@'172.17.0.%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```
- Create and .env file with the following content:
```env
DB_HOST=<your-db-host>
MOCHAPI_DATABASE_PASSWORD=<password>
SECRET_KEY_BASE=<generate-your-key-with-xxd>
```
- Pull the image
- Create and run the container
```bash
sudo docker run --env-file .env \
    -e RAILS_ENV=production \
    -e RAILS_SERVE_STATIC_FILES=true \
    -e RAILS_LOG_TO_STDOUT=true \
    -p <the-port-you-want-to-expose>:80/tcp \
    -d ger4rdo/mochapi:latest
```

That's it, your mochapi instance should be up and running on the port you exposed in the last step

## Dev Setup

## Usage

> TODO

## What's next

### v0.5.0

- Nested conditions
- Auto-save on everything
- Visual improvements

### v1.0.0

- Add variables by project
- Handle all types of variables gracefully

### Eventually

- Validate response format (json, xml...)
- Support an schema input in addition of plain text
- Data buckets, persistance
- Activity monitoring