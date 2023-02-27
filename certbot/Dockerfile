FROM certbot/dns-digitalocean:v2.3.0

RUN set -e; \
    \
    touch crontab.tmp; \
    echo '0 */12 * * * certbot -q renew' > crontab.tmp; \
    crontab crontab.tmp; \
    rm -rf crontab.tmp

COPY entrypoint.sh /usr/bin/

ENTRYPOINT ["entrypoint.sh"]
