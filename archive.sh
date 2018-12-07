#!/bin/sh
cd /
echo "=> Creating archive"
tar -zcvf tmp/$S3_BACKUP_NAME-`date "+%Y-%m-%d_%H-%M-%S"`.tar.gz backup