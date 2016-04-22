FROM debian:jessie
MAINTAINER Chris Hardekopf <cjh@ygdrasill.com>

# Install the salt-master from the official repository
ADD https://repo.saltstack.com/apt/debian/8/amd64/latest/SALTSTACK-GPG-KEY.pub /opt/
RUN echo "deb http://repo.saltstack.com/apt/debian/8/amd64/latest jessie main" > \
    /etc/apt/sources.list.d/saltstack.list && \
    apt-key add /opt/SALTSTACK-GPG-KEY.pub && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y salt-master && \
    rm -rf /var/lib/apt/lists/*

# Volumes for user configuration and persistence
VOLUME [ "/etc/salt/master.d", "/etc/salt/pki", \
    "/var/cache/salt", "/srv/salt", \
    "/var/log/salt" ]

# Expose the salt master ports
EXPOSE 4505 4506

# Run the salt master by default
CMD [ "/usr/bin/salt-master" ]
