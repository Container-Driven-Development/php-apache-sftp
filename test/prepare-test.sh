#!/bin/bash

ssh-keygen -t ed25519 -C "fake@example.com" -f /var/www/.ssh/id_ed25519 -P ""
cp /var/www/.ssh/id_ed25519.pub /var/www/.ssh/authorized_keys
chown -R www-data:www-data /var/www/.ssh