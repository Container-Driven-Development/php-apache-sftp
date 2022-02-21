#/bin/bash

if [ ! -f /etc/ssh/ssh_host_ed25519_key ]; then
    ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ''
fi
if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
    ssh-keygen -t rsa -b 4096 -f /etc/ssh/ssh_host_rsa_key -N ''
fi

# Restrict access from other users
chmod 600 /etc/ssh/ssh_host_ed25519_key
chmod 600 /etc/ssh/ssh_host_rsa_key
chown www-data:www-data /var/www/.ssh/authorized_keys

/usr/sbin/sshd -D -e &

/usr/local/bin/docker-php-entrypoint apache2-foreground &

tail -f /var/log/apache2/*
