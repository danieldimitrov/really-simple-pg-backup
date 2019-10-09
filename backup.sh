#!/bin/sh

#Configuration variables
BUCKET_NAME=YOUR_BUCKET_NAME #for example name of the project
FILE_NAME=YOUR_FILE_NAME #e.g. `date +%Y-%m-%d`.pgsql
DEST=YOUR_FILE_PATH #e.g. /home/daniel/$FILE_NAME
PG_USER=USER_NAME #name of the user in PG
DB_NAME=USER_NAME #name of the DB in PG

pg_dump -U $PG_USER -w -h localhost $DB_NAME > $DEST
/home/LINUX_USERNAME/.local/bin/aws s3 cp $DEST s3://$BUCKET_NAME/$FILE_NAME
rm $DEST
