# Really simple pg backup

## Motivation

Find a very simple backup solution for PostgreSQL still seems as big problem in these days. We wanted a solution that is:

1. Very simple & easy to maintain.
2. Could work very well on smaller projects and with small databases.
3. Using a simple pg_dump and instead of leaving a dump file on a server, automatically moves it to AWS S3.

## Installation

### 1. Install AWS CLI

1. Install AWS CLI, more info in official guide [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html).

2. Configure AWS profile:
```
AWS Access Key ID [None]: <your access key>
AWS Secret Access Key [None]: <your secret key>
Default region name [None]: <your region name (for example: eu-central-1)>
```

3. Test configuration by listing buckets `aws s3 ls`. If you get access denied then double check permissions of your IAM user.

### 2. Move password to .pgpass file

In home directory:
```
touch .pgpass
chmod 0600 .pgpass
vim .pgpass
```

And then add to .pgpass file info in this format (port is by default 5432):
```
server:port:database:username:password
```

### 3. Script

1. Copy this repository to home repository on the server.
2. Edit "Configuration variables" section in `backup.sh`.
3. Run ```chmod +x backup.sh``` to give the script execution authorization.

### 4. Crontab

Edit via `crontab -e` on last line:
```
10 23 * * * sh -c "/PATH_TO_SCRIPT/backup.sh"
```

## Restore

### 1. Download backup from S3 to server

### 2. Restore backup
```
psql -U USERNAME -W -h localhost DB_NAME < FILE_NAME.psql
```