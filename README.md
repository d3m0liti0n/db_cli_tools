# db_cli_tools

version: 1.1.0

## Description
This is an interactive command line tool for working with databases.
It is a wrapper around the `clickhouse-cli`, `pgcli`, `mycli`, `mongosh`, `litecli` interactive CLIs.
It provides a simple interface for running queries and viewing results.

## Changelog:
- v1.1.0 Added AWS RDS IAM authentication for Postgres (pgcli) and MySQL/MariaDB (mycli): short-lived token from AWS SSO, TLS verify-full.
- v1.0.0 clickhouse client replaced with clickhouse-cli, because of lack of HTTP protocol. native client supports only native protocol, unfortunately.

## Installation
```bash
git clone https://github.com/d3m0liti0n/db_cli_tools.git && cd db_cli_tools && chmod +x install.sh && ./install.sh
```

Then you will need to prepare URIs for database connections in .env file. There is an example `env-template` file exists in this repo.

## AWS RDS IAM authentication
If `<db>_<env>_iam` is set in `.env`, the tool connects with an IAM token instead of the URI:
- checks the AWS SSO session for the given profile and runs `aws sso login` if it expired;
- generates a fresh token (valid 15 minutes) on every connect;
- connects to the instance endpoint (not RDS Proxy) with full TLS verification using `RDS_CA_BUNDLE`.

Requirements: AWS CLI v2 with an SSO profile, a permission set allowing `rds-db:connect`, and the combined CA bundle:
```bash
curl -s https://truststore.pki.rds.amazonaws.com/eu-west-1/eu-west-1-bundle.pem \
        https://www.amazontrust.com/repository/AmazonRootCA1.pem > ~/.aws/rds-eu-west-1-combined.pem
```
If the connection drops after 15 minutes, pgcli/mycli can't reconnect with the old token: exit and reconnect from the menu.

## Usage
```bash
./db.sh             starts the interactive CLI tool
```
```bash
./db.sh --help      shows the help message
```
```bash
./db.sh --version   shows the version of the tool
```

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
