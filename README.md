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

```bash
wget https://github.com/gerardo-m/mochapi/releases/latest/download/mochapi.tar.gz
tar -xf mochapi.tar.gz
cd mochapi/
chmod +x installer.sh
./installer.sh
```

This will prompt you to set passwords for the database. After that it will
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

## Usage

> TODO

## What's next

### v0.3.0

- Insert variables from body and headers in responses

### v1.0.0

- Support headers
- Highlight response's code
- Add variables by project

### Eventually

- Validate response format (json, xml...)
- Add conditions (therefore multiple responses per endpoint)
- Support an schema input in addition of plain text
- Data buckets, persistance
- Activity monitoring