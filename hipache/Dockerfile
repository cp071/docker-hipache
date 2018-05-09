FROM lvo9/hipache

COPY config.json /usr/local/lib/node_modules/hipache/config

COPY ssl /etc/ssl
RUN if [ -e /etc/ssl/*key* ]; then chmod 600 /etc/ssl/*key*; fi