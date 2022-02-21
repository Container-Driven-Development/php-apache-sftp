#!/bin/bash

TARGET_HOST=$1

sftp -i /var/www/.ssh/id_ed25519 -oStrictHostKeyChecking=no -P36622 www-data@${TARGET_HOST} <<EOF
cd html
put index.php
quit
EOF
curl -f -I ${TARGET_HOST} && echo "\033[0;32mOK\033[0m" || echo "\033[0;31mFAIL\033[0m"