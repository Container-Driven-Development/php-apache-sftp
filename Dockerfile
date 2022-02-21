# https://github.com/docker-library/php/tree/master/8.1/bullseye/apache
FROM php:8.1.1-apache-bullseye

ENTRYPOINT ["/usr/local/bin/tini", "--", "/docker-entrypoint.sh"]

EXPOSE 36622/tcp
EXPOSE 80/tcp

# Override stopsignal https://github.com/docker-library/php/blob/master/8.1/bullseye/apache/Dockerfile#L280
# SIGWINCH is Graceful Stop https://httpd.apache.org/docs/2.2/stopping.html#gracefulstop but tini would not catch it
STOPSIGNAL SIGTERM

# Install openssh-server for sftp
RUN apt-get update && \
    apt-get -y install openssh-server && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/run/sshd && \
    rm -f /etc/ssh/ssh_host_*key*

# Add sshd config file
COPY sshd_config /etc/ssh/sshd_config

# Prepare dir for user keys
RUN mkdir /var/www/.ssh && chown -R www-data:www-data /var/www/.ssh

# Install init system see https://github.com/krallin/tini
COPY --from=krallin/ubuntu-tini:trusty /usr/local/bin/tini /usr/local/bin/tini

# Add custom entrypoint
COPY docker-entrypoint.sh /docker-entrypoint.sh
