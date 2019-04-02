# Alpine Nginx Image

![https://www.augustash.com](http://augustash.s3.amazonaws.com/logos/ash-inline-color-500.png)

**This base container is not currently aimed at public consumption. It exists as a starting point for August Ash containers.**

## Versions

- `3.0.0`, `latest` [(Dockerfile)](https://github.com/augustash/docker-alpine-nginx/blob/3.0.0/Dockerfile)
- `2.0.0` [(Dockerfile)](https://github.com/augustash/docker-alpine-nginx/blob/2.0.0/Dockerfile)
- `1.0.2` [(Dockerfile)](https://github.com/augustash/docker-alpine-nginx/blob/1.0.2/Dockerfile)
- `1.0.1` [(Dockerfile)](https://github.com/augustash/docker-alpine-nginx/blob/1.0.1/Dockerfile)
- `1.0.0` [(Dockerfile)](https://github.com/augustash/docker-alpine-nginx/blob/1.0.0/Dockerfile)

[See VERSIONS.md for image contents.](https://github.com/augustash/docker-alpine-nginx/blob/master/VERSIONS.md)

## Usage

Launch a single-use Nginx container serving the current directory:

```bash
docker run --rm \
    -p 8080:80 \
    -p 8443:443 \
    -v $(pwd):/src \
    augustash/alpine-nginx
```

### Accessing Served Content

Ports `80` and `443` are exposed via this image. To access the Nginx web server from outside the container, you'll need to map ports on your host to the container.

This container works best in combination with our [PHP-FPM](https://github.com/augustash/docker-alpine-phpfpm) container so that dynamic content can be served.

**Note:** If your PHP-FPM container was started with `docker-compose` and has a network, you'll need to link it differently:

```bash
docker run --rm \
    -p 8080:80 \
    -p 8443:443 \
    --link <PHP CONTAINER>:phpfpm \
    --net <NETWORK NAME> \
    -v $(pwd)/site.template:/config/nginx/hosts.d/site.conf \
    -v $(pwd):/src \
    augustash/alpine-nginx
```

### HTML Content

The content served by this container lives in the `/src` directory. You can customize what will be served by mounting a host directory to `/src`.

### Nginx Configuration and Host Configuration

The image is prepared in a way to make it relatively easy to customize both Nginx itself and the hosts.

Custom Nginx configuration should be added to `/etc/nginx/conf.d/` and custom host files should be added to `/etc/nginx/hosts.d/`.

The structure of the directory should look like:

```bash
/config/nginx
├── conf.d
│   ├── 10-mime.conf
│   ├── 20-logs.conf
│   ├── 30-gzip.conf
│   ├── 40-general.conf
│   └── 50-ssl.conf
├── hosts.d
│   └── default.conf
└── nginx.conf
```

### User/Group Identifiers

To help avoid nasty permissions errors, the container allows you to specify your own `PUID` and `PGID`. This can be a user you've created or even root (not recommended).

### Environment Variables

The following variables can be set and will change how the container behaves. You can use the `-e` flag, an environment file, or your Docker Compose file to set your preferred values. The default values are shown:

- `PUID`=501
- `PGID`=1000
- `NGINX_SSL_SUBJECT`=/C=US/ST=MN/L=Minneapolis/O=August Ash/OU=Local Server/CN=*
- `NGINX_DH_SIZE`=2048

## Inspiration

- [fballiano](https://github.com/fballiano/)
- [joshporter](https://github.com/joshporter)
- [meanbee](https://github.com/meanbee/)
