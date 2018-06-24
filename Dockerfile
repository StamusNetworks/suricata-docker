FROM debian:latest

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget gnupg
COPY stamus-packages.list /etc/apt/sources.list.d/
RUN wget -O - -q http://packages.stamus-networks.com/packages.stamus-networks.com.gpg.key | apt-key add -
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y suricata supervisor python-pyinotify psmisc ethtool
COPY supervisor.d/* /etc/supervisor/conf.d/
COPY suri_reloader /usr/local/sbin/suri_reloader
RUN chmod +x /usr/local/sbin/suri_reloader
RUN mkdir /var/run/suricata/

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
