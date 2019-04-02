FROM augustash/alpine-base-s6:4.0.0

# envrionment
ENV NGINX_DH_SIZE 2048
ENV NGINX_SSL_SUBJECT /C=US/ST=MN/L=Minneapolis/O=August Ash/OU=Local Server/CN=*

# packages & configure
RUN apk-install nginx \
    && mkdir -p \
        /etc/nginx/conf.d \
        /etc/nginx/hosts.d \
        /etc/nginx/keys \
        /socket \
        /var/lib/nginx \
    && rm -rf /etc/nginx/conf.d/* /etc/nginx/nginx.conf /var/lib/nginx/run \
    && chown -R "${PUID}:${PGID}" /socket \
    && apk-cleanup

# copy root filesystem
COPY rootfs /

# external
EXPOSE 80 443
WORKDIR /src

# run s6 supervisor
ENTRYPOINT ["/init"]
