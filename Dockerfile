FROM debian:wheezy
MAINTAINER Chris Hardekopf <cjh@ygdrasill.com>

# Install the salt-master from the official repository
ADD http://debian.saltstack.com/debian-salt-team-joehealy.gpg.key /opt/
RUN echo "deb http://debian.saltstack.com/debian wheezy-saltstack main" > \
    /etc/apt/sources.list.d/saltstack.list && \
    apt-key add /opt/debian-salt-team-joehealy.gpg.key && \
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
